-- Consolidated admin dashboard metrics (single round-trip).
-- Replaces N parallel PostgREST queries from the Flutter admin dashboard.

create or replace function public.fetch_admin_dashboard_stats(p_trip_id uuid default null)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_trip_label text;
  v_enrollment jsonb;
  v_pilgrims_by_group jsonb;
  v_field_status jsonb;
  v_operator_uploads jsonb;
begin
  if not public.is_admin() then
    raise exception 'not authorized';
  end if;

  if p_trip_id is not null then
    select trim(concat(
      coalesce(t.type, ''),
      case when t.season_year is null then '' else ' ' || t.season_year::text end,
      ' · ',
      coalesce(t.name, '')
    ))
    into v_trip_label
    from public.trips t
    where t.id = p_trip_id;
  end if;

  select jsonb_build_object(
    'pilgrim_count', count(*)::int,
    'unassigned_pilgrim_count', count(*) filter (where te.group_id is null)::int,
    'special_needs_count', count(*) filter (where te.needs_wheelchair is true)::int,
    'missing_travel_permit_count', count(*) filter (
      where te.travel_permit_number is null
        or btrim(te.travel_permit_number) = ''
    )::int,
    'missing_medical_test_count', count(*) filter (
      where te.medical_test_status is null
        or btrim(te.medical_test_status) = ''
    )::int,
    'pilgrims_without_login_count', count(*) filter (
      where p.profile_id is null
    )::int,
    'arrived_hotel_count', count(*) filter (
      where te.field_status in ('arrived_hotel', 'completed')
    )::int,
    'pending_field_count', count(*) filter (where te.field_status = 'pending')::int,
    'in_transit_count', count(*) filter (
      where te.field_status in ('in_transit', 'medical_done')
    )::int
  )
  into v_enrollment
  from public.trip_enrollments te
  left join public.pilgrims p on p.id = te.pilgrim_id
  where p_trip_id is null or te.trip_id = p_trip_id;

  select coalesce(
    jsonb_agg(
      jsonb_build_object('label', label, 'value', value)
      order by value desc
    ),
    '[]'::jsonb
  )
  into v_pilgrims_by_group
  from (
    select
      coalesce(g.name, '__unassigned__') as label,
      count(*)::int as value
    from public.trip_enrollments te
    left join public.groups g on g.id = te.group_id
    where p_trip_id is null or te.trip_id = p_trip_id
    group by coalesce(g.name, '__unassigned__')
  ) grouped;

  select coalesce(
    jsonb_agg(
      jsonb_build_object('label', label, 'value', value)
      order by value desc
    ),
    '[]'::jsonb
  )
  into v_field_status
  from (
    select
      coalesce(te.field_status, 'pending') as label,
      count(*)::int as value
    from public.trip_enrollments te
    where p_trip_id is null or te.trip_id = p_trip_id
    group by coalesce(te.field_status, 'pending')
  ) statuses;

  select coalesce(
    jsonb_agg(
      jsonb_build_object('label', label, 'value', value)
      order by value desc
    ),
    '[]'::jsonb
  )
  into v_operator_uploads
  from (
    select
      coalesce(pr.full_name, '__unknown__') as label,
      count(*)::int as value
    from public.pilgrim_documents pd
    left join public.profiles pr on pr.id = pd.uploaded_by
    group by coalesce(pr.full_name, '__unknown__')
  ) uploads;

  return jsonb_build_object(
    'scoped_trip_id', p_trip_id,
    'scoped_trip_label', v_trip_label,
    'pilgrim_count', coalesce((v_enrollment->>'pilgrim_count')::int, 0),
    'operator_count', (
      select count(*)::int from public.profiles where role = 'operator'
    ),
    'group_count', (select count(*)::int from public.groups),
    'arrived_hotel_count', coalesce((v_enrollment->>'arrived_hotel_count')::int, 0),
    'pending_field_count', coalesce((v_enrollment->>'pending_field_count')::int, 0),
    'in_transit_count', coalesce((v_enrollment->>'in_transit_count')::int, 0),
    'active_sos_count', (
      select count(*)::int from public.sos_alerts where status = 'active'
    ),
    'unassigned_pilgrim_count',
      coalesce((v_enrollment->>'unassigned_pilgrim_count')::int, 0),
    'special_needs_count', coalesce((v_enrollment->>'special_needs_count')::int, 0),
    'missing_travel_permit_count',
      coalesce((v_enrollment->>'missing_travel_permit_count')::int, 0),
    'missing_medical_test_count',
      coalesce((v_enrollment->>'missing_medical_test_count')::int, 0),
    'pilgrims_without_login_count',
      coalesce((v_enrollment->>'pilgrims_without_login_count')::int, 0),
    'pilgrim_push_token_count', (
      select count(distinct dt.profile_id)::int
      from public.device_tokens dt
      join public.profiles pr on pr.id = dt.profile_id
      where pr.role = 'pilgrim'
    ),
    'push_failure_count', (
      select count(*)::int from public.push_dispatch_failures
    ),
    'active_competition_count', (
      select count(*)::int from public.competitions where is_active = true
    ),
    'competition_participant_count', (
      select count(*)::int from public.competition_entries
    ),
    'published_content_count', (
      (select count(*)::int from public.content_library)
      + (select count(*)::int from public.content_topics)
    ),
    'pilgrims_by_group', v_pilgrims_by_group,
    'field_status_breakdown', v_field_status,
    'operator_document_uploads', v_operator_uploads
  );
end;
$$;

revoke all on function public.fetch_admin_dashboard_stats(uuid) from public;
grant execute on function public.fetch_admin_dashboard_stats(uuid) to authenticated;
