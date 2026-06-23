import { createClient } from "npm:@supabase/supabase-js@2";

type NotificationRecord = {
  id: string;
  recipient_id: string;
  title_ar: string;
  title_en: string;
  body_ar: string | null;
  body_en: string | null;
  payload: Record<string, unknown>;
};

type WebhookBody = {
  type?: string;
  table?: string;
  record?: NotificationRecord;
};

type ServiceAccount = {
  project_id: string;
  client_email: string;
  private_key: string;
  token_uri?: string;
};

function loadServiceAccount(): ServiceAccount | null {
  const raw = Deno.env.get("FIREBASE_SERVICE_ACCOUNT_JSON");
  if (!raw) {
    return null;
  }
  try {
    const sa = JSON.parse(raw) as ServiceAccount;
    if (!sa.project_id || !sa.client_email || !sa.private_key) {
      return null;
    }
    return sa;
  } catch {
    return null;
  }
}

function pickBody(record: NotificationRecord): string {
  return (record.body_en ?? record.body_ar ?? "").slice(0, 200);
}

function base64Url(input: ArrayBuffer | string): string {
  const bytes = typeof input === "string"
    ? new TextEncoder().encode(input)
    : new Uint8Array(input);
  let binary = "";
  for (const byte of bytes) {
    binary += String.fromCharCode(byte);
  }
  return btoa(binary).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
}

function pemToPkcs8(pem: string): ArrayBuffer {
  const base64 = pem
    .replace(/-----BEGIN PRIVATE KEY-----/, "")
    .replace(/-----END PRIVATE KEY-----/, "")
    .replace(/\s+/g, "");
  const binary = atob(base64);
  const buffer = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) {
    buffer[i] = binary.charCodeAt(i);
  }
  return buffer.buffer;
}

/// Mints a short-lived OAuth2 access token for FCM using the service account
/// (RS256-signed JWT exchanged at the Google token endpoint). Uses Web Crypto
/// + fetch only, so it works in the Deno-based Supabase Edge runtime (unlike
/// firebase-admin, whose node:http2 transport is unsupported there).
async function getAccessToken(sa: ServiceAccount): Promise<string> {
  const tokenUri = sa.token_uri ?? "https://oauth2.googleapis.com/token";
  const now = Math.floor(Date.now() / 1000);
  const header = base64Url(JSON.stringify({ alg: "RS256", typ: "JWT" }));
  const claims = base64Url(JSON.stringify({
    iss: sa.client_email,
    scope: "https://www.googleapis.com/auth/firebase.messaging",
    aud: tokenUri,
    iat: now,
    exp: now + 3600,
  }));
  const unsigned = `${header}.${claims}`;

  const key = await crypto.subtle.importKey(
    "pkcs8",
    pemToPkcs8(sa.private_key),
    { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
    false,
    ["sign"],
  );
  const signature = await crypto.subtle.sign(
    "RSASSA-PKCS1-v1_5",
    key,
    new TextEncoder().encode(unsigned),
  );
  const jwt = `${unsigned}.${base64Url(signature)}`;

  const response = await fetch(tokenUri, {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
      assertion: jwt,
    }),
  });
  const json = await response.json();
  if (!response.ok || !json.access_token) {
    throw new Error(`OAuth token error: ${JSON.stringify(json)}`);
  }
  return json.access_token as string;
}

Deno.serve(async (req) => {
  if (req.method !== "POST") {
    return new Response("Method not allowed", { status: 405 });
  }

  const expectedSecret = Deno.env.get("PUSH_WEBHOOK_SECRET");
  if (expectedSecret) {
    const provided = req.headers.get("x-push-secret");
    if (provided !== expectedSecret) {
      return new Response(JSON.stringify({ error: "Invalid push secret" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }
  }

  const serviceAccount = loadServiceAccount();
  if (!serviceAccount) {
    return new Response(
      JSON.stringify({ ok: true, skipped: "FCM not configured" }),
      { status: 200, headers: { "Content-Type": "application/json" } },
    );
  }

  let body: WebhookBody;
  try {
    body = await req.json();
  } catch {
    return new Response(JSON.stringify({ error: "Invalid JSON" }), {
      status: 400,
      headers: { "Content-Type": "application/json" },
    });
  }

  const record = body.record;
  if (!record?.recipient_id) {
    return new Response(JSON.stringify({ error: "Missing record" }), {
      status: 400,
      headers: { "Content-Type": "application/json" },
    });
  }

  const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
  const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
  const supabaseAdmin = createClient(supabaseUrl, serviceKey);

  const { data: tokenRows, error: tokenError } = await supabaseAdmin
    .from("device_tokens")
    .select("token")
    .eq("profile_id", record.recipient_id);

  if (tokenError) {
    return new Response(JSON.stringify({ error: tokenError.message }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }

  const tokens = (tokenRows ?? []).map((row) => row.token as string).filter(
    Boolean,
  );

  if (tokens.length === 0) {
    return new Response(
      JSON.stringify({ ok: true, sent: 0, reason: "no_device_tokens" }),
      { status: 200, headers: { "Content-Type": "application/json" } },
    );
  }

  const payload = record.payload ?? {};
  const route = typeof payload.route === "string" ? payload.route : "";
  const id = typeof payload.id === "string" ? payload.id : "";

  let accessToken: string;
  try {
    accessToken = await getAccessToken(serviceAccount);
  } catch (error) {
    const messageText = error instanceof Error ? error.message : "OAuth failed";
    return new Response(JSON.stringify({ error: messageText }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }

  const endpoint =
    `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`;
  const title = record.title_en || record.title_ar;
  const bodyText = pickBody(record);

  let sent = 0;
  let failed = 0;
  const errors: string[] = [];

  // FCM HTTP v1 sends one message per request; loop over device tokens.
  await Promise.all(tokens.map(async (token) => {
    const message = {
      message: {
        token,
        notification: { title, body: bodyText },
        data: { route, id, notification_id: record.id },
        android: { priority: "HIGH" },
        apns: { payload: { aps: { sound: "default" } } },
      },
    };
    try {
      const response = await fetch(endpoint, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${accessToken}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify(message),
      });
      if (response.ok) {
        sent++;
      } else {
        failed++;
        errors.push(await response.text());
      }
    } catch (error) {
      failed++;
      errors.push(error instanceof Error ? error.message : "send failed");
    }
  }));

  return new Response(
    JSON.stringify({ ok: true, sent, failed, errors: errors.slice(0, 3) }),
    { status: 200, headers: { "Content-Type": "application/json" } },
  );
});
