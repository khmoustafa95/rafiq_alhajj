-- Admin system settings (single global row).

create table public.system_settings (
  id text primary key default 'global',
  organization_name text not null default 'Rafiq Al-Hajj',
  support_email text,
  support_phone text,
  hajj_season_label text,
  registration_open boolean not null default true,
  maintenance_mode boolean not null default false,
  maintenance_message text,
  require_documents_on_intake boolean not null default true,
  auto_generate_pilgrim_password boolean not null default true,
  allow_operator_self_registration boolean not null default false,
  enable_public_content_feed boolean not null default true,
  enable_competitions boolean not null default true,
  enable_push_notifications boolean not null default true,
  enable_in_app_notifications boolean not null default true,
  pilgrim_ritual_tracking_enabled boolean not null default true,
  max_pilgrims_per_group int,
  updated_at timestamptz not null default now(),
  updated_by uuid references auth.users (id) on delete set null
);

alter table public.system_settings enable row level security;

drop policy if exists "Authenticated read system settings" on public.system_settings;
create policy "Authenticated read system settings"
  on public.system_settings
  for select
  to authenticated
  using (true);

drop policy if exists "Admins update system settings" on public.system_settings;
create policy "Admins update system settings"
  on public.system_settings
  for update
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

insert into public.system_settings (id, organization_name, hajj_season_label)
values ('global', 'Rafiq Al-Hajj', '1447 AH / 2026')
on conflict (id) do nothing;

alter publication supabase_realtime add table public.system_settings;
