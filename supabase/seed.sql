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

-- Demo quiz questions for "Hajj awareness quiz"
do $$
declare
  v_competition_id uuid;
  v_question_id uuid;
begin
  select id into v_competition_id
  from public.competitions
  where title = 'Hajj awareness quiz'
  limit 1;

  if v_competition_id is null then
    return;
  end if;

  if exists (
    select 1 from public.competition_questions
    where competition_id = v_competition_id
  ) then
    return;
  end if;

  insert into public.competition_questions (
    competition_id, sort_order, question_type, prompt, explanation, points
  )
  values (
    v_competition_id,
    0,
    'true_false',
    'Is Ihram required before entering the Miqat boundary?',
    'Ihram is the sacred state pilgrims must enter before crossing the Miqat.',
    10
  )
  returning id into v_question_id;

  insert into public.competition_question_options (question_id, sort_order, label, is_correct)
  values
    (v_question_id, 0, 'true', true),
    (v_question_id, 1, 'false', false);

  insert into public.competition_questions (
    competition_id, sort_order, question_type, prompt, explanation, points
  )
  values (
    v_competition_id,
    1,
    'multiple_choice',
    'Which ritual is performed on the 9th of Dhul Hijjah?',
    'The Day of Arafah is the 9th of Dhul Hijjah and standing at Arafah is a pillar of Hajj.',
    15
  )
  returning id into v_question_id;

  insert into public.competition_question_options (question_id, sort_order, label, is_correct)
  values
    (v_question_id, 0, 'Standing at Arafah', true),
    (v_question_id, 1, 'Tawaf al-Ifadah', false),
    (v_question_id, 2, 'Sa''i between Safa and Marwa', false),
    (v_question_id, 3, 'Stoning Jamarat', false);

  insert into public.competition_questions (
    competition_id, sort_order, question_type, prompt, explanation, points
  )
  values (
    v_competition_id,
    2,
    'ordering',
    'Put the main Hajj days in order (simplified):',
    'After Arafah comes Muzdalifah, then stoning at Mina, then Tawaf al-Ifadah.',
    20
  )
  returning id into v_question_id;

  insert into public.competition_question_options (question_id, sort_order, label, is_correct)
  values
    (v_question_id, 0, 'Standing at Arafah (9th)', false),
    (v_question_id, 1, 'Night in Muzdalifah', false),
    (v_question_id, 2, 'Stoning Jamarat at Mina', false),
    (v_question_id, 3, 'Tawaf al-Ifadah', false);
end $$;
