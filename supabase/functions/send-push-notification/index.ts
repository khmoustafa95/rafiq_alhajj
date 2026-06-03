import { createClient } from "npm:@supabase/supabase-js@2";
import admin from "npm:firebase-admin@13";

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

function initFirebase(): admin.app.App | null {
  const raw = Deno.env.get("FIREBASE_SERVICE_ACCOUNT_JSON");
  if (!raw) {
    return null;
  }

  try {
    const serviceAccount = JSON.parse(raw);
    if (admin.apps.length === 0) {
      admin.initializeApp({
        credential: admin.credential.cert(serviceAccount),
      });
    }
    return admin.app();
  } catch {
    return null;
  }
}

function pickBody(record: NotificationRecord): string {
  return (record.body_en ?? record.body_ar ?? "").slice(0, 200);
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

  const firebase = initFirebase();
  if (!firebase) {
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

  const message: admin.messaging.MulticastMessage = {
    tokens,
    notification: {
      title: record.title_en || record.title_ar,
      body: pickBody(record),
    },
    data: {
      route,
      id,
      notification_id: record.id,
    },
    android: { priority: "high" },
    apns: { payload: { aps: { sound: "default" } } },
  };

  try {
    const result = await admin.messaging().sendEachForMulticast(message);
    return new Response(
      JSON.stringify({
        ok: true,
        sent: result.successCount,
        failed: result.failureCount,
      }),
      { status: 200, headers: { "Content-Type": "application/json" } },
    );
  } catch (error) {
    const messageText = error instanceof Error ? error.message : "FCM send failed";
    return new Response(JSON.stringify({ error: messageText }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
});
