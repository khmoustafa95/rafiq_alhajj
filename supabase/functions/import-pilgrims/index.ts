import { createClient, SupabaseClient } from "npm:@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

type ImportRow = {
  passport_number?: string;
  email?: string;
  person?: Record<string, unknown>;
  enrollment?: Record<string, unknown>;
};

type ImportPayload = {
  trip_id?: string;
  group_id?: string;
  rows: ImportRow[];
};

// Server-side allowlists so clients can never write arbitrary columns.
const PERSON_COLUMNS = new Set([
  "full_name_ar",
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
    if (allowed.has(key) && value !== undefined && value !== null) {
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

async function resolvePilgrimByPassport(
  admin: SupabaseClient,
  passport: string,
): Promise<string | null> {
  const { data } = await admin
    .from("pilgrims")
    .select("id")
    .eq("passport_number", passport)
    .maybeSingle();
  return data?.id ?? null;
}

async function upsertEnrollment(
  admin: SupabaseClient,
  pilgrimId: string,
  tripId: string,
  enrollmentData: Record<string, unknown>,
  groupId: string | undefined,
): Promise<void> {
  const payload = {
    ...enrollmentData,
    ...(groupId ? { group_id: groupId } : {}),
    updated_at: new Date().toISOString(),
  };

  const { data: existing } = await admin
    .from("trip_enrollments")
    .select("id")
    .eq("pilgrim_id", pilgrimId)
    .eq("trip_id", tripId)
    .maybeSingle();

  const { error } = existing
    ? await admin.from("trip_enrollments").update(payload).eq("id", existing.id)
    : await admin
        .from("trip_enrollments")
        .insert({ pilgrim_id: pilgrimId, trip_id: tripId, ...payload });

  if (error) {
    throw new Error(error.message);
  }
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  const json = (body: unknown, status = 200) =>
    new Response(JSON.stringify(body), {
      status,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });

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

    const admin = createClient(supabaseUrl, serviceKey);

    const { data: actor, error: actorError } = await admin
      .from("profiles")
      .select("role")
      .eq("id", user.id)
      .single();

    if (
      actorError ||
      !actor ||
      !["operator", "admin"].includes(actor.role)
    ) {
      return json({ error: "Forbidden" }, 403);
    }

    const body = (await req.json()) as ImportPayload;
    const rows = Array.isArray(body.rows) ? body.rows : [];
    if (rows.length === 0) {
      return json({ error: "rows are required" }, 400);
    }

    // Resolve the target trip once (explicit, else most recent active trip).
    let tripId = body.trip_id ?? null;
    if (!tripId) {
      const { data: trip } = await admin
        .from("trips")
        .select("id")
        .eq("status", "active")
        .order("season_year", { ascending: false })
        .limit(1)
        .maybeSingle();
      tripId = trip?.id ?? null;
    }

    let created = 0;
    let updated = 0;
    let failed = 0;
    const errors: string[] = [];

    for (let i = 0; i < rows.length; i++) {
      const row = rows[i];
      const rowLabel = `row ${i + 1}`;
      try {
        const personData = pick(row.person, PERSON_COLUMNS);
        const enrollmentData = pick(row.enrollment, ENROLLMENT_COLUMNS);
        const passport = (row.passport_number ??
          (personData.passport_number as string | undefined))?.toString().trim();
        const fullName = (personData.full_name_ar as string | undefined)?.trim();

        let pilgrimId = passport
          ? await resolvePilgrimByPassport(admin, passport)
          : null;
        let profileId: string | null = null;

        if (pilgrimId) {
          // Update existing pilgrim identity.
          const { error } = await admin
            .from("pilgrims")
            .update({ ...personData, updated_at: new Date().toISOString() })
            .eq("id", pilgrimId);
          if (error) {
            throw new Error(error.message);
          }
          updated++;
        } else {
          // Create. A login account is only created when an email is provided.
          const email = row.email?.trim();
          if (email) {
            const { data: createdUser, error: createError } =
              await admin.auth.admin.createUser({
                email,
                password: generatePassword(),
                email_confirm: true,
                user_metadata: {
                  full_name: fullName ?? "",
                  role: "pilgrim",
                },
              });
            if (createError || !createdUser.user) {
              throw new Error(createError?.message ?? "Create user failed");
            }
            profileId = createdUser.user.id;

            const { data: pilgrimRow } = await admin
              .from("pilgrims")
              .select("id")
              .eq("profile_id", profileId)
              .maybeSingle();
            pilgrimId = pilgrimRow?.id ?? null;
            if (!pilgrimId) {
              const { data: inserted, error: insertError } = await admin
                .from("pilgrims")
                .insert({ profile_id: profileId })
                .select("id")
                .single();
              if (insertError || !inserted) {
                throw new Error(insertError?.message ?? "Create pilgrim failed");
              }
              pilgrimId = inserted.id;
            }
            const { error: personError } = await admin
              .from("pilgrims")
              .update({ ...personData, updated_at: new Date().toISOString() })
              .eq("id", pilgrimId);
            if (personError) {
              throw new Error(personError.message);
            }
          } else {
            const { data: inserted, error: insertError } = await admin
              .from("pilgrims")
              .insert({ ...personData })
              .select("id")
              .single();
            if (insertError || !inserted) {
              throw new Error(insertError?.message ?? "Create pilgrim failed");
            }
            pilgrimId = inserted.id;
          }
          created++;
        }

        if (tripId && pilgrimId) {
          await upsertEnrollment(
            admin,
            pilgrimId,
            tripId,
            enrollmentData,
            body.group_id,
          );
        }

        if (body.group_id && profileId) {
          await admin
            .from("profiles")
            .update({ group_id: body.group_id })
            .eq("id", profileId);
        }
      } catch (e) {
        failed++;
        const message = e instanceof Error ? e.message : "Unknown error";
        errors.push(`${rowLabel}: ${message}`);
      }
    }

    return json({ created, updated, failed, errors });
  } catch (e) {
    const message = e instanceof Error ? e.message : "Unknown error";
    return json({ error: message }, 500);
  }
});
