-- Unified pilgrim write + notify path.
--
-- A single SECURITY DEFINER RPC backs BOTH the single-pilgrim edit screen and
-- the new multi-record bulk edit. It:
--   * re-checks authorization (admins anywhere; operators only in groups they
--     can write), since SECURITY DEFINER bypasses RLS;
--   * applies only the keys present in p_person / p_enrollment (so untouched
--     fields are never overwritten in bulk edit);
--   * optionally sets the enrollment group and the login profile;
--   * when p_notify is true, inserts ONE batched notification per affected
--     pilgrim-with-login whose curated logistics fields actually changed,
--     reusing the existing statement-level FCM dispatch trigger.

create or replace function public.bulk_update_pilgrim_enrollments(
  p_pilgrim_ids uuid[],
  p_trip_id uuid default null,
  p_person jsonb default '{}'::jsonb,
  p_enrollment jsonb default '{}'::jsonb,
  p_group_id uuid default null,
  p_set_group boolean default false,
  p_set_profile boolean default false,
  p_notify boolean default false
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  -- Structural columns clients must never write through this RPC.
  v_person_denylist text[] := array[
    'id', 'profile_id', 'created_at', 'updated_at'
  ];
  v_enrollment_denylist text[] := array[
    'id', 'pilgrim_id', 'trip_id', 'registry_id', 'group_id',
    'created_at', 'updated_at'
  ];
  -- Logistics fields whose change is worth notifying the pilgrim about.
  v_curated text[] := array[
    'hotel_name', 'makkah_hotel', 'madinah_hotel', 'transportation_details',
    'travel_date', 'madinah_travel_date',
    'departure_airport', 'departure_airline', 'departure_flight_no',
    'departure_date', 'departure_time',
    'return_airport', 'return_airline', 'return_flight_no',
    'return_date', 'return_time',
    'service_center_name', 'service_center_arafat', 'service_center_mina',
    'bus_arafat', 'bus_mina', 'tent_arafat', 'tent_mina'
  ];
  v_set text;
begin
  if p_pilgrim_ids is null or array_length(p_pilgrim_ids, 1) is null then
    return jsonb_build_object('updated', 0);
  end if;

  -- ---- Authorization ------------------------------------------------------
  if not exists (
    select 1 from public.profiles
    where id = auth.uid() and role in ('operator', 'admin')
  ) then
    raise exception 'Not authorized' using errcode = '42501';
  end if;

  if not public.is_admin() then
    -- Operators may only touch enrollments in groups they can write.
    if exists (
      select 1
      from public.trip_enrollments te
      where te.pilgrim_id = any(p_pilgrim_ids)
        and (p_trip_id is null or te.trip_id = p_trip_id)
        and not public.operator_can_write_group(te.group_id)
    ) then
      raise exception 'Not authorized for one or more pilgrims'
        using errcode = '42501';
    end if;
    -- And may only move pilgrims into a group they can write.
    if p_set_group and p_group_id is not null
       and not public.operator_can_write_group(p_group_id) then
      raise exception 'Not authorized for the target group'
        using errcode = '42501';
    end if;
  end if;

  -- ---- Notify (before the update, so old vs new can be compared) ----------
  if p_notify then
    insert into public.notifications (
      recipient_id, type, title_ar, title_en, body_ar, body_en, payload
    )
    select distinct
      p.profile_id,
      'system'::public.notification_type,
      'تحديث بيانات رحلتك',
      'Trip details updated',
      'تم تحديث بيانات رحلتك من قبل المنظّم. اطّلع على التفاصيل.',
      'Your trip details were updated by your operator. Check the details.',
      jsonb_build_object('route', 'pilgrim')
    from public.trip_enrollments te
    join public.pilgrims p on p.id = te.pilgrim_id
    where te.pilgrim_id = any(p_pilgrim_ids)
      and (p_trip_id is null or te.trip_id = p_trip_id)
      and p.profile_id is not null
      and exists (
        select 1
        from jsonb_object_keys(p_enrollment) as k
        where k = any(v_curated)
          and (to_jsonb(te) ->> k) is distinct from (p_enrollment ->> k)
      );
  end if;

  -- ---- Person update (pilgrims) -------------------------------------------
  select string_agg(
           format('%I = nullif($1->>%L, %L)::%s',
                  c.column_name, c.column_name, '', c.udt_name),
           ', '
         )
  into v_set
  from information_schema.columns c
  where c.table_schema = 'public'
    and c.table_name = 'pilgrims'
    and c.column_name <> all(v_person_denylist)
    and (p_person ? c.column_name);

  if v_set is not null then
    execute format(
      'update public.pilgrims set %s, updated_at = now() where id = any($2)',
      v_set
    ) using p_person, p_pilgrim_ids;
  end if;

  -- ---- Enrollment update (trip_enrollments) -------------------------------
  select string_agg(
           format('%I = nullif($1->>%L, %L)::%s',
                  c.column_name, c.column_name, '', c.udt_name),
           ', '
         )
  into v_set
  from information_schema.columns c
  where c.table_schema = 'public'
    and c.table_name = 'trip_enrollments'
    and c.column_name <> all(v_enrollment_denylist)
    and (p_enrollment ? c.column_name);

  if v_set is not null then
    execute format(
      'update public.trip_enrollments set %s, updated_at = now() '
      'where pilgrim_id = any($2) and ($3::uuid is null or trip_id = $3::uuid)',
      v_set
    ) using p_enrollment, p_pilgrim_ids, p_trip_id;
  end if;

  -- ---- Group on the enrollment --------------------------------------------
  if p_set_group then
    update public.trip_enrollments
    set group_id = p_group_id, updated_at = now()
    where pilgrim_id = any(p_pilgrim_ids)
      and (p_trip_id is null or trip_id = p_trip_id);
  end if;

  -- ---- Login profile (full name + group) ----------------------------------
  if p_set_profile then
    update public.profiles pr
    set
      full_name = coalesce(
        nullif(p_person->>'full_name_ar', ''), pr.full_name
      ),
      group_id = case when p_set_group then p_group_id else pr.group_id end
    from public.pilgrims p
    where p.profile_id = pr.id
      and p.id = any(p_pilgrim_ids);
  end if;

  return jsonb_build_object('updated', coalesce(array_length(p_pilgrim_ids, 1), 0));
end;
$$;

grant execute on function public.bulk_update_pilgrim_enrollments(
  uuid[], uuid, jsonb, jsonb, uuid, boolean, boolean, boolean
) to authenticated;
