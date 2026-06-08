-- Admin group management: leadership, logo, administration members.

alter table public.groups
  add column if not exists logo_url text,
  add column if not exists president_name text,
  add column if not exists president_phone text,
  add column if not exists updated_at timestamptz not null default now();

create table if not exists public.group_administration_members (
  id uuid primary key default gen_random_uuid(),
  group_id uuid not null references public.groups (id) on delete cascade,
  name text not null,
  position text,
  contact text,
  photo_url text,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

create index if not exists group_administration_members_group_id_idx
  on public.group_administration_members (group_id);

alter table public.group_administration_members enable row level security;

drop policy if exists "Admins insert groups" on public.groups;
create policy "Admins insert groups"
  on public.groups
  for insert
  to authenticated
  with check (public.is_admin());

drop policy if exists "Admins update groups" on public.groups;
create policy "Admins update groups"
  on public.groups
  for update
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists "Admins delete groups" on public.groups;
create policy "Admins delete groups"
  on public.groups
  for delete
  to authenticated
  using (public.is_admin());

drop policy if exists "Admins read group members" on public.group_administration_members;
create policy "Admins read group members"
  on public.group_administration_members
  for select
  to authenticated
  using (public.is_admin());

drop policy if exists "Admins insert group members" on public.group_administration_members;
create policy "Admins insert group members"
  on public.group_administration_members
  for insert
  to authenticated
  with check (public.is_admin());

drop policy if exists "Admins update group members" on public.group_administration_members;
create policy "Admins update group members"
  on public.group_administration_members
  for update
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists "Admins delete group members" on public.group_administration_members;
create policy "Admins delete group members"
  on public.group_administration_members
  for delete
  to authenticated
  using (public.is_admin());

insert into storage.buckets (id, name, public)
values ('group-assets', 'group-assets', true)
on conflict (id) do nothing;

drop policy if exists "Anyone read group assets" on storage.objects;
create policy "Anyone read group assets"
  on storage.objects
  for select
  using (bucket_id = 'group-assets');

drop policy if exists "Admins upload group assets" on storage.objects;
create policy "Admins upload group assets"
  on storage.objects
  for insert
  to authenticated
  with check (bucket_id = 'group-assets' and public.is_admin());

drop policy if exists "Admins update group assets" on storage.objects;
create policy "Admins update group assets"
  on storage.objects
  for update
  to authenticated
  using (bucket_id = 'group-assets' and public.is_admin());

drop policy if exists "Admins delete group assets" on storage.objects;
create policy "Admins delete group assets"
  on storage.objects
  for delete
  to authenticated
  using (bucket_id = 'group-assets' and public.is_admin());

alter publication supabase_realtime add table public.group_administration_members;
