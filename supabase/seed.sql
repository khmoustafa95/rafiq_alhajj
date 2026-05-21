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

-- Demo logistics for pilgrim profiles (run after creating demo auth user)
insert into public.pilgrim_details (
  profile_id,
  passport_number,
  travel_permit_number,
  medical_test_status,
  field_status,
  travel_date,
  hotel_name,
  hotel_location_url,
  transportation_details
)
select
  id,
  'P1234567',
  'TP-2026-001',
  'Approved',
  'pending',
  '2026-06-01'::date,
  'Makkah Towers Hotel',
  'https://maps.google.com/?q=Makkah+Towers',
  'Group bus A — departs Mina 07:00 daily'
from public.profiles
where role = 'pilgrim'
on conflict (profile_id) do update set
  passport_number = excluded.passport_number,
  travel_permit_number = excluded.travel_permit_number,
  medical_test_status = excluded.medical_test_status,
  field_status = excluded.field_status,
  travel_date = excluded.travel_date,
  hotel_name = excluded.hotel_name,
  hotel_location_url = excluded.hotel_location_url,
  transportation_details = excluded.transportation_details;
