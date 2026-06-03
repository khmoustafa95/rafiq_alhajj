-- US-10: Pilgrim competitions — awareness quizzes / group challenges

create table public.competitions (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  starts_at timestamptz not null,
  ends_at timestamptz not null,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table public.competition_entries (
  id uuid primary key default gen_random_uuid(),
  competition_id uuid not null references public.competitions (id) on delete cascade,
  profile_id uuid not null references public.profiles (id) on delete cascade,
  score integer not null default 0 check (score >= 0),
  joined_at timestamptz not null default now(),
  unique (competition_id, profile_id)
);

create index competition_entries_competition_idx
  on public.competition_entries (competition_id, score desc);

alter table public.competitions enable row level security;
alter table public.competition_entries enable row level security;

-- Active competitions visible to everyone (guest app can browse titles)
create policy "Anyone reads active competitions"
  on public.competitions
  for select
  to anon, authenticated
  using (is_active and ends_at >= now());

create policy "Admins manage competitions"
  on public.competitions
  for all
  to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'admin'
    )
  )
  with check (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'admin'
    )
  );

create policy "Anyone reads competition entries"
  on public.competition_entries
  for select
  to anon, authenticated
  using (true);

create policy "Pilgrims join competitions"
  on public.competition_entries
  for insert
  to authenticated
  with check (
    profile_id = auth.uid()
    and exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'pilgrim'
    )
  );

create policy "Pilgrims update own entry score"
  on public.competition_entries
  for update
  to authenticated
  using (profile_id = auth.uid())
  with check (profile_id = auth.uid());
