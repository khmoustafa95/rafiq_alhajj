-- Thematic content topics with ordered media series (video / audio / image).

create type public.content_media_type as enum ('video', 'audio', 'image');

create table public.content_topics (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  cover_image_url text,
  visibility public.content_visibility not null default 'public',
  sort_order integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index content_topics_visibility_idx
  on public.content_topics (visibility, sort_order, created_at desc);

create table public.content_topic_media (
  id uuid primary key default gen_random_uuid(),
  topic_id uuid not null references public.content_topics (id) on delete cascade,
  media_type public.content_media_type not null,
  title text,
  url text not null,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create index content_topic_media_topic_idx
  on public.content_topic_media (topic_id, sort_order);

alter table public.content_topics enable row level security;
alter table public.content_topic_media enable row level security;

create policy "Public topics readable by everyone"
  on public.content_topics
  for select
  to anon, authenticated
  using (is_active and visibility = 'public');

create policy "Pilgrim-only topics for pilgrims"
  on public.content_topics
  for select
  to authenticated
  using (
    is_active
    and visibility = 'pilgrim_only'
    and exists (
      select 1
      from public.profiles
      where profiles.id = auth.uid()
        and profiles.role = 'pilgrim'
    )
  );

create policy "Admins manage content topics"
  on public.content_topics
  for all
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

create policy "Topic media readable for visible topics"
  on public.content_topic_media
  for select
  to anon, authenticated
  using (
    exists (
      select 1
      from public.content_topics t
      where t.id = topic_id
        and t.is_active
        and (
          t.visibility = 'public'
          or (
            t.visibility = 'pilgrim_only'
            and auth.uid() is not null
            and exists (
              select 1
              from public.profiles p
              where p.id = auth.uid() and p.role = 'pilgrim'
            )
          )
        )
    )
  );

create policy "Admins manage topic media"
  on public.content_topic_media
  for all
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

alter publication supabase_realtime add table public.content_topics;
alter publication supabase_realtime add table public.content_topic_media;

-- Demo: فقه الحج topic with video, audio, and image series.
insert into public.content_topics
  (title, description, cover_image_url, visibility, sort_order)
values
  (
    'فقه الحج',
    'سلسلة تعليمية في أحكام ومناسك الحج للحاج والمعتمر، تشمل شروحات مرئية ومسموعة وصور توضيحية.',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Kaaba_mirror_edit00.jpg/640px-Kaaba_mirror_edit00.jpg',
    'public',
    1
  ),
  (
    'آداب وزيارة المدينة',
    'تعرف على آداب زيارة المسجد النبوي والصلاة في الروضة الشريفة.',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Masjid_Nabawi_The_Prophet%27s_Mosque_in_Medina.jpg/640px-Masjid_Nabawi_The_Prophet%27s_Mosque_in_Medina.jpg',
    'public',
    2
  );

insert into public.content_topic_media (topic_id, media_type, title, url, sort_order)
select t.id, 'video', 'مقدمة في فقه الحج',
  'https://www.youtube.com/embed/0J7V4JDc8gY', 1
from public.content_topics t where t.title = 'فقه الحج';

insert into public.content_topic_media (topic_id, media_type, title, url, sort_order)
select t.id, 'video', 'أركان وواجبات الحج',
  'https://www.youtube.com/embed/dQw4w9WgXcQ', 2
from public.content_topics t where t.title = 'فقه الحج';

insert into public.content_topic_media (topic_id, media_type, title, url, sort_order)
select t.id, 'audio', 'تلبية الحج',
  'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3', 3
from public.content_topics t where t.title = 'فقه الحج';

insert into public.content_topic_media (topic_id, media_type, title, url, sort_order)
select t.id, 'image', 'الكعبة المشرفة',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Kaaba_mirror_edit00.jpg/640px-Kaaba_mirror_edit00.jpg', 4
from public.content_topics t where t.title = 'فقه الحج';

insert into public.content_topic_media (topic_id, media_type, title, url, sort_order)
select t.id, 'image', 'جبل عرفة',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Mount_Arafat.jpg/640px-Mount_Arafat.jpg', 5
from public.content_topics t where t.title = 'فقه الحج';

insert into public.content_topic_media (topic_id, media_type, title, url, sort_order)
select t.id, 'image', 'منى',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Mina%2C_Saudi_Arabia.jpg/640px-Mina%2C_Saudi_Arabia.jpg', 6
from public.content_topics t where t.title = 'فقه الحج';

insert into public.content_topic_media (topic_id, media_type, title, url, sort_order)
select t.id, 'video', 'زيارة المسجد النبوي',
  'https://www.youtube.com/embed/0J7V4JDc8gY', 1
from public.content_topics t where t.title = 'آداب وزيارة المدينة';
