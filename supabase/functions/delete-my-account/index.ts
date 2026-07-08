import { createClient } from "npm:@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

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

  if (req.method !== "POST") {
    return json({ error: "Method not allowed" }, 405);
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

    const { data: profile, error: profileError } = await supabaseAdmin
      .from("profiles")
      .select("role")
      .eq("id", user.id)
      .single();

    if (profileError || !profile) {
      return json({ error: "Profile not found" }, 404);
    }

    if (profile.role !== "pilgrim") {
      return json(
        {
          error:
            "Only pilgrim accounts can be deleted from the app. Contact your organizer for staff accounts.",
        },
        403,
      );
    }

    const { data: pilgrim } = await supabaseAdmin
      .from("pilgrims")
      .select("id")
      .eq("profile_id", user.id)
      .maybeSingle();

    if (pilgrim?.id) {
      const { data: docs } = await supabaseAdmin
        .from("pilgrim_documents")
        .select("storage_path")
        .eq("profile_id", user.id);

      if (docs?.length) {
        const paths = docs
          .map((d) => d.storage_path)
          .filter((p): p is string => Boolean(p));
        if (paths.length) {
          await supabaseAdmin.storage.from("pilgrim-documents").remove(paths);
        }
        await supabaseAdmin
          .from("pilgrim_documents")
          .delete()
          .eq("profile_id", user.id);
      }

      await supabaseAdmin
        .from("pilgrims")
        .update({
          profile_id: null,
          passport_number: null,
          mother_name_ar: null,
          birth_date: null,
          gender: null,
          first_name_en: null,
          last_name_en: null,
          father_name_en: null,
          mother_name_en: null,
          passport_issue_date: null,
          passport_expiry_date: null,
          residence: null,
          body_size: null,
          phone_number: null,
          whatsapp_number: null,
          syrian_phone_number: null,
        })
        .eq("id", pilgrim.id);
    }

    await supabaseAdmin.from("device_tokens").delete().eq("profile_id", user.id);

    const { error: deleteError } = await supabaseAdmin.auth.admin.deleteUser(
      user.id,
    );

    if (deleteError) {
      return json({ error: deleteError.message }, 500);
    }

    return json({ ok: true });
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unknown error";
    return json({ error: message }, 500);
  }
});
