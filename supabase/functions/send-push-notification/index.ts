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
  // Single-row (DB webhook) or batched (statement-level trigger) payloads.
  record?: NotificationRecord;
  records?: NotificationRecord[];
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

const FCM_SEND_CONCURRENCY = 50;

async function runWithConcurrency<T>(
  items: T[],
  limit: number,
  worker: (item: T) => Promise<void>,
): Promise<void> {
  if (items.length === 0) {
    return;
  }

  const queue = [...items];
  const workers = Array.from(
    { length: Math.min(limit, queue.length) },
    async () => {
      while (queue.length > 0) {
        const item = queue.shift();
        if (item === undefined) {
          return;
        }
        await worker(item);
      }
    },
  );

  await Promise.all(workers);
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
  if (!expectedSecret) {
    return new Response(
      JSON.stringify({ error: "PUSH_WEBHOOK_SECRET not configured" }),
      {
        status: 500,
        headers: { "Content-Type": "application/json" },
      },
    );
  }

  const provided = req.headers.get("x-push-secret");
  if (provided !== expectedSecret) {
    return new Response(JSON.stringify({ error: "Invalid push secret" }), {
      status: 401,
      headers: { "Content-Type": "application/json" },
    });
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

  // Accept a batched `records` array (statement-level trigger) or a single
  // `record` (legacy / DB webhook).
  const records: NotificationRecord[] = Array.isArray(body.records)
    ? body.records
    : body.record
    ? [body.record]
    : [];
  const validRecords = records.filter((r) => r?.recipient_id);

  if (validRecords.length === 0) {
    return new Response(JSON.stringify({ error: "Missing record(s)" }), {
      status: 400,
      headers: { "Content-Type": "application/json" },
    });
  }

  const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
  const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
  const supabaseAdmin = createClient(supabaseUrl, serviceKey);

  // One query for every recipient's tokens, grouped by profile id.
  const recipientIds = [...new Set(validRecords.map((r) => r.recipient_id))];
  const { data: tokenRows, error: tokenError } = await supabaseAdmin
    .from("device_tokens")
    .select("profile_id, token")
    .in("profile_id", recipientIds);

  if (tokenError) {
    return new Response(JSON.stringify({ error: tokenError.message }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }

  const tokensByRecipient = new Map<string, string[]>();
  for (const row of tokenRows ?? []) {
    const profileId = row.profile_id as string;
    const token = row.token as string;
    if (!token) {
      continue;
    }
    const list = tokensByRecipient.get(profileId) ?? [];
    list.push(token);
    tokensByRecipient.set(profileId, list);
  }

  if (tokensByRecipient.size === 0) {
    return new Response(
      JSON.stringify({ ok: true, sent: 0, reason: "no_device_tokens" }),
      { status: 200, headers: { "Content-Type": "application/json" } },
    );
  }

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

  let sent = 0;
  let failed = 0;
  const errors: string[] = [];
  // Tokens FCM reports as no longer valid; removed from device_tokens below so
  // the table doesn't accumulate dead registrations.
  const staleTokens = new Set<string>();

  // Build one FCM message per (recipient token × notification), then send all.
  type SendJob = () => Promise<void>;
  const sends: SendJob[] = [];
  for (const record of validRecords) {
    const tokens = tokensByRecipient.get(record.recipient_id) ?? [];
    if (tokens.length === 0) {
      continue;
    }
    const payload = record.payload ?? {};
    const route = typeof payload.route === "string" ? payload.route : "";
    const id = typeof payload.id === "string" ? payload.id : "";
    const title = record.title_en || record.title_ar;
    const bodyText = pickBody(record);
    const data = {
      route,
      id,
      notification_id: record.id,
      title_ar: record.title_ar ?? "",
      title_en: record.title_en ?? "",
      body_ar: (record.body_ar ?? "").slice(0, 200),
      body_en: (record.body_en ?? "").slice(0, 200),
    };

    for (const token of tokens) {
      const message = {
        message: {
          token,
          notification: { title, body: bodyText },
          data,
          android: { priority: "HIGH" },
          apns: { payload: { aps: { sound: "default" } } },
        },
      };
      sends.push(async () => {
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
            return;
          }
          failed++;
          const text = await response.text();
          errors.push(text);
          // 404 / UNREGISTERED means the token is dead (app uninstalled, token
          // rotated, etc.). Mark it for deletion.
          if (
            response.status === 404 ||
            /UNREGISTERED|registration-token-not-registered/i.test(text)
          ) {
            staleTokens.add(token);
          }
        } catch (error) {
          failed++;
          errors.push(error instanceof Error ? error.message : "send failed");
        }
      });
    }
  }

  await runWithConcurrency(sends, FCM_SEND_CONCURRENCY, (job) => job());

  let cleaned = 0;
  if (staleTokens.size > 0) {
    const { error: cleanupError, count } = await supabaseAdmin
      .from("device_tokens")
      .delete({ count: "exact" })
      .in("token", [...staleTokens]);
    if (cleanupError) {
      errors.push(`cleanup: ${cleanupError.message}`);
    } else {
      cleaned = count ?? staleTokens.size;
    }
  }

  return new Response(
    JSON.stringify({ ok: true, sent, failed, cleaned, errors: errors.slice(0, 3) }),
    { status: 200, headers: { "Content-Type": "application/json" } },
  );
});
