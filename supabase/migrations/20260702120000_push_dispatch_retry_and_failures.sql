-- Push dispatch: production guard + failure observability
--   * When app.push_environment = 'production', refuse dev fallbacks for the
--     webhook URL/secret (inbox still inserts; only FCM dispatch is skipped).
--   * push_dispatch_failures table logs sends that still fail after Edge retries.

-- ---------------------------------------------------------------------------
-- Failure log (written by send-push-notification Edge Function via service role)
-- ---------------------------------------------------------------------------

create table public.push_dispatch_failures (
  id uuid primary key default gen_random_uuid(),
  notification_id uuid not null references public.notifications (id) on delete cascade,
  recipient_id uuid not null references public.profiles (id) on delete cascade,
  device_token text not null,
  error text not null,
  attempts integer not null default 1 check (attempts > 0),
  created_at timestamptz not null default now()
);

create index push_dispatch_failures_notification_idx
  on public.push_dispatch_failures (notification_id);

create index push_dispatch_failures_created_idx
  on public.push_dispatch_failures (created_at desc);

alter table public.push_dispatch_failures enable row level security;

create policy "Admins read push dispatch failures"
  on public.push_dispatch_failures
  for select
  to authenticated
  using (public.is_admin());

-- ---------------------------------------------------------------------------
-- Production guard on the statement-level dispatch trigger
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
  v_environment text;
begin
  v_environment := nullif(current_setting('app.push_environment', true), '');
  v_url := nullif(current_setting('app.supabase_functions_url', true), '');
  v_secret := nullif(current_setting('app.push_webhook_secret', true), '');

  if v_environment = 'production' and (v_url is null or v_secret is null) then
    raise log
      'push dispatch ABORTED (production): set app.supabase_functions_url and app.push_webhook_secret on the database';
    return null;
  end if;

  -- Local-dev fallbacks. In production both settings MUST be configured above.
  if v_url is null then
    raise log 'push dispatch: app.supabase_functions_url not set; using local default';
    v_url := 'http://host.docker.internal:54321/functions/v1/send-push-notification';
  end if;
  if v_secret is null then
    raise log 'push dispatch: app.push_webhook_secret not set; using local default';
    v_secret := 'dev-local-push-secret';
  end if;

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
    raise log 'push dispatch failed: %', sqlerrm;
    return null;
end;
$$;
