-- Bilingual fields, draft/publish workflow, and server-synced learning progress.

create type public.content_publication_status as enum ('draft', 'published');

-- ── content_library ──────────────────────────────────────────────────────────

alter table public.content_library
  add column title_ar text,
  add column title_en text,
  add column description_ar text,
  add column description_en text,
  add column publication_status public.content_publication_status not null default 'published',
  add column published_at timestamptz;

update public.content_library
set
  title_ar = title,
  description_ar = description,
  published_at = created_at
where title_ar is null;

alter table public.content_library
  alter column title_ar set not null;

create index content_library_publication_idx
  on public.content_library (publication_status, published_at desc nulls last);

-- Pilgrims/guests only see published items whose publish time has passed.
drop policy if exists "Public content readable by everyone" on public.content_library;
create policy "Public content readable by everyone"
  on public.content_library
  for select
  to anon, authenticated
  using (
    visibility = 'public'
    and publication_status = 'published'
    and (published_at is null or published_at <= now())
  );

drop policy if exists "Pilgrim-only content for pilgrims" on public.content_library;
create policy "Pilgrim-only content for pilgrims"
  on public.content_library
  for select
  to authenticated
  using (
    visibility = 'pilgrim_only'
    and publication_status = 'published'
    and (published_at is null or published_at <= now())
    and exists (
      select 1
      from public.profiles
      where profiles.id = auth.uid()
        and profiles.role = 'pilgrim'
    )
  );

-- ── content_topics ───────────────────────────────────────────────────────────

alter table public.content_topics
  add column title_ar text,
  add column title_en text,
  add column description_ar text,
  add column description_en text,
  add column publication_status public.content_publication_status not null default 'published',
  add column published_at timestamptz;

update public.content_topics
set
  title_ar = title,
  description_ar = description,
  published_at = created_at
where title_ar is null;

alter table public.content_topics
  alter column title_ar set not null;

create index content_topics_publication_idx
  on public.content_topics (publication_status, published_at desc nulls last);

drop policy if exists "Public topics readable by everyone" on public.content_topics;
create policy "Public topics readable by everyone"
  on public.content_topics
  for select
  to anon, authenticated
  using (
    is_active
    and visibility = 'public'
    and publication_status = 'published'
    and (published_at is null or published_at <= now())
  );

drop policy if exists "Pilgrim-only topics for pilgrims" on public.content_topics;
create policy "Pilgrim-only topics for pilgrims"
  on public.content_topics
  for select
  to authenticated
  using (
    is_active
    and visibility = 'pilgrim_only'
    and publication_status = 'published'
    and (published_at is null or published_at <= now())
    and exists (
      select 1
      from public.profiles
      where profiles.id = auth.uid()
        and profiles.role = 'pilgrim'
    )
  );

-- Topic media inherits topic visibility + publication via the existing join policy.

-- ── content_learning_progress (server-synced per pilgrim) ────────────────────

create table public.content_learning_progress (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  topic_id uuid not null references public.content_topics (id) on delete cascade,
  media_id uuid references public.content_topic_media (id) on delete set null,
  topic_title text,
  media_title text,
  position_ms integer not null default 0,
  completed boolean not null default false,
  updated_at timestamptz not null default now(),
  unique (profile_id, media_id)
);

create index content_learning_progress_profile_idx
  on public.content_learning_progress (profile_id, updated_at desc);

alter table public.content_learning_progress enable row level security;

create policy "Pilgrims manage own learning progress"
  on public.content_learning_progress
  for all
  to authenticated
  using (profile_id = auth.uid())
  with check (profile_id = auth.uid());

alter publication supabase_realtime add table public.content_learning_progress;
