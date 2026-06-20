-- Pilgrim domain (final shape): person identity, seasonal trips, travel offices
-- (groups), per-trip enrollments, and per-enrollment ritual progress.
--
--   * A pilgrim is a stable person (passport-based) and can enroll in many trips.
--   * A trip is a seasonal hajj/umrah journey.
--   * A group is a travel office; trip_groups tracks which offices join/withdraw
--     from each trip per season.
--   * trip_enrollments hold all per-trip logistics for a pilgrim.
--   * Operators are scoped to the groups an admin grants them (operator_group_access).

-- ---------------------------------------------------------------------------
-- 1. Travel offices (groups) + operator group access
-- ---------------------------------------------------------------------------

create table public.groups (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  code text not null unique,
  created_at timestamptz not null default now()
);

alter table public.profiles
  add constraint profiles_group_id_fkey
  foreign key (group_id) references public.groups (id) on delete set null;

create index profiles_group_id_idx on public.profiles (group_id);

alter table public.groups enable row level security;

-- Per-operator read/write grants over specific groups (managed by admins).
create table public.operator_group_access (
  operator_id uuid not null references public.profiles (id) on delete cascade,
  group_id uuid not null references public.groups (id) on delete cascade,
  can_write boolean not null default false,
  created_at timestamptz not null default now(),
  primary key (operator_id, group_id)
);

create index operator_group_access_operator_idx
  on public.operator_group_access (operator_id);

alter table public.operator_group_access enable row level security;

-- Group-scope helpers: admins see/write everything; operators only their grants.
create or replace function public.operator_can_read_group(gid uuid)
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select public.is_admin() or exists (
    select 1 from public.operator_group_access
    where operator_id = auth.uid() and group_id = gid
  );
$$;

create or replace function public.operator_can_write_group(gid uuid)
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select public.is_admin() or exists (
    select 1 from public.operator_group_access
    where operator_id = auth.uid() and group_id = gid and can_write
  );
$$;

-- ---------------------------------------------------------------------------
-- 2. Trips + trip ↔ office participation
-- ---------------------------------------------------------------------------

create table public.trips (
  id uuid primary key default gen_random_uuid(),
  type text not null check (type in ('hajj', 'umrah')),
  season_year int not null,
  name text not null,
  start_date date,
  end_date date,
  status text not null default 'planning'
    check (status in ('planning', 'active', 'completed', 'cancelled')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index trips_type_season_idx on public.trips (type, season_year);
create index trips_status_idx on public.trips (status);

create table public.trip_groups (
  id uuid primary key default gen_random_uuid(),
  trip_id uuid not null references public.trips (id) on delete cascade,
  group_id uuid not null references public.groups (id) on delete cascade,
  status text not null default 'active' check (status in ('active', 'withdrawn')),
  joined_at timestamptz not null default now(),
  withdrawn_at timestamptz,
  unique (trip_id, group_id)
);

create index trip_groups_trip_idx on public.trip_groups (trip_id);
create index trip_groups_group_idx on public.trip_groups (group_id);

-- ---------------------------------------------------------------------------
-- 3. Pilgrim person identity
-- ---------------------------------------------------------------------------

create table public.pilgrims (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid unique references public.profiles (id) on delete set null,
  passport_number text,
  full_name_ar text,
  mother_name_ar text,
  birth_date text,
  gender text,
  first_name_en text,
  last_name_en text,
  father_name_en text,
  mother_name_en text,
  passport_issue_date text,
  passport_expiry_date text,
  residence text,
  body_size text,
  phone_number text,
  whatsapp_number text,
  syrian_phone_number text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create unique index pilgrims_passport_unique
  on public.pilgrims (passport_number)
  where passport_number is not null;

create index pilgrims_gender_idx on public.pilgrims (gender);

-- ---------------------------------------------------------------------------
-- 4. Per-trip enrollment (all trip-specific logistics)
-- ---------------------------------------------------------------------------

create table public.trip_enrollments (
  id uuid primary key default gen_random_uuid(),
  pilgrim_id uuid not null references public.pilgrims (id) on delete cascade,
  trip_id uuid not null references public.trips (id) on delete cascade,
  group_id uuid references public.groups (id) on delete set null,
  registry_id serial,
  kobo_id text,
  sequence text,
  cluster text,
  coordinator_name text,
  sticker_number text,
  visa_number text,
  barcode_number text,
  request_type text,
  housing_type text,
  hady_status text,
  companion_name text,
  relation text,
  field_status text,
  medical_test_status text,
  health_status text,
  needs_wheelchair boolean default false,
  is_smoking boolean default false,
  health_card boolean default false,
  is_vaccinated boolean default false,
  travel_permit_number text,
  travel_date date,
  hotel_name text,
  hotel_location_url text,
  transportation_details text,
  makkah_hotel text,
  makkah_floor text,
  makkah_room text,
  madinah_travel_date text,
  madinah_hotel text,
  madinah_floor text,
  madinah_room text,
  departure_airport text,
  departure_airline text,
  departure_flight_no text,
  departure_date text,
  departure_time text,
  return_airport text,
  return_airline text,
  return_flight_no text,
  return_date text,
  return_time text,
  service_center_name text,
  service_center_arafat text,
  service_center_mina text,
  bus_arafat text,
  bus_mina text,
  tent_arafat text,
  tent_mina text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (pilgrim_id, trip_id)
);

create index trip_enrollments_trip_idx on public.trip_enrollments (trip_id);
create index trip_enrollments_pilgrim_idx on public.trip_enrollments (pilgrim_id);
create index trip_enrollments_group_idx on public.trip_enrollments (group_id);
create index trip_enrollments_field_status_idx on public.trip_enrollments (field_status);
create index trip_enrollments_sticker_idx on public.trip_enrollments (sticker_number);

-- ---------------------------------------------------------------------------
-- 5. Ritual progress (per enrollment)
-- ---------------------------------------------------------------------------

create table public.ritual_logs (
  id uuid primary key default gen_random_uuid(),
  enrollment_id uuid not null references public.trip_enrollments (id) on delete cascade,
  ritual_key text not null,
  is_completed boolean not null default false,
  completed_at timestamptz,
  updated_at timestamptz not null default now(),
  unique (enrollment_id, ritual_key)
);

create index ritual_logs_enrollment_idx on public.ritual_logs (enrollment_id);

-- ---------------------------------------------------------------------------
-- 6. RLS
-- ---------------------------------------------------------------------------

alter table public.trips enable row level security;
alter table public.trip_groups enable row level security;
alter table public.pilgrims enable row level security;
alter table public.trip_enrollments enable row level security;
alter table public.ritual_logs enable row level security;

-- groups: pilgrims read groups tied to their own enrollments; admins manage
-- (admin/operator read + management policies are added in later migrations).
create policy "Pilgrims read own groups"
  on public.groups for select to authenticated
  using (
    exists (
      select 1
      from public.trip_enrollments te
      join public.pilgrims p on p.id = te.pilgrim_id
      where te.group_id = groups.id and p.profile_id = auth.uid()
    )
  );

-- operator_group_access: admins manage; operators read their own grants.
create policy "Admins manage operator group access"
  on public.operator_group_access for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

create policy "Operators read own group access"
  on public.operator_group_access for select to authenticated
  using (operator_id = auth.uid());

-- trips: any authenticated user reads; admins manage.
create policy "Authenticated read trips"
  on public.trips for select to authenticated using (true);
create policy "Admins insert trips"
  on public.trips for insert to authenticated with check (public.is_admin());
create policy "Admins update trips"
  on public.trips for update to authenticated
  using (public.is_admin()) with check (public.is_admin());
create policy "Admins delete trips"
  on public.trips for delete to authenticated using (public.is_admin());

-- trip_groups: staff read; admins manage.
create policy "Staff read trip groups"
  on public.trip_groups for select to authenticated
  using (public.is_operator_or_admin());
create policy "Admins insert trip groups"
  on public.trip_groups for insert to authenticated with check (public.is_admin());
create policy "Admins update trip groups"
  on public.trip_groups for update to authenticated
  using (public.is_admin()) with check (public.is_admin());
create policy "Admins delete trip groups"
  on public.trip_groups for delete to authenticated using (public.is_admin());

-- pilgrims: own row for the pilgrim; full read/write for staff.
create policy "Pilgrims read own person"
  on public.pilgrims for select to authenticated
  using (profile_id = auth.uid());
create policy "Staff read pilgrims"
  on public.pilgrims for select to authenticated
  using (public.is_operator_or_admin());
create policy "Staff insert pilgrims"
  on public.pilgrims for insert to authenticated
  with check (public.is_operator_or_admin());
create policy "Staff update pilgrims"
  on public.pilgrims for update to authenticated
  using (public.is_operator_or_admin()) with check (public.is_operator_or_admin());

-- trip_enrollments: own (via person) for the pilgrim; staff scoped by group grant.
create policy "Pilgrims read own enrollments"
  on public.trip_enrollments for select to authenticated
  using (
    exists (
      select 1 from public.pilgrims p
      where p.id = trip_enrollments.pilgrim_id and p.profile_id = auth.uid()
    )
  );
create policy "Staff read enrollments in group"
  on public.trip_enrollments for select to authenticated
  using (public.operator_can_read_group(group_id));
create policy "Staff insert enrollments in group"
  on public.trip_enrollments for insert to authenticated
  with check (public.operator_can_write_group(group_id));
create policy "Staff update enrollments in group"
  on public.trip_enrollments for update to authenticated
  using (public.operator_can_write_group(group_id))
  with check (public.operator_can_write_group(group_id));

-- ritual_logs: pilgrim manages own (via enrollment); admins read all.
create policy "Pilgrims read own ritual logs"
  on public.ritual_logs for select to authenticated
  using (
    exists (
      select 1
      from public.trip_enrollments te
      join public.pilgrims p on p.id = te.pilgrim_id
      where te.id = ritual_logs.enrollment_id and p.profile_id = auth.uid()
    )
  );
create policy "Pilgrims insert own ritual logs"
  on public.ritual_logs for insert to authenticated
  with check (
    exists (
      select 1
      from public.trip_enrollments te
      join public.pilgrims p on p.id = te.pilgrim_id
      where te.id = ritual_logs.enrollment_id and p.profile_id = auth.uid()
    )
  );
create policy "Pilgrims update own ritual logs"
  on public.ritual_logs for update to authenticated
  using (
    exists (
      select 1
      from public.trip_enrollments te
      join public.pilgrims p on p.id = te.pilgrim_id
      where te.id = ritual_logs.enrollment_id and p.profile_id = auth.uid()
    )
  )
  with check (
    exists (
      select 1
      from public.trip_enrollments te
      join public.pilgrims p on p.id = te.pilgrim_id
      where te.id = ritual_logs.enrollment_id and p.profile_id = auth.uid()
    )
  );
create policy "Admins read all ritual logs"
  on public.ritual_logs for select to authenticated
  using (public.is_admin());

-- ---------------------------------------------------------------------------
-- 7. Auto-provision pilgrim identity + enrollment when a pilgrim profile signs up
-- ---------------------------------------------------------------------------

create or replace function public.handle_new_pilgrim_profile()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_pilgrim_id uuid;
  v_trip_id uuid;
begin
  if new.role <> 'pilgrim' then
    return new;
  end if;

  insert into public.pilgrims (profile_id)
  values (new.id)
  on conflict (profile_id) do nothing;

  select id into v_pilgrim_id
  from public.pilgrims where profile_id = new.id;

  -- Enroll into the most recent active trip (if any) so the pilgrim immediately
  -- has logistics + ritual tracking.
  select id into v_trip_id
  from public.trips
  where status = 'active'
  order by season_year desc, created_at desc
  limit 1;

  if v_pilgrim_id is not null and v_trip_id is not null then
    insert into public.trip_enrollments (pilgrim_id, trip_id)
    values (v_pilgrim_id, v_trip_id)
    on conflict (pilgrim_id, trip_id) do nothing;
  end if;

  return new;
end;
$$;

create trigger on_profile_pilgrim_details
  after insert on public.profiles
  for each row
  execute function public.handle_new_pilgrim_profile();

-- New operators get read/write access to all existing groups by default; admins
-- can narrow this from the operator editor.
create or replace function public.grant_operator_default_group_access()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if new.role = 'operator' then
    insert into public.operator_group_access (operator_id, group_id, can_write)
    select new.id, g.id, true from public.groups g
    on conflict (operator_id, group_id) do nothing;
  end if;
  return new;
end;
$$;

create trigger on_profile_operator_group_access
  after insert on public.profiles
  for each row
  execute function public.grant_operator_default_group_access();

-- ---------------------------------------------------------------------------
-- 8. Compatibility view (flat person + enrollment shape used by app reads)
-- ---------------------------------------------------------------------------

create or replace view public.pilgrim_enrollment_view
with (security_invoker = true) as
select
  e.*,
  e.id as enrollment_id,
  p.profile_id,
  p.passport_number,
  p.full_name_ar,
  p.mother_name_ar,
  p.birth_date,
  p.gender,
  p.first_name_en,
  p.last_name_en,
  p.father_name_en,
  p.mother_name_en,
  p.passport_issue_date,
  p.passport_expiry_date,
  p.residence,
  p.body_size,
  p.phone_number,
  p.whatsapp_number,
  p.syrian_phone_number,
  t.type as trip_type,
  t.season_year,
  t.name as trip_name,
  t.status as trip_status,
  g.name as group_name,
  coalesce(pr.full_name, p.full_name_ar) as full_name
from public.trip_enrollments e
join public.pilgrims p on p.id = e.pilgrim_id
join public.trips t on t.id = e.trip_id
left join public.groups g on g.id = e.group_id
left join public.profiles pr on pr.id = p.profile_id;
