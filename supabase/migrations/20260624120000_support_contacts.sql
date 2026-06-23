-- Support / emergency contacts shown to pilgrims (call + WhatsApp).
-- Admin-managed; each contact is either global (everyone) or scoped to a group.

create table public.support_contacts (
  id uuid primary key default gen_random_uuid(),
  label_ar text not null,
  label_en text not null,
  description_ar text,
  description_en text,
  phone_number text,
  whatsapp_number text,
  scope text not null default 'global' check (scope in ('global', 'group')),
  group_id uuid references public.groups (id) on delete cascade,
  is_active boolean not null default true,
  sort_order int not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid references public.profiles (id) on delete set null,
  constraint support_contacts_group_required
    check (scope <> 'group' or group_id is not null),
  constraint support_contacts_has_channel
    check (
      coalesce(nullif(trim(phone_number), ''), nullif(trim(whatsapp_number), '')) is not null
    )
);

create index support_contacts_active_idx
  on public.support_contacts (is_active, scope, sort_order);

create index support_contacts_group_idx
  on public.support_contacts (group_id);

alter table public.support_contacts enable row level security;

-- Admins manage every contact.
create policy "Admins manage support contacts"
  on public.support_contacts
  for all
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

-- Authenticated users read active contacts that apply to them: global ones, or
-- group ones for a group they belong to (pilgrim via enrollment/profile) or can
-- read (operators + admins via operator_can_read_group).
create policy "Read applicable support contacts"
  on public.support_contacts
  for select
  to authenticated
  using (
    is_active
    and (
      scope = 'global'
      or (
        scope = 'group'
        and group_id is not null
        and (
          public.operator_can_read_group(group_id)
          or group_id = (select p.group_id from public.profiles p where p.id = auth.uid())
          or exists (
            select 1
            from public.trip_enrollments te
            join public.pilgrims pg on pg.id = te.pilgrim_id
            where pg.profile_id = auth.uid()
              and te.group_id = support_contacts.group_id
          )
        )
      )
    )
  );

-- Guests (unauthenticated) see active global contacts only.
create policy "Guests read global support contacts"
  on public.support_contacts
  for select
  to anon
  using (is_active and scope = 'global');

alter publication supabase_realtime add table public.support_contacts;

-- Demo / starter contacts (global).
insert into public.support_contacts (
  label_ar, label_en, description_ar, description_en,
  phone_number, whatsapp_number, scope, sort_order
)
values
  (
    'خدمات الطوارئ', 'Emergency services',
    'للحالات الطارئة والإسعاف على مدار الساعة.',
    'Round-the-clock emergencies and ambulance.',
    '911', null, 'global', 0
  ),
  (
    'الخدمات الفندقية', 'Hotel services',
    'استفسارات السكن والإقامة في مكة والمدينة.',
    'Accommodation enquiries in Makkah and Madinah.',
    '+966500000001', '+966500000001', 'global', 1
  ),
  (
    'طلب فتوى', 'Request a fatwa',
    'تواصل مع المرشد الديني للأسئلة الشرعية.',
    'Reach the religious guide for Sharia questions.',
    null, '+966500000002', 'global', 2
  );
