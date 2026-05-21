-- US-04: Pilgrim logistics + ritual progress

create table public.pilgrim_details (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null unique references public.profiles (id) on delete cascade,
  passport_number text,
  travel_permit_number text,
  medical_test_status text,
  travel_date date,
  hotel_name text,
  hotel_location_url text,
  transportation_details text,
  updated_at timestamptz not null default now()
);

create table public.ritual_logs (
  id uuid primary key default gen_random_uuid(),
  pilgrim_id uuid not null references public.profiles (id) on delete cascade,
  ritual_key text not null,
  is_completed boolean not null default false,
  completed_at timestamptz,
  updated_at timestamptz not null default now(),
  unique (pilgrim_id, ritual_key)
);

create index ritual_logs_pilgrim_idx on public.ritual_logs (pilgrim_id);

alter table public.pilgrim_details enable row level security;
alter table public.ritual_logs enable row level security;

create policy "Pilgrims read own details"
  on public.pilgrim_details
  for select
  to authenticated
  using (profile_id = auth.uid());

create policy "Pilgrims read own ritual logs"
  on public.ritual_logs
  for select
  to authenticated
  using (pilgrim_id = auth.uid());

create policy "Pilgrims insert own ritual logs"
  on public.ritual_logs
  for insert
  to authenticated
  with check (pilgrim_id = auth.uid());

create policy "Pilgrims update own ritual logs"
  on public.ritual_logs
  for update
  to authenticated
  using (pilgrim_id = auth.uid())
  with check (pilgrim_id = auth.uid());

-- Create empty logistics row when a pilgrim profile is created
create or replace function public.handle_new_pilgrim_profile()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if new.role = 'pilgrim' then
    insert into public.pilgrim_details (profile_id)
    values (new.id)
    on conflict (profile_id) do nothing;
  end if;
  return new;
end;
$$;

create trigger on_profile_pilgrim_details
  after insert on public.profiles
  for each row
  execute function public.handle_new_pilgrim_profile();
