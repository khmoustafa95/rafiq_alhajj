-- Opt-in content notifications + drop the automatic content-published trigger.
--
-- WHY:
--  Previously every INSERT into content_library auto-notified all pilgrims
--  (on_content_library_notify_pilgrims). That fired on edits-as-inserts, test
--  data, and gave admins no control. The redesign makes notifications explicit:
--  admins flip a "notify pilgrims" toggle and the app calls
--  publish_content_notification on create/edit when ON. The existing
--  statement-level on_notification_insert_dispatch_push trigger still fans the
--  inserted rows out to FCM.

-- 1) Remove the automatic per-row trigger + its function.
drop trigger if exists on_content_library_notify_pilgrims on public.content_library;
drop function if exists public.trg_notify_content_published();

-- 2) Admin-guarded RPC to publish a content notification on demand.
--    p_route is 'content' (feed item) or 'contentTopic' (library topic);
--    p_id is the row id; visibility scopes the audience (pilgrims only, since
--    public/pilgrim_only content is both relevant to logged-in pilgrims).
create or replace function public.publish_content_notification(
  p_title_ar text,
  p_title_en text,
  p_route text,
  p_id uuid,
  p_visibility public.content_visibility default 'public'
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

  insert into public.notifications (
    recipient_id,
    sender_id,
    type,
    title_ar,
    title_en,
    payload
  )
  select
    pr.id,
    auth.uid(),
    'content_published'::public.notification_type,
    p_title_ar,
    p_title_en,
    jsonb_build_object('route', p_route, 'id', p_id::text)
  from public.profiles pr
  where pr.role = 'pilgrim'
    and (
      p_visibility = 'public'::public.content_visibility
      or p_visibility = 'pilgrim_only'::public.content_visibility
    );

  get diagnostics v_count = row_count;
  return v_count;
end;
$$;

revoke all on function public.publish_content_notification from public;
grant execute on function public.publish_content_notification to authenticated;

-- 3) Cleanup: the standalone `video` content_library type is removed from the
--    app. Convert any existing rows to `news` so nothing references it.
--    (The unused enum value stays — removing an in-use Postgres enum value is
--    unsafe.)
update public.content_library
set type = 'news'::public.content_type
where type = 'video'::public.content_type;
