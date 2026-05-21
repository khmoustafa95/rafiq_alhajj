-- Profiles linked to Supabase Auth (US-03: pilgrim login + role-based access)

create type public.user_role as enum (
  'pilgrim',
  'operator',
  'admin'
);

create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  full_name text,
  role public.user_role not null default 'pilgrim',
  group_id uuid,
  updated_at timestamptz not null default now()
);

create index profiles_role_idx on public.profiles (role);

alter table public.profiles enable row level security;

create policy "Users read own profile"
  on public.profiles
  for select
  to authenticated
  using (auth.uid() = id);

create policy "Users update own profile"
  on public.profiles
  for update
  to authenticated
  using (auth.uid() = id)
  with check (auth.uid() = id);

-- Auto-create profile row when auth user is created (e.g. via dashboard / CLI)
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, full_name, role)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'full_name', new.email),
    coalesce(
      (new.raw_user_meta_data ->> 'role')::public.user_role,
      'pilgrim'::public.user_role
    )
  );
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row
  execute function public.handle_new_user();
