-- In-app notification inbox (per-user rows)

create type public.notification_type as enum (
  'announcement',
  'content_published',
  'competition',
  'ritual_update',
  'system'
);

create table public.notifications (
  id uuid primary key default gen_random_uuid(),
  recipient_id uuid not null references public.profiles (id) on delete cascade,
  sender_id uuid references public.profiles (id) on delete set null,
  type public.notification_type not null default 'system',
  title_ar text not null,
  title_en text not null,
  body_ar text,
  body_en text,
  payload jsonb not null default '{}'::jsonb,
  read_at timestamptz,
  created_at timestamptz not null default now()
);

create index notifications_recipient_created_idx
  on public.notifications (recipient_id, created_at desc);

create index notifications_recipient_unread_idx
  on public.notifications (recipient_id)
  where read_at is null;

alter table public.notifications enable row level security;

create policy "Recipients read own notifications"
  on public.notifications
  for select
  to authenticated
  using (recipient_id = auth.uid());

create policy "Recipients update own notifications"
  on public.notifications
  for update
  to authenticated
  using (recipient_id = auth.uid())
  with check (recipient_id = auth.uid());

create policy "Admins insert notifications"
  on public.notifications
  for insert
  to authenticated
  with check (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'admin'
    )
  );

-- Realtime for unread badge refresh
alter publication supabase_realtime add table public.notifications;

-- Demo inbox rows for pilgrim profiles (after seed users exist)
insert into public.notifications (
  recipient_id,
  type,
  title_ar,
  title_en,
  body_ar,
  body_en,
  payload
)
select
  p.id,
  'announcement'::public.notification_type,
  'مرحباً بك في رفيق الحج',
  'Welcome to Rafiq Al-Hajj',
  'تفقّد المحتوى التعليمي ولوحة الحاج لمتابعة مناسكك.',
  'Browse educational content and your pilgrim dashboard for ritual progress.',
  '{"route":"home"}'::jsonb
from public.profiles p
where p.role = 'pilgrim'
  and not exists (
    select 1 from public.notifications n
    where n.recipient_id = p.id
      and n.type = 'announcement'
      and n.title_en = 'Welcome to Rafiq Al-Hajj'
  );
