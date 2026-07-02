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

type FcmSendResult = "sent" | "stale" | "failed";

type FailureRow = {
  notification_id: string;
  recipient_id: string;
  device_token: string;
  error: string;
  attempts: number;
};

type SendJob = {
  notificationId: string;
  recipientId: string;
  token: string;
  message: { message: Record<string, unknown> };
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
const MAX_SEND_ATTEMPTS = 3;
const RETRY_BASE_MS = 500;

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

function isStaleTokenError(status: number, text: string): boolean {
  return status === 404 ||
    /UNREGISTERED|registration-token-not-registered/i.test(text);
}

function isRetryableError(status: number): boolean {
  return status === 429 || (status >= 500 && status <= 599);
}

function sleep(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function sendFcmMessage(
  endpoint: string,
  accessToken: string,
  message: unknown,
): Promise<{ result: FcmSendResult; error?: string; attempts: number }> {
  let lastError = "send failed";

  for (let attempt = 1; attempt <= MAX_SEND_ATTEMPTS; attempt++) {
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
        return { result: "sent", attempts: attempt };
      }

      const text = await response.text();
      lastError = text;

      if (isStaleTokenError(response.status, text)) {
        return { result: "stale", error: text, attempts: attempt };
      }

      if (isRetryableError(response.status) && attempt < MAX_SEND_ATTEMPTS) {
        await sleep(RETRY_BASE_MS * 2 ** (attempt - 1));
        continue;
      }

      return { result: "failed", error: text, attempts: attempt };
    } catch (error) {
      lastError = error instanceof Error ? error.message : "send failed";
      if (attempt < MAX_SEND_ATTEMPTS) {
        await sleep(RETRY_BASE_MS * 2 ** (attempt - 1));
        continue;
      }
    }
  }

  return { result: "failed", error: lastError, attempts: MAX_SEND_ATTEMPTS };
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
  let retried = 0;
  const errors: string[] = [];
  const staleTokens = new Set<string>();
  const failureRows: FailureRow[] = [];
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
      sends.push({
        notificationId: record.id,
        recipientId: record.recipient_id,
        token,
        message: {
          message: {
            token,
            notification: { title, body: bodyText },
            data,
            android: { priority: "HIGH" },
            apns: { payload: { aps: { sound: "default" } } },
          },
        },
      });
    }
  }

  await runWithConcurrency(sends, FCM_SEND_CONCURRENCY, async (job) => {
    const outcome = await sendFcmMessage(endpoint, accessToken, job.message);
    if (outcome.attempts > 1) {
      retried++;
    }

    switch (outcome.result) {
      case "sent":
        sent++;
        return;
      case "stale":
        staleTokens.add(job.token);
        return;
      case "failed":
        failed++;
        if (outcome.error) {
          errors.push(outcome.error);
        }
        failureRows.push({
          notification_id: job.notificationId,
          recipient_id: job.recipientId,
          device_token: job.token,
          error: (outcome.error ?? "send failed").slice(0, 2000),
          attempts: outcome.attempts,
        });
    }
  });

  let logged = 0;
  if (failureRows.length > 0) {
    const { error: logError, count } = await supabaseAdmin
      .from("push_dispatch_failures")
      .insert(failureRows, { count: "exact" });
    if (logError) {
      errors.push(`failure_log: ${logError.message}`);
    } else {
      logged = count ?? failureRows.length;
    }
  }

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
    JSON.stringify({
      ok: true,
      sent,
      failed,
      retried,
      logged,
      cleaned,
      errors: errors.slice(0, 3),
    }),
    { status: 200, headers: { "Content-Type": "application/json" } },
  );
});
