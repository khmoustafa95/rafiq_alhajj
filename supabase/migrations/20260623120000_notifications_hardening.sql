-- Notifications hardening (audit follow-up)
--   #8  Harden push-dispatch config: warn loudly when prod settings are missing
--       instead of silently using a dev secret the Edge Function rejects.
--   #10 Batch push dispatch: one Edge Function call per INSERT statement
--       (statement-level trigger + transition table) instead of one HTTP call
--       per recipient row — drastically fewer invocations for broadcasts.
--   #9  Produce `ritual_update` notifications when an operator changes a
--       pilgrim's field status.

-- ---------------------------------------------------------------------------
-- #8 + #10: statement-level batched push dispatch
-- ---------------------------------------------------------------------------

create or replace function public.trg_dispatch_push_notifications()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_url text;
  v_secret text;
  v_records jsonb;
begin
  v_url := nullif(current_setting('app.supabase_functions_url', true), '');
  v_secret := nullif(current_setting('app.push_webhook_secret', true), '');

  -- Local-dev fallbacks. In production both settings MUST be configured; warn
  -- so a misconfiguration is visible in logs rather than silently failing with
  -- a dev secret the Edge Function won't accept.
  if v_url is null then
    raise log 'push dispatch: app.supabase_functions_url not set; using local default';
    v_url := 'http://host.docker.internal:54321/functions/v1/send-push-notification';
  end if;
  if v_secret is null then
    raise log 'push dispatch: app.push_webhook_secret not set; using local default';
    v_secret := 'dev-local-push-secret';
  end if;

  -- Aggregate every row inserted by this statement into a single payload.
  select jsonb_agg(
    jsonb_build_object(
      'id', n.id,
      'recipient_id', n.recipient_id,
      'title_ar', n.title_ar,
      'title_en', n.title_en,
      'body_ar', n.body_ar,
      'body_en', n.body_en,
      'payload', n.payload
    )
  )
  into v_records
  from new_notifications n;

  if v_records is null then
    return null;
  end if;

  perform net.http_post(
    url := v_url,
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'x-push-secret', v_secret
    ),
    body := jsonb_build_object(
      'type', 'INSERT',
      'table', 'notifications',
      'records', v_records
    )
  );

  return null;
exception
  when others then
    -- Inbox + in-app Realtime still work if push dispatch fails.
    raise log 'push dispatch failed: %', sqlerrm;
    return null;
end;
$$;

-- Replace the per-row trigger/function with the statement-level batch variant.
drop trigger if exists on_notification_insert_dispatch_push on public.notifications;
drop function if exists public.trg_dispatch_push_notification();

create trigger on_notification_insert_dispatch_push
  after insert on public.notifications
  referencing new table as new_notifications
  for each statement
  execute function public.trg_dispatch_push_notifications();

-- ---------------------------------------------------------------------------
-- #9: notify a pilgrim when their field status changes (ritual_update)
-- ---------------------------------------------------------------------------

create or replace function public.trg_notify_field_status_update()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid;
begin
  -- Only when the status actually changed to a non-null value.
  if NEW.field_status is null
     or NEW.field_status is not distinct from OLD.field_status then
    return NEW;
  end if;

  select profile_id into v_profile_id
  from public.pilgrims
  where id = NEW.pilgrim_id;

  -- Pilgrim has no login account → nothing to deliver.
  if v_profile_id is null then
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
  values (
    v_profile_id,
    'ritual_update'::public.notification_type,
    'تحديث حالتك',
    'Status update',
    'تم تحديث حالتك الميدانية إلى: ' || NEW.field_status,
    'Your field status was updated to: ' || NEW.field_status,
    jsonb_build_object('route', 'pilgrim')
  );

  return NEW;
end;
$$;

create trigger on_enrollment_field_status_notify
  after update of field_status on public.trip_enrollments
  for each row
  execute function public.trg_notify_field_status_update();
