-- Demo accounts (run after db reset):
--   supabase auth users create pilgrim@demo.local --password demo123456 --email-confirm
--   supabase auth users create operator@demo.local --password demo123456 --email-confirm --user-metadata "{\"role\":\"operator\",\"full_name\":\"محمد التقني\"}"
--   supabase auth users create admin@demo.local --password demo123456 --email-confirm --user-metadata "{\"role\":\"admin\",\"full_name\":\"خالد المسؤول\"}"

insert into public.groups (id, name, code)
values
  ('11111111-1111-1111-1111-111111111101', 'Makkah Group A', 'MK-A'),
  ('11111111-1111-1111-1111-111111111102', 'Madinah Group B', 'MD-B')
on conflict (code) do nothing;

update public.profiles
set group_id = '11111111-1111-1111-1111-111111111101'
where role = 'pilgrim'
  and group_id is null;

insert into public.content_library (title, description, media_url, type, visibility)
values
  (
    'Introduction to Hajj rituals',
    'A short overview of the main steps every pilgrim should know before travel.',
    'https://www.youtube.com/watch?v=example-hajj-intro',
    'video',
    'public'
  ),
  (
    'Health tips before departure',
    'Guidance on vaccinations, hydration, and medical checkups for pilgrims.',
    'https://www.youtube.com/watch?v=example-health-tips',
    'video',
    'public'
  ),
  (
    'Consortium welcomes this season''s pilgrims',
    'Our centers are ready to support groups with registration and field coordination.',
    null,
    'news',
    'public'
  ),
  (
    'New awareness video series available',
    'Browse the public library for educational content — no account required.',
    null,
    'announcement',
    'public'
  ),
  (
    'Exclusive: your group orientation schedule',
    'Available after pilgrim sign-in only.',
    null,
    'news',
    'pilgrim_only'
  );

-- Pilgrim registry demo data: 12 pilgrims (all field_status values) are seeded by
--   npm run setup:users
-- after auth users exist. Source: scripts/fake-pilgrim-registry.json

-- US-10: Demo competitions
insert into public.competitions (title, description, starts_at, ends_at, is_active)
values
  (
    'Hajj awareness quiz',
    'Answer daily awareness questions and climb the leaderboard.',
    now() - interval '1 day',
    now() + interval '90 days',
    true
  ),
  (
    'Ritual progress challenge',
    'Log your ritual checklist progress — top pilgrims earn recognition.',
    now() - interval '1 day',
    now() + interval '60 days',
    true
  );
