import { createClient } from "npm:@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

type PilgrimPayload = {
  email: string;
  full_name: string;
  passport_number?: string;
  travel_permit_number?: string;
  medical_test_status?: string;
  travel_date?: string;
  hotel_name?: string;
  hotel_location_url?: string;
  transportation_details?: string;
  gender?: string;
  group_id?: string;
  trip_id?: string;
};

function generatePassword(length = 12): string {
  const chars =
    "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789!@#$%";
  const bytes = crypto.getRandomValues(new Uint8Array(length));
  return Array.from(bytes, (b) => chars[b % chars.length]).join("");
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

    const { data: operatorProfile, error: profileError } = await supabaseAdmin
      .from("profiles")
      .select("role")
      .eq("id", user.id)
      .single();

    if (
      profileError ||
      !operatorProfile ||
      !["operator", "admin"].includes(operatorProfile.role)
    ) {
      return new Response(JSON.stringify({ error: "Forbidden" }), {
        status: 403,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const body = (await req.json()) as PilgrimPayload;
    if (!body.email?.trim() || !body.full_name?.trim()) {
      return new Response(
        JSON.stringify({ error: "email and full_name are required" }),
        {
          status: 400,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        },
      );
    }

    const password = generatePassword();

    const { data: created, error: createError } =
      await supabaseAdmin.auth.admin.createUser({
        email: body.email.trim(),
        password,
        email_confirm: true,
        user_metadata: {
          full_name: body.full_name.trim(),
          role: "pilgrim",
        },
      });

    if (createError || !created.user) {
      return new Response(
        JSON.stringify({ error: createError?.message ?? "Create user failed" }),
        {
          status: 400,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        },
      );
    }

    const profileId = created.user.id;

    // The auth trigger creates the profile, the pilgrim identity, and an
    // enrollment into the active trip. Resolve the pilgrim id (fallback insert).
    let pilgrimId: string | null = null;
    const { data: pilgrimRow } = await supabaseAdmin
      .from("pilgrims")
      .select("id")
      .eq("profile_id", profileId)
      .maybeSingle();
    pilgrimId = pilgrimRow?.id ?? null;

    if (!pilgrimId) {
      const { data: inserted, error: insertError } = await supabaseAdmin
        .from("pilgrims")
        .insert({ profile_id: profileId })
        .select("id")
        .single();
      if (insertError || !inserted) {
        return new Response(
          JSON.stringify({ error: insertError?.message ?? "Create pilgrim failed" }),
          {
            status: 400,
            headers: { ...corsHeaders, "Content-Type": "application/json" },
          },
        );
      }
      pilgrimId = inserted.id;
    }

    const { error: personError } = await supabaseAdmin
      .from("pilgrims")
      .update({
        passport_number: body.passport_number ?? null,
        full_name_ar: body.full_name.trim(),
        gender: body.gender ?? null,
        updated_at: new Date().toISOString(),
      })
      .eq("id", pilgrimId);

    if (personError) {
      return new Response(JSON.stringify({ error: personError.message }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // Determine the target trip (explicit, else most recent active trip).
    let tripId = body.trip_id ?? null;
    if (!tripId) {
      const { data: trip } = await supabaseAdmin
        .from("trips")
        .select("id")
        .eq("status", "active")
        .order("season_year", { ascending: false })
        .limit(1)
        .maybeSingle();
      tripId = trip?.id ?? null;
    }

    if (tripId) {
      const enrollmentPayload = {
        travel_permit_number: body.travel_permit_number ?? null,
        medical_test_status: body.medical_test_status ?? null,
        travel_date: body.travel_date ?? null,
        hotel_name: body.hotel_name ?? null,
        hotel_location_url: body.hotel_location_url ?? null,
        transportation_details: body.transportation_details ?? null,
        group_id: body.group_id ?? null,
        updated_at: new Date().toISOString(),
      };

      const { data: existing } = await supabaseAdmin
        .from("trip_enrollments")
        .select("id")
        .eq("pilgrim_id", pilgrimId)
        .eq("trip_id", tripId)
        .maybeSingle();

      const enrollmentError = existing
        ? (await supabaseAdmin
            .from("trip_enrollments")
            .update(enrollmentPayload)
            .eq("id", existing.id)).error
        : (await supabaseAdmin.from("trip_enrollments").insert({
            pilgrim_id: pilgrimId,
            trip_id: tripId,
            ...enrollmentPayload,
          })).error;

      if (enrollmentError) {
        return new Response(JSON.stringify({ error: enrollmentError.message }), {
          status: 400,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        });
      }
    }

    if (body.group_id) {
      const { error: groupError } = await supabaseAdmin
        .from("profiles")
        .update({ group_id: body.group_id })
        .eq("id", profileId);

      if (groupError) {
        return new Response(JSON.stringify({ error: groupError.message }), {
          status: 400,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        });
      }
    }

    return new Response(
      JSON.stringify({
        profile_id: profileId,
        email: body.email.trim(),
        password,
      }),
      {
        status: 200,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      },
    );
  } catch (e) {
    const message = e instanceof Error ? e.message : "Unknown error";
    return new Response(JSON.stringify({ error: message }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
