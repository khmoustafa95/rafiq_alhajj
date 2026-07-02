-- Per-user notification preferences (global-app pattern: category toggles)
-- and dispatch payload enrichment (include notification `type` for Edge filtering).

create table public.notification_preferences (
  profile_id uuid primary key references public.profiles (id) on delete cascade,
  push_enabled boolean not null default true,
  push_announcements boolean not null default true,
  push_content boolean not null default true,
  push_competitions boolean not null default true,
  push_urgent boolean not null default true,
  updated_at timestamptz not null default now()
);

alter table public.notification_preferences enable row level security;

create policy "Users manage own notification preferences"
  on public.notification_preferences
  for all
  to authenticated
  using (profile_id = auth.uid())
  with check (profile_id = auth.uid());

-- Include `type` in the batched webhook payload so the Edge Function can
-- honour per-user category preferences without an extra DB round-trip.
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
      'type', n.type::text,
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
