import { createClient } from "npm:@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

type ResetPayload = {
  profile_id: string;
};

function generatePassword(length = 12): string {
  const chars =
    "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789!@#$%";
  const bytes = crypto.getRandomValues(new Uint8Array(length));
  return Array.from(bytes, (b) => chars[b % chars.length]).join("");
}

function json(body: unknown, status: number): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      return json({ error: "Missing authorization" }, 401);
    }

    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const anonKey = Deno.env.get("SUPABASE_ANON_KEY")!;
    const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

    const supabaseUser = createClient(supabaseUrl, anonKey, {
      global: { headers: { Authorization: authHeader } },
    });

    const {
      data: { user },
      error: userError,
    } = await supabaseUser.auth.getUser();

    if (userError || !user) {
      return json({ error: "Unauthorized" }, 401);
    }

    const supabaseAdmin = createClient(supabaseUrl, serviceKey);

    // Caller must be an operator or admin.
    const { data: callerProfile, error: callerError } = await supabaseAdmin
      .from("profiles")
      .select("role")
      .eq("id", user.id)
      .single();

    if (
      callerError ||
      !callerProfile ||
      !["operator", "admin"].includes(callerProfile.role)
    ) {
      return json({ error: "Forbidden" }, 403);
    }

    const body = (await req.json()) as ResetPayload;
    if (!body.profile_id) {
      return json({ error: "profile_id is required" }, 400);
    }

    // Target must be a pilgrim with a login account.
    const { data: target, error: targetError } = await supabaseAdmin
      .from("profiles")
      .select("id, email, role")
      .eq("id", body.profile_id)
      .single();

    if (targetError || !target || target.role !== "pilgrim") {
      return json({ error: "Pilgrim account not found" }, 404);
    }

    const password = generatePassword();

    const { error: authError } = await supabaseAdmin.auth.admin.updateUserById(
      body.profile_id,
      { password },
    );

    if (authError) {
      return json({ error: authError.message }, 400);
    }

    return json({ profile_id: target.id, email: target.email, password }, 200);
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unexpected error";
    return json({ error: message }, 500);
  }
});
