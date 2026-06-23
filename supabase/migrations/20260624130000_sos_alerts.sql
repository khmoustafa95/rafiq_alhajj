-- "Lost pilgrim" SOS alerts + live location pings.
-- A pilgrim raises an alert; their group operators + all admins are notified and
-- can track the live location on a map while the pilgrim app pushes updates.

-- ---------------------------------------------------------------------------
-- 1. Tables
-- ---------------------------------------------------------------------------

create table public.sos_alerts (
  id uuid primary key default gen_random_uuid(),
  pilgrim_profile_id uuid not null references public.profiles (id) on delete cascade,
  group_id uuid references public.groups (id) on delete set null,
  status text not null default 'active'
    check (status in ('active', 'resolved', 'cancelled')),
  latitude double precision,
  longitude double precision,
  accuracy double precision,
  note text,
  started_at timestamptz not null default now(),
  last_location_at timestamptz,
  resolved_at timestamptz,
  resolved_by uuid references public.profiles (id) on delete set null
);

create index sos_alerts_status_idx on public.sos_alerts (status, started_at desc);
create index sos_alerts_group_idx on public.sos_alerts (group_id);
create index sos_alerts_pilgrim_idx on public.sos_alerts (pilgrim_profile_id);

-- At most one active alert per pilgrim.
create unique index sos_alerts_one_active_per_pilgrim
  on public.sos_alerts (pilgrim_profile_id)
  where status = 'active';

create table public.sos_location_pings (
  id uuid primary key default gen_random_uuid(),
  alert_id uuid not null references public.sos_alerts (id) on delete cascade,
  latitude double precision not null,
  longitude double precision not null,
  accuracy double precision,
  created_at timestamptz not null default now()
);

create index sos_location_pings_alert_idx
  on public.sos_location_pings (alert_id, created_at);

alter table public.sos_alerts enable row level security;
alter table public.sos_location_pings enable row level security;

-- ---------------------------------------------------------------------------
-- 2. RLS
-- ---------------------------------------------------------------------------

-- sos_alerts: pilgrim manages own; staff read/resolve scoped by group.
create policy "Pilgrims read own sos alerts"
  on public.sos_alerts for select to authenticated
  using (pilgrim_profile_id = auth.uid());

create policy "Pilgrims insert own sos alerts"
  on public.sos_alerts for insert to authenticated
  with check (pilgrim_profile_id = auth.uid());

create policy "Pilgrims update own sos alerts"
  on public.sos_alerts for update to authenticated
  using (pilgrim_profile_id = auth.uid())
  with check (pilgrim_profile_id = auth.uid());

create policy "Staff read sos alerts in group"
  on public.sos_alerts for select to authenticated
  using (public.operator_can_read_group(group_id));

create policy "Staff resolve sos alerts in group"
  on public.sos_alerts for update to authenticated
  using (public.operator_can_read_group(group_id))
  with check (public.operator_can_read_group(group_id));

-- sos_location_pings: pilgrim inserts for own active alert; readers match the alert.
create policy "Pilgrims insert pings for own alert"
  on public.sos_location_pings for insert to authenticated
  with check (
    exists (
      select 1 from public.sos_alerts a
      where a.id = sos_location_pings.alert_id
        and a.pilgrim_profile_id = auth.uid()
        and a.status = 'active'
    )
  );

create policy "Read pings for visible alerts"
  on public.sos_location_pings for select to authenticated
  using (
    exists (
      select 1 from public.sos_alerts a
      where a.id = sos_location_pings.alert_id
        and (
          a.pilgrim_profile_id = auth.uid()
          or public.operator_can_read_group(a.group_id)
        )
    )
  );

-- ---------------------------------------------------------------------------
-- 3. Raise alert RPC (resolves group + notifies staff in one server-side step)
-- ---------------------------------------------------------------------------

create or replace function public.raise_sos_alert(
  p_lat double precision default null,
  p_lng double precision default null,
  p_accuracy double precision default null
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_group_id uuid;
  v_alert_id uuid;
  v_name text;
  v_is_new boolean := false;
begin
  if v_uid is null then
    raise exception 'not authenticated';
  end if;

  if not exists (
    select 1 from public.profiles where id = v_uid and role = 'pilgrim'
  ) then
    raise exception 'not authorized';
  end if;

  -- Resolve the pilgrim's group (profile first, then active enrollment).
  select group_id into v_group_id from public.profiles where id = v_uid;
  if v_group_id is null then
    select te.group_id into v_group_id
    from public.trip_enrollments te
    join public.pilgrims pg on pg.id = te.pilgrim_id
    join public.trips t on t.id = te.trip_id
    where pg.profile_id = v_uid and te.group_id is not null
    order by (t.status = 'active') desc, te.created_at desc
    limit 1;
  end if;

  select coalesce(full_name, 'حاج') into v_name
  from public.profiles where id = v_uid;

  -- Reuse an existing active alert (idempotent) or create a new one.
  select id into v_alert_id
  from public.sos_alerts
  where pilgrim_profile_id = v_uid and status = 'active'
  limit 1;

  if v_alert_id is null then
    insert into public.sos_alerts (
      pilgrim_profile_id, group_id, status, latitude, longitude, accuracy,
      started_at, last_location_at
    )
    values (
      v_uid, v_group_id, 'active', p_lat, p_lng, p_accuracy,
      now(), case when p_lat is not null then now() end
    )
    returning id into v_alert_id;
    v_is_new := true;
  else
    update public.sos_alerts
    set latitude = coalesce(p_lat, latitude),
        longitude = coalesce(p_lng, longitude),
        accuracy = coalesce(p_accuracy, accuracy),
        group_id = coalesce(v_group_id, group_id),
        last_location_at = case when p_lat is not null then now() else last_location_at end
    where id = v_alert_id;
  end if;

  if p_lat is not null and p_lng is not null then
    insert into public.sos_location_pings (alert_id, latitude, longitude, accuracy)
    values (v_alert_id, p_lat, p_lng, p_accuracy);
  end if;

  -- Notify staff only when the alert is first raised.
  if v_is_new then
    insert into public.notifications (
      recipient_id, sender_id, type, title_ar, title_en, body_ar, body_en, payload
    )
    select
      pr.id,
      v_uid,
      'system'::public.notification_type,
      'نداء استغاثة',
      'SOS alert',
      v_name || ' يحتاج إلى مساعدة فورية',
      v_name || ' needs immediate help',
      jsonb_build_object('route', 'sos', 'id', v_alert_id::text, 'kind', 'sos')
    from public.profiles pr
    where pr.role = 'admin'
      or (
        pr.role = 'operator'
        and v_group_id is not null
        and exists (
          select 1 from public.operator_group_access oga
          where oga.operator_id = pr.id and oga.group_id = v_group_id
        )
      );
  end if;

  return v_alert_id;
end;
$$;

revoke all on function public.raise_sos_alert from public;
grant execute on function public.raise_sos_alert to authenticated;

alter publication supabase_realtime add table public.sos_alerts;
alter publication supabase_realtime add table public.sos_location_pings;
