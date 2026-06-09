-- Hajj journey CMS: ritual steps with educational media (admin-managed).

create type public.hajj_media_type as enum ('video', 'audio', 'image');

create table public.hajj_journey_steps (
  id uuid primary key default gen_random_uuid(),
  ritual_key text not null unique,
  sort_order integer not null default 0,
  title_ar text not null,
  title_en text not null,
  description_ar text not null,
  description_en text not null,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index hajj_journey_steps_sort_idx on public.hajj_journey_steps (sort_order);

create table public.hajj_journey_media (
  id uuid primary key default gen_random_uuid(),
  step_id uuid not null references public.hajj_journey_steps (id) on delete cascade,
  media_type public.hajj_media_type not null,
  title text,
  url text not null,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create index hajj_journey_media_step_idx
  on public.hajj_journey_media (step_id, sort_order);

alter table public.hajj_journey_steps enable row level security;
alter table public.hajj_journey_media enable row level security;

create policy "Anyone reads active hajj journey steps"
  on public.hajj_journey_steps
  for select
  to anon, authenticated
  using (is_active);

create policy "Admins manage hajj journey steps"
  on public.hajj_journey_steps
  for all
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

create policy "Anyone reads hajj journey media for active steps"
  on public.hajj_journey_media
  for select
  to anon, authenticated
  using (
    exists (
      select 1
      from public.hajj_journey_steps s
      where s.id = step_id and s.is_active
    )
  );

create policy "Admins manage hajj journey media"
  on public.hajj_journey_media
  for all
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

-- Demo seed: Hajj manasik with educational content (Islamic sources).
insert into public.hajj_journey_steps
  (ritual_key, sort_order, title_ar, title_en, description_ar, description_en)
values
  (
    'ihram',
    1,
    'الإحرام',
    'Ihram',
    'الإحرام هو نية الدخول في النسك وتجسيدها بلباس مخصص للرجال واجتناب محظورات الإحرام. يبدأ الإحرام من الميقات أو قبله، ويستحب التلبية: لبيك اللهم لبيك. من محظورات الإحرام: لبس المخيط للرجال، تغطية الرأس للرجال، استعمال الطيب، إزالة الشعر، والجماع.',
    'Ihram is the intention to enter the rites of Hajj or Umrah, marked by special dress for men and avoiding the prohibitions of ihram. It begins at the miqat (or before it). Men wear two unstitched white garments. Prohibitions include stitched clothing for men, covering the head for men, perfume, cutting hair, and marital relations.'
  ),
  (
    'tawaf',
    2,
    'الطواف',
    'Tawaf',
    'الطواف هو الدوران حول الكعبة المشرفة سبعة أشواط، يبدأ من الحجر الأسود وينتهي عنده. يستحب استلام الحجر أو الإشارة إليه في كل شوط إن أمكن. بعد الطواف يصلي ركعتين خلف مقام إبراهيم إن تيسر، ويشرب من ماء زمزم.',
    'Tawaf is circling the Kaaba seven times, beginning and ending at the Black Stone. Touching or pointing to the Black Stone each round is recommended when possible. After tawaf, two rakahs are prayed behind Maqam Ibrahim when feasible, and Zamzam water is drunk.'
  ),
  (
    'sai',
    3,
    'السعي',
    'Sa''i',
    'السعي بين الصفا والمروة سبعة أشواط، يبدأ من الصفا وينتهي عند المروة. يستحب الركض بين العلمين الأخضرين للرجال. السعي سنة مؤكدة بعد طواف العمرة وطواف الحج إذا كان معتمراً.',
    'Sa''i is walking between Safa and Marwa seven times, starting at Safa and ending at Marwa. Men jog between the green markers. It is a strongly recommended act after tawaf of Umrah and after Hajj tawaf when combined with Umrah.'
  ),
  (
    'mina',
    4,
    'اليوم في منى',
    'Day at Mina',
    'يوم التروية هو اليوم الثامن من ذي الحجة، يقضيه الحاج في منى ويصلي الظهر والعصر والمغرب والعشاء والفجر قصراً دون جمع. يستعد فيه الحاج للوقوف بعرفة في اليوم التاسع.',
    'Yawm al-Tarwiyah is the 8th of Dhul Hijjah. Pilgrims stay in Mina and pray Dhuhr, Asr, Maghrib, Isha, and Fajr shortened without combining, preparing for standing at Arafat on the 9th.'
  ),
  (
    'arafat',
    5,
    'الوقوف بعرفة',
    'Standing at Arafat',
    'الوقوف بعرفة ركن الحج الأعظم، وهو اليوم التاسع من ذي الحجة من زوال الشمس إلى غروبها. يشتغل الحاج بالدعاء والتوبة والذكر. قال النبي ﷺ: «الحج عرفة». من فاته الوقوف فاته الحج.',
    'Standing at Arafat is the greatest pillar of Hajj, on the 9th of Dhul Hijjah from noon until sunset. Pilgrims devote themselves to supplication, repentance, and remembrance. The Prophet ﷺ said: "Hajj is Arafat." Whoever misses Arafat has missed Hajj.'
  ),
  (
    'muzdalifah',
    6,
    'المبيت بمزدلفة',
    'Muzdalifah',
    'بعد غروب شمس يوم عرفة ينفر الحاج إلى مزدلفة ويصلي المغرب والعشاء جمعاً وقصراً، ويبيت بها حتى الفجر. يجمع فيها الحصى لرمي الجمرات. يجوز للضعفة المغادرة بعد نصف الليل.',
    'After sunset on the day of Arafat, pilgrims proceed to Muzdalifah, pray Maghrib and Isha combined and shortened, and stay until Fajr. Pebbles for stoning are collected here. The elderly and weak may leave after midnight.'
  ),
  (
    'ramy',
    7,
    'رمي الجمرات',
    'Stoning the Jamarat',
    'رمي الجمرات بسبع حصيات لكل جمرة في أيام التشريق، يبدأ بالجمرة الصغرى ثم الوسطى ثم الكبرى. يقول عند كل حصاة: الله أكبر. يجوز الرمي من بعد زوال الشمس إلى نصف الليل.',
    'Stoning the Jamarat is done with seven pebbles per pillar during the days of Tashriq, starting with the small, then middle, then large pillar. "Allahu Akbar" is said with each throw. Stoning is permitted from after noon until midnight.'
  ),
  (
    'hady',
    8,
    'الهدي',
    'Sacrifice (Hady)',
    'الهدي هو ذبح البدنة أو البقرة أو الشاة في يوم العيد وأيام التشريق، وهو واجب على القارن والمفرد. يأكل منه الحاج ويهدي ويتصدق. من لم يجد هدياً يصوم عشرة أيام: ثلاثة في الحج وسبعة إذا رجع.',
    'Hady is sacrificing a camel, cow, or sheep on Eid and the days of Tashriq. It is obligatory for those performing Hajj Qiran or Ifrad. The pilgrim eats, gifts, and gives charity from it. Whoever cannot afford it fasts ten days: three during Hajj and seven after returning.'
  ),
  (
    'halq',
    9,
    'الحلق أو التقصير',
    'Halq or Taqsir',
    'الحلق أو التقصير يحرر الحاج من محظورات الإحرام بعد رمي جمرة العقبة يوم العيد. الحلق أفضل للرجال، والتقصير يكفي بقص قدر أنملة من كل جانب. للنساء التقصير من أطراف الشعر.',
    'Halq (shaving) or taqsir (trimming) releases the pilgrim from ihram restrictions after stoning Jamrat al-Aqaba on Eid. Shaving is best for men; trimming the length of a fingertip from all sides suffices. Women trim the ends of their hair.'
  ),
  (
    'farewell_tawaf',
    10,
    'طواف الوداع',
    'Farewell Tawaf',
    'طواف الوداع آخر ما يفعله الحاج قبل مغادرة مكة، وهو واجب على من أراد الخروج من مكة بعد إتمام المناسك. من تركه فعليه دم (ذبح شاة). يطوف سبعة أشواط كطواف الإحرام دون ركعتي الطواف بعده.',
    'The farewell tawaf is the last act before leaving Makkah. It is obligatory for those departing after completing the rites. Whoever omits it must offer a sacrifice. Seven circuits are performed like the arrival tawaf, without the two rakahs afterward.'
  );

-- Media per step (images, sample video embed, sample audio).
insert into public.hajj_journey_media (step_id, media_type, title, url, sort_order)
select s.id, 'image', 'الكعبة المشرفة',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Masjid_al-Haram_and_the_center_of_Mecca.jpg/800px-Masjid_al-Haram_and_the_center_of_Mecca.jpg',
  1
from public.hajj_journey_steps s where s.ritual_key = 'ihram';

insert into public.hajj_journey_media (step_id, media_type, title, url, sort_order)
select s.id, 'image', 'ملابس الإحرام',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Ihram.jpg/640px-Ihram.jpg',
  2
from public.hajj_journey_steps s where s.ritual_key = 'ihram';

insert into public.hajj_journey_media (step_id, media_type, title, url, sort_order)
select s.id, 'image', 'الطواف حول الكعبة',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Kaaba_mirror_edit00.jpg/640px-Kaaba_mirror_edit00.jpg',
  1
from public.hajj_journey_steps s where s.ritual_key = 'tawaf';

insert into public.hajj_journey_media (step_id, media_type, title, url, sort_order)
select s.id, 'image', 'الصفا والمروة',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Safa_and_Marwa.jpg/640px-Safa_and_Marwa.jpg',
  1
from public.hajj_journey_steps s where s.ritual_key = 'sai';

insert into public.hajj_journey_media (step_id, media_type, title, url, sort_order)
select s.id, 'image', 'خيام منى',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Mina%2C_Saudi_Arabia.jpg/640px-Mina%2C_Saudi_Arabia.jpg',
  1
from public.hajj_journey_steps s where s.ritual_key = 'mina';

insert into public.hajj_journey_media (step_id, media_type, title, url, sort_order)
select s.id, 'image', 'جبل عرفة',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Mount_Arafat.jpg/640px-Mount_Arafat.jpg',
  1
from public.hajj_journey_steps s where s.ritual_key = 'arafat';

insert into public.hajj_journey_media (step_id, media_type, title, url, sort_order)
select s.id, 'video', 'الوقوف بعرفة',
  'https://www.youtube.com/embed/0J7V4JDc8gY',
  2
from public.hajj_journey_steps s where s.ritual_key = 'arafat';

insert into public.hajj_journey_media (step_id, media_type, title, url, sort_order)
select s.id, 'image', 'مزدلفة',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Muzdalifah.jpg/640px-Muzdalifah.jpg',
  1
from public.hajj_journey_steps s where s.ritual_key = 'muzdalifah';

insert into public.hajj_journey_media (step_id, media_type, title, url, sort_order)
select s.id, 'image', 'الجمرات',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Jamarat_Bridge.jpg/640px-Jamarat_Bridge.jpg',
  1
from public.hajj_journey_steps s where s.ritual_key = 'ramy';

insert into public.hajj_journey_media (step_id, media_type, title, url, sort_order)
select s.id, 'image', 'الهدي',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/Sheep_in_Saudi_Arabia.jpg/640px-Sheep_in_Saudi_Arabia.jpg',
  1
from public.hajj_journey_steps s where s.ritual_key = 'hady';

insert into public.hajj_journey_media (step_id, media_type, title, url, sort_order)
select s.id, 'audio', 'تلبية الحج',
  'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
  2
from public.hajj_journey_steps s where s.ritual_key = 'hady';

insert into public.hajj_journey_media (step_id, media_type, title, url, sort_order)
select s.id, 'image', 'الحلق',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Ihram.jpg/640px-Ihram.jpg',
  1
from public.hajj_journey_steps s where s.ritual_key = 'halq';

insert into public.hajj_journey_media (step_id, media_type, title, url, sort_order)
select s.id, 'image', 'طواف الوداع',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Kaaba_mirror_edit00.jpg/640px-Kaaba_mirror_edit00.jpg',
  1
from public.hajj_journey_steps s where s.ritual_key = 'farewell_tawaf';
