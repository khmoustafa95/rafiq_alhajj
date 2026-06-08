import { createClient } from "npm:@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

type OperatorPermissions = {
  can_register_pilgrims: boolean;
  can_manage_pilgrim_registry: boolean;
  can_use_field_tools: boolean;
  can_upload_documents: boolean;
};

type CreatePayload = {
  action: "create";
  email: string;
  full_name: string;
  password?: string;
  is_active?: boolean;
  operator_permissions?: OperatorPermissions;
};

type UpdatePayload = {
  action: "update";
  profile_id: string;
  email?: string;
  full_name?: string;
  password?: string;
  is_active?: boolean;
  operator_permissions?: OperatorPermissions;
};

function generatePassword(length = 12): string {
  const chars =
    "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789!@#$%";
  const bytes = crypto.getRandomValues(new Uint8Array(length));
  return Array.from(bytes, (b) => chars[b % chars.length]).join("");
}

function defaultPermissions(): OperatorPermissions {
  return {
    can_register_pilgrims: true,
    can_manage_pilgrim_registry: true,
    can_use_field_tools: true,
    can_upload_documents: true,
  };
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      return new Response(JSON.stringify({ error: "Missing authorization" }), {
        status: 401,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
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
      return new Response(JSON.stringify({ error: "Unauthorized" }), {
        status: 401,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const supabaseAdmin = createClient(supabaseUrl, serviceKey);

    const { data: adminProfile, error: profileError } = await supabaseAdmin
      .from("profiles")
      .select("role")
      .eq("id", user.id)
      .single();

    if (profileError || !adminProfile || adminProfile.role !== "admin") {
      return new Response(JSON.stringify({ error: "Forbidden" }), {
        status: 403,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const body = await req.json();

    if (body.action === "create") {
      const payload = body as CreatePayload;
      if (!payload.email?.trim() || !payload.full_name?.trim()) {
        return new Response(
          JSON.stringify({ error: "email and full_name are required" }),
          {
            status: 400,
            headers: { ...corsHeaders, "Content-Type": "application/json" },
          },
        );
      }

      const password = payload.password?.trim() || generatePassword();
      const permissions = payload.operator_permissions ?? defaultPermissions();

      const { data: created, error: createError } =
        await supabaseAdmin.auth.admin.createUser({
          email: payload.email.trim(),
          password,
          email_confirm: true,
          user_metadata: {
            full_name: payload.full_name.trim(),
            role: "operator",
            operator_permissions: permissions,
          },
        });

      if (createError || !created.user) {
        return new Response(
          JSON.stringify({
            error: createError?.message ?? "Create operator failed",
          }),
          {
            status: 400,
            headers: { ...corsHeaders, "Content-Type": "application/json" },
          },
        );
      }

      const profileId = created.user.id;
      const isActive = payload.is_active ?? true;

      const { error: updateError } = await supabaseAdmin
        .from("profiles")
        .update({
          email: payload.email.trim(),
          full_name: payload.full_name.trim(),
          is_active: isActive,
          operator_permissions: permissions,
        })
        .eq("id", profileId);

      if (updateError) {
        return new Response(JSON.stringify({ error: updateError.message }), {
          status: 400,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        });
      }

      return new Response(
        JSON.stringify({
          profile_id: profileId,
          email: payload.email.trim(),
          password,
        }),
        {
          status: 200,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        },
      );
    }

    if (body.action === "update") {
      const payload = body as UpdatePayload;
      if (!payload.profile_id) {
        return new Response(JSON.stringify({ error: "profile_id is required" }), {
          status: 400,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        });
      }

      const { data: operator, error: operatorError } = await supabaseAdmin
        .from("profiles")
        .select("id, role")
        .eq("id", payload.profile_id)
        .single();

      if (operatorError || !operator || operator.role !== "operator") {
        return new Response(JSON.stringify({ error: "Operator not found" }), {
          status: 404,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        });
      }

      const profileUpdate: Record<string, unknown> = {};
      if (payload.full_name?.trim()) {
        profileUpdate.full_name = payload.full_name.trim();
      }
      if (typeof payload.is_active === "boolean") {
        profileUpdate.is_active = payload.is_active;
      }
      if (payload.operator_permissions) {
        profileUpdate.operator_permissions = payload.operator_permissions;
      }
      if (payload.email?.trim()) {
        profileUpdate.email = payload.email.trim();
      }

      if (Object.keys(profileUpdate).length > 0) {
        const { error: updateProfileError } = await supabaseAdmin
          .from("profiles")
          .update(profileUpdate)
          .eq("id", payload.profile_id);

        if (updateProfileError) {
          return new Response(
            JSON.stringify({ error: updateProfileError.message }),
            {
              status: 400,
              headers: { ...corsHeaders, "Content-Type": "application/json" },
            },
          );
        }
      }

      const authUpdate: {
        email?: string;
        password?: string;
        user_metadata?: Record<string, unknown>;
      } = {};

      if (payload.email?.trim()) {
        authUpdate.email = payload.email.trim();
      }
      if (payload.password?.trim()) {
        authUpdate.password = payload.password.trim();
      }
      if (payload.full_name?.trim() || payload.operator_permissions) {
        authUpdate.user_metadata = {
          ...(payload.full_name?.trim()
            ? { full_name: payload.full_name.trim() }
            : {}),
          role: "operator",
          ...(payload.operator_permissions
            ? { operator_permissions: payload.operator_permissions }
            : {}),
        };
      }

      if (Object.keys(authUpdate).length > 0) {
        const { error: authError } = await supabaseAdmin.auth.admin.updateUserById(
          payload.profile_id,
          authUpdate,
        );

        if (authError) {
          return new Response(JSON.stringify({ error: authError.message }), {
            status: 400,
            headers: { ...corsHeaders, "Content-Type": "application/json" },
          });
        }
      }

      return new Response(JSON.stringify({ profile_id: payload.profile_id }), {
        status: 200,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    return new Response(JSON.stringify({ error: "Unknown action" }), {
      status: 400,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unexpected error";
    return new Response(JSON.stringify({ error: message }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
