-- Public announcements visible to guest (anon) app users + admin broadcast mirror

create table public.public_announcements (
  id uuid primary key default gen_random_uuid(),
  title_ar text not null,
  title_en text not null,
  body_ar text,
  body_en text,
  payload jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create index public_announcements_created_idx
  on public.public_announcements (created_at desc);

alter table public.public_announcements enable row level security;

create policy "Public announcements readable by everyone"
  on public.public_announcements
  for select
  to anon, authenticated
  using (true);

alter publication supabase_realtime add table public.public_announcements;

-- Mirror pilgrim broadcasts so guests can read admin updates in the inbox
create or replace function public.send_notification_broadcast(
  p_audience text,
  p_title_ar text,
  p_title_en text,
  p_body_ar text default null,
  p_body_en text default null,
  p_payload jsonb default '{}'::jsonb,
  p_group_id uuid default null
)
returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
  v_count integer;
begin
  if auth.uid() is null then
    raise exception 'not authenticated';
  end if;

  if not exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'admin'
  ) then
    raise exception 'not authorized';
  end if;

  if p_audience = 'group_pilgrims' and p_group_id is null then
    raise exception 'group_id required for group_pilgrims audience';
  end if;

  insert into public.notifications (
    recipient_id,
    sender_id,
    type,
    title_ar,
    title_en,
    body_ar,
    body_en,
    payload
  )
  select
    p.id,
    auth.uid(),
    'announcement'::public.notification_type,
    p_title_ar,
    p_title_en,
    p_body_ar,
    p_body_en,
    coalesce(p_payload, '{}'::jsonb)
  from public.profiles p
  where
    (p_audience = 'all_pilgrims' and p.role = 'pilgrim')
    or (p_audience = 'all_operators' and p.role = 'operator')
    or (
      p_audience = 'group_pilgrims'
      and p.role = 'pilgrim'
      and p.group_id = p_group_id
    );

  get diagnostics v_count = row_count;

  if p_audience in ('all_pilgrims', 'group_pilgrims') then
    insert into public.public_announcements (
      title_ar,
      title_en,
      body_ar,
      body_en,
      payload
    )
    values (
      p_title_ar,
      p_title_en,
      p_body_ar,
      p_body_en,
      coalesce(p_payload, '{}'::jsonb)
    );
  end if;

  return v_count;
end;
$$;
