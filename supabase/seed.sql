-- بيانات تجريبية (تُشغَّل بعد supabase db reset).
-- حسابات تجريبية (أنشئها يدويًا بعد التهيئة):
--   supabase auth users create pilgrim@demo.local --password demo123456 --email-confirm
--   supabase auth users create operator@demo.local --password demo123456 --email-confirm --user-metadata "{\"role\":\"operator\",\"full_name\":\"محمد التقني\"}"
--   supabase auth users create admin@demo.local --password demo123456 --email-confirm --user-metadata "{\"role\":\"admin\",\"full_name\":\"خالد المسؤول\"}"

-- ---------------------------------------------------------------------------
-- المكاتب السياحية (المجموعات)
-- ---------------------------------------------------------------------------
insert into public.groups (id, name, code, president_name, president_phone)
values
  ('11111111-1111-1111-1111-111111111101', 'مكتب نور الحرمين', 'NOOR', 'أحمد الشيخ', '+963991000111'),
  ('11111111-1111-1111-1111-111111111102', 'مكتب طريق الإيمان', 'EMAN', 'سمير العلي', '+963991000222'),
  ('11111111-1111-1111-1111-111111111103', 'مكتب رحلة العمر', 'OMR', 'وليد الحمصي', '+963991000333')
on conflict (code) do nothing;

-- ---------------------------------------------------------------------------
-- الرحلات (حج نشطة + عمرة قيد التخطيط)
-- ---------------------------------------------------------------------------
insert into public.trips (id, type, season_year, name, status, start_date, end_date)
values
  ('22222222-2222-2222-2222-222222222201', 'hajj', 1447, 'رحلة الحج 1447هـ', 'active', '2026-05-20', '2026-06-25'),
  ('22222222-2222-2222-2222-222222222202', 'umrah', 1447, 'عمرة رمضان 1447هـ', 'planning', '2026-03-01', '2026-03-20')
on conflict (id) do nothing;

-- مشاركة المكاتب في الرحلات
insert into public.trip_groups (trip_id, group_id, status)
values
  ('22222222-2222-2222-2222-222222222201', '11111111-1111-1111-1111-111111111101', 'active'),
  ('22222222-2222-2222-2222-222222222201', '11111111-1111-1111-1111-111111111102', 'active'),
  ('22222222-2222-2222-2222-222222222201', '11111111-1111-1111-1111-111111111103', 'withdrawn'),
  ('22222222-2222-2222-2222-222222222202', '11111111-1111-1111-1111-111111111101', 'active')
on conflict (trip_id, group_id) do nothing;

-- ---------------------------------------------------------------------------
-- الحجاج (هويات الأشخاص) + تسجيلاتهم في رحلة الحج
-- ---------------------------------------------------------------------------
do $$
declare
  v_hajj uuid := '22222222-2222-2222-2222-222222222201';
  v_umrah uuid := '22222222-2222-2222-2222-222222222202';
  v_noor uuid := '11111111-1111-1111-1111-111111111101';
  v_eman uuid := '11111111-1111-1111-1111-111111111102';
  rec record;
  v_pid uuid;
begin
  for rec in
    select * from (values
      ('أحمد محمد العمر',     'ذكر',  'P9001001', v_noor, 'pending',      'فندق دار الإيمان',  '0561234501'),
      ('فاطمة علي الحسن',     'أنثى', 'P9001002', v_noor, 'medical_done', 'فندق صفوة مكة',     '0561234502'),
      ('خالد سمير الديب',     'ذكر',  'P9001003', v_noor, 'arrived_hotel','برج الساعة',        '0561234503'),
      ('نور الهدى يوسف',      'أنثى', 'P9001004', v_eman, 'in_transit',   'فندق هيلتون مكة',   '0561234504'),
      ('محمود عبد الله خير',  'ذكر',  'P9001005', v_eman, 'completed',    'فندق المروة ريحان', '0561234505'),
      ('رنا طارق الأحمد',     'أنثى', 'P9001006', v_eman, 'pending',      'فندق دار التوحيد',  '0561234506'),
      ('عمر فادي السيد',      'ذكر',  'P9001007', v_noor, 'medical_done', 'فندق الكوثر',       '0561234507'),
      ('ليلى وليد المصري',    'أنثى', 'P9001008', v_noor, 'arrived_hotel','فندق أنجم مكة',     '0561234508')
    ) as t(full_name, gender, passport, group_id, field_status, hotel, phone)
  loop
    insert into public.pilgrims (full_name_ar, gender, passport_number, phone_number)
    values (rec.full_name, rec.gender, rec.passport, rec.phone)
    returning id into v_pid;

    insert into public.trip_enrollments (
      pilgrim_id, trip_id, group_id, field_status, hotel_name, travel_date, sticker_number
    )
    values (
      v_pid, v_hajj, rec.group_id::uuid, rec.field_status, rec.hotel,
      '2026-05-22', 'STK-' || rec.passport
    );

    -- أول حاجَّين مسجَّلان أيضًا في رحلة العمرة (الحاج قد يذهب أكثر من رحلة)
    if rec.passport in ('P9001001', 'P9001002') then
      insert into public.trip_enrollments (pilgrim_id, trip_id, group_id, field_status)
      values (v_pid, v_umrah, v_noor, 'pending');
    end if;
  end loop;
end $$;

-- ---------------------------------------------------------------------------
-- المحتوى التعريفي
-- ---------------------------------------------------------------------------
insert into public.content_library (title, description, media_url, type, visibility)
values
  (
    'مقدمة في مناسك الحج',
    'نظرة موجزة على الخطوات الأساسية التي ينبغي لكل حاج معرفتها قبل السفر.',
    'https://www.youtube.com/watch?v=example-hajj-intro',
    'news',
    'public'
  ),
  (
    'نصائح صحية قبل المغادرة',
    'إرشادات حول التطعيمات والترطيب والفحوصات الطبية للحجاج.',
    'https://www.youtube.com/watch?v=example-health-tips',
    'news',
    'public'
  ),
  (
    'التكتل يرحب بحجاج هذا الموسم',
    'مراكزنا جاهزة لدعم المجموعات في التسجيل والتنسيق الميداني.',
    null,
    'news',
    'public'
  ),
  (
    'سلسلة فيديوهات توعوية جديدة متاحة',
    'تصفّح المكتبة العامة للمحتوى التعليمي — دون الحاجة إلى حساب.',
    null,
    'announcement',
    'public'
  ),
  (
    'حصري: جدول التوجيه الخاص بمجموعتك',
    'متاح بعد تسجيل دخول الحاج فقط.',
    null,
    'news',
    'pilgrim_only'
  );

-- ---------------------------------------------------------------------------
-- المسابقات
-- ---------------------------------------------------------------------------
insert into public.competitions (title, description, starts_at, ends_at, is_active)
values
  (
    'مسابقة الوعي بالحج',
    'أجب عن الأسئلة التوعوية اليومية وتصدّر لوحة المتصدرين.',
    now() - interval '1 day',
    now() + interval '90 days',
    true
  ),
  (
    'تحدي تقدّم المناسك',
    'سجّل تقدمك في قائمة المناسك — أفضل الحجاج ينالون التكريم.',
    now() - interval '1 day',
    now() + interval '60 days',
    true
  );

do $$
declare
  v_competition_id uuid;
  v_question_id uuid;
begin
  select id into v_competition_id
  from public.competitions
  where title = 'مسابقة الوعي بالحج'
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
    'هل الإحرام مطلوب قبل تجاوز حدود الميقات؟',
    'الإحرام هو الحالة التي يجب أن يدخل فيها الحاج قبل تجاوز الميقات.',
    10
  )
  returning id into v_question_id;

  insert into public.competition_question_options (question_id, sort_order, label, is_correct)
  values
    (v_question_id, 0, 'صحيح', true),
    (v_question_id, 1, 'خطأ', false);

  insert into public.competition_questions (
    competition_id, sort_order, question_type, prompt, explanation, points
  )
  values (
    v_competition_id,
    1,
    'multiple_choice',
    'أي منسك يُؤدّى في اليوم التاسع من ذي الحجة؟',
    'يوم عرفة هو التاسع من ذي الحجة، والوقوف بعرفة ركن من أركان الحج.',
    15
  )
  returning id into v_question_id;

  insert into public.competition_question_options (question_id, sort_order, label, is_correct)
  values
    (v_question_id, 0, 'الوقوف بعرفة', true),
    (v_question_id, 1, 'طواف الإفاضة', false),
    (v_question_id, 2, 'السعي بين الصفا والمروة', false),
    (v_question_id, 3, 'رمي الجمرات', false);

  insert into public.competition_questions (
    competition_id, sort_order, question_type, prompt, explanation, points
  )
  values (
    v_competition_id,
    2,
    'ordering',
    'رتّب أيام الحج الرئيسية (مبسّطة):',
    'بعد عرفة تأتي مزدلفة، ثم رمي الجمرات بمنى، ثم طواف الإفاضة.',
    20
  )
  returning id into v_question_id;

  insert into public.competition_question_options (question_id, sort_order, label, is_correct)
  values
    (v_question_id, 0, 'الوقوف بعرفة (التاسع)', false),
    (v_question_id, 1, 'المبيت بمزدلفة', false),
    (v_question_id, 2, 'رمي الجمرات بمنى', false),
    (v_question_id, 3, 'طواف الإفاضة', false);
end $$;
