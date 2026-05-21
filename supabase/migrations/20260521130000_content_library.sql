-- Public & pilgrim content (US-01 / FT-01)

create type public.content_type as enum ('video', 'news', 'announcement');

create type public.content_visibility as enum ('public', 'pilgrim_only');

create table public.content_library (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  media_url text,
  type public.content_type not null,
  visibility public.content_visibility not null default 'public',
  created_at timestamptz not null default now()
);

create index content_library_visibility_type_idx
  on public.content_library (visibility, type, created_at desc);

alter table public.content_library enable row level security;

create policy "Public content readable by everyone"
  on public.content_library
  for select
  to anon, authenticated
  using (visibility = 'public');

create policy "Pilgrim-only content for pilgrims"
  on public.content_library
  for select
  to authenticated
  using (
    visibility = 'pilgrim_only'
    and exists (
      select 1
      from public.profiles
      where profiles.id = auth.uid()
        and profiles.role = 'pilgrim'
    )
  );
