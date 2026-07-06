-- Per-platform app version policies for force / optional in-app updates.

create table public.app_version_policies (
  platform text primary key
    check (platform in ('android', 'ios', 'web')),
  min_version text not null default '1.0.0',
  latest_version text not null default '1.0.0',
  store_url text,
  release_notes_ar text,
  release_notes_en text,
  updated_at timestamptz not null default now(),
  updated_by uuid references auth.users (id) on delete set null
);

alter table public.app_version_policies enable row level security;

-- Guests and signed-in users must read policies before / without login.
create policy "Anyone read app version policies"
  on public.app_version_policies
  for select
  to anon, authenticated
  using (true);

create policy "Admins manage app version policies"
  on public.app_version_policies
  for all
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

insert into public.app_version_policies (platform, min_version, latest_version)
values
  ('android', '1.0.0', '1.0.0'),
  ('ios', '1.0.0', '1.0.0'),
  ('web', '1.0.0', '1.0.0')
on conflict (platform) do nothing;

alter publication supabase_realtime add table public.app_version_policies;
