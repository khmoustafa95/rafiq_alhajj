-- Phase 3: FCM device tokens + best-effort push dispatch via Edge Function

create table public.device_tokens (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  token text not null,
  platform text not null check (platform in ('android', 'ios', 'web')),
  updated_at timestamptz not null default now(),
  unique (profile_id, token)
);

create index device_tokens_profile_idx on public.device_tokens (profile_id);

alter table public.device_tokens enable row level security;

create policy "Users manage own device tokens"
  on public.device_tokens
  for all
  to authenticated
  using (profile_id = auth.uid())
  with check (profile_id = auth.uid());

-- pg_net: dispatch push when a notification row is inserted (best-effort)
create extension if not exists pg_net with schema extensions;

create or replace function public.trg_dispatch_push_notification()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_url text;
  v_secret text;
  v_request_id bigint;
begin
  v_url := coalesce(
    nullif(current_setting('app.supabase_functions_url', true), ''),
    'http://host.docker.internal:54321/functions/v1/send-push-notification'
  );
  v_secret := coalesce(
    nullif(current_setting('app.push_webhook_secret', true), ''),
    'dev-local-push-secret'
  );

  select net.http_post(
    url := v_url,
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'x-push-secret', v_secret
    ),
    body := jsonb_build_object(
      'type', 'INSERT',
      'table', 'notifications',
      'record', jsonb_build_object(
        'id', NEW.id,
        'recipient_id', NEW.recipient_id,
        'title_ar', NEW.title_ar,
        'title_en', NEW.title_en,
        'body_ar', NEW.body_ar,
        'body_en', NEW.body_en,
        'payload', NEW.payload
      )
    )
  ) into v_request_id;

  return NEW;
exception
  when others then
    -- Inbox + in-app Realtime still work if push dispatch fails
    return NEW;
end;
$$;

create trigger on_notification_insert_dispatch_push
  after insert on public.notifications
  for each row
  execute function public.trg_dispatch_push_notification();
