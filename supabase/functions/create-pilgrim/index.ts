import { createClient } from "npm:@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

type PilgrimPayload = {
  email: string;
  full_name: string;
  group_id?: string;
  trip_id?: string;
  person?: Record<string, unknown>;
  enrollment?: Record<string, unknown>;
};

// Server-side allowlists so clients can never write arbitrary columns.
const PERSON_COLUMNS = new Set([
  "passport_number",
  "mother_name_ar",
  "birth_date",
  "gender",
  "first_name_en",
  "last_name_en",
  "father_name_en",
  "mother_name_en",
  "passport_issue_date",
  "passport_expiry_date",
  "residence",
  "body_size",
  "phone_number",
  "whatsapp_number",
  "syrian_phone_number",
]);

const ENROLLMENT_COLUMNS = new Set([
  "kobo_id",
  "sequence",
  "cluster",
  "coordinator_name",
  "sticker_number",
  "visa_number",
  "barcode_number",
  "request_type",
  "housing_type",
  "hady_status",
  "companion_name",
  "relation",
  "field_status",
  "medical_test_status",
  "health_status",
  "needs_wheelchair",
  "is_smoking",
  "health_card",
  "is_vaccinated",
  "travel_permit_number",
  "travel_date",
  "hotel_name",
  "hotel_location_url",
  "transportation_details",
  "makkah_hotel",
  "makkah_floor",
  "makkah_room",
  "madinah_travel_date",
  "madinah_hotel",
  "madinah_floor",
  "madinah_room",
  "departure_airport",
  "departure_airline",
  "departure_flight_no",
  "departure_date",
  "departure_time",
  "return_airport",
  "return_airline",
  "return_flight_no",
  "return_date",
  "return_time",
  "service_center_name",
  "service_center_arafat",
  "service_center_mina",
  "bus_arafat",
  "bus_mina",
  "tent_arafat",
  "tent_mina",
  "notes",
]);

function pick(
  source: Record<string, unknown> | undefined,
  allowed: Set<string>,
): Record<string, unknown> {
  const result: Record<string, unknown> = {};
  if (!source) {
    return result;
  }
  for (const [key, value] of Object.entries(source)) {
    if (allowed.has(key) && value !== undefined) {
      result[key] = value;
    }
  }
  return result;
}

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
        ...pick(body.person, PERSON_COLUMNS),
        full_name_ar: body.full_name.trim(),
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
        ...pick(body.enrollment, ENROLLMENT_COLUMNS),
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
