-- Phase 2: admin broadcast RPC + automatic pilgrim notifications

-- Admin broadcast to pilgrims (all / group) or operators
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
  return v_count;
end;
$$;

revoke all on function public.send_notification_broadcast from public;
grant execute on function public.send_notification_broadcast to authenticated;

-- Notify pilgrims when new library content is added
create or replace function public.trg_notify_content_published()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.notifications (
    recipient_id,
    type,
    title_ar,
    title_en,
    body_ar,
    body_en,
    payload
  )
  select
    pr.id,
    'content_published'::public.notification_type,
    'محتوى جديد: ' || NEW.title,
    'New content: ' || NEW.title,
    left(coalesce(NEW.description, ''), 200),
    left(coalesce(NEW.description, ''), 200),
    jsonb_build_object('route', 'content', 'id', NEW.id::text)
  from public.profiles pr
  where pr.role = 'pilgrim'
    and (
      NEW.visibility = 'public'::public.content_visibility
      or NEW.visibility = 'pilgrim_only'::public.content_visibility
    );

  return NEW;
end;
$$;

create trigger on_content_library_notify_pilgrims
  after insert on public.content_library
  for each row
  execute function public.trg_notify_content_published();

-- Notify pilgrims when a competition becomes active
create or replace function public.trg_notify_competition_published()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if not NEW.is_active then
    return NEW;
  end if;

  if TG_OP = 'UPDATE' and OLD.is_active is not distinct from true then
    return NEW;
  end if;

  insert into public.notifications (
    recipient_id,
    type,
    title_ar,
    title_en,
    body_ar,
    body_en,
    payload
  )
  select
    pr.id,
    'competition'::public.notification_type,
    'مسابقة جديدة: ' || NEW.title,
    'New competition: ' || NEW.title,
    left(coalesce(NEW.description, ''), 200),
    left(coalesce(NEW.description, ''), 200),
    jsonb_build_object('route', 'competition', 'id', NEW.id::text)
  from public.profiles pr
  where pr.role = 'pilgrim';

  return NEW;
end;
$$;

create trigger on_competitions_notify_pilgrims
  after insert or update of is_active, title, description on public.competitions
  for each row
  execute function public.trg_notify_competition_published();
