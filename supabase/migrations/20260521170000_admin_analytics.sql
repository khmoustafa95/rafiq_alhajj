-- US-07: Admin analytics — groups + admin read policies

create table public.groups (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  code text not null unique,
  created_at timestamptz not null default now()
);

alter table public.profiles
  add constraint profiles_group_id_fkey
  foreign key (group_id) references public.groups (id) on delete set null;

alter table public.groups enable row level security;

create policy "Admins read groups"
  on public.groups
  for select
  to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'admin'
    )
  );

create policy "Admins read all profiles"
  on public.profiles
  for select
  to authenticated
  using (
    exists (
      select 1 from public.profiles admin
      where admin.id = auth.uid() and admin.role = 'admin'
    )
  );

create policy "Admins read all pilgrim details"
  on public.pilgrim_details
  for select
  to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'admin'
    )
  );

create policy "Admins read all ritual logs"
  on public.ritual_logs
  for select
  to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'admin'
    )
  );

create policy "Admins read pilgrim documents metadata"
  on public.pilgrim_documents
  for select
  to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'admin'
    )
  );
