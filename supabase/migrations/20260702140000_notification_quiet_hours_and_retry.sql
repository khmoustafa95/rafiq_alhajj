-- Quiet hours (global-app DND pattern) + admin manual retry for failed pushes.

alter table public.notification_preferences
  add column if not exists quiet_hours_enabled boolean not null default false,
  add column if not exists quiet_hours_start time not null default '22:00',
  add column if not exists quiet_hours_end time not null default '07:00',
  add column if not exists timezone_offset_minutes integer;

comment on column public.notification_preferences.timezone_offset_minutes is
  'Device UTC offset in minutes (DateTime.timeZoneOffset). Updated when the user saves preferences.';

-- ---------------------------------------------------------------------------
-- Admin: re-queue a single failed FCM delivery (same webhook as the trigger)
-- ---------------------------------------------------------------------------

create or replace function public.admin_retry_push_failure(p_failure_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_failure public.push_dispatch_failures%rowtype;
  v_notification public.notifications%rowtype;
  v_url text;
  v_secret text;
  v_environment text;
  v_record jsonb;
begin
  if not public.is_admin() then
    raise exception 'not authorized';
  end if;

  select * into v_failure
  from public.push_dispatch_failures
  where id = p_failure_id;

  if not found then
    raise exception 'failure not found';
  end if;

  select * into v_notification
  from public.notifications
  where id = v_failure.notification_id;

  if not found then
    raise exception 'notification not found';
  end if;

  v_environment := nullif(current_setting('app.push_environment', true), '');
  v_url := nullif(current_setting('app.supabase_functions_url', true), '');
  v_secret := nullif(current_setting('app.push_webhook_secret', true), '');

  if v_environment = 'production' and (v_url is null or v_secret is null) then
    raise exception 'push dispatch not configured for production';
  end if;

  if v_url is null then
    v_url := 'http://host.docker.internal:54321/functions/v1/send-push-notification';
  end if;
  if v_secret is null then
    v_secret := 'dev-local-push-secret';
  end if;

  v_record := jsonb_build_object(
    'id', v_notification.id,
    'recipient_id', v_notification.recipient_id,
    'type', v_notification.type::text,
    'title_ar', v_notification.title_ar,
    'title_en', v_notification.title_en,
    'body_ar', v_notification.body_ar,
    'body_en', v_notification.body_en,
    'payload', v_notification.payload
  );

  perform net.http_post(
    url := v_url,
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'x-push-secret', v_secret
    ),
    body := jsonb_build_object(
      'type', 'INSERT',
      'table', 'notifications',
      'records', jsonb_build_array(v_record)
    )
  );
end;
$$;

grant execute on function public.admin_retry_push_failure(uuid) to authenticated;
