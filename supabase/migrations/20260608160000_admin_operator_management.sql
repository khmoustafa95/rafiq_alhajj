-- Admin operator management: staff accounts, permissions, active flag.

alter table public.profiles
  add column if not exists email text,
  add column if not exists is_active boolean not null default true,
  add column if not exists operator_permissions jsonb;

comment on column public.profiles.operator_permissions is
  'Operator capability flags managed by admins (JSON object).';

-- Backfill email from auth for existing users (best effort).
update public.profiles p
set email = u.email
from auth.users u
where p.id = u.id and p.email is null;

update public.profiles
set operator_permissions = jsonb_build_object(
  'can_register_pilgrims', true,
  'can_manage_pilgrim_registry', true,
  'can_use_field_tools', true,
  'can_upload_documents', true
)
where role = 'operator' and operator_permissions is null;

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  assigned_role public.user_role;
  perms jsonb;
begin
  assigned_role := coalesce(
    (new.raw_user_meta_data ->> 'role')::public.user_role,
    'pilgrim'::public.user_role
  );

  if assigned_role = 'operator' then
    perms := coalesce(
      new.raw_user_meta_data -> 'operator_permissions',
      jsonb_build_object(
        'can_register_pilgrims', true,
        'can_manage_pilgrim_registry', true,
        'can_use_field_tools', true,
        'can_upload_documents', true
      )
    );
  else
    perms := null;
  end if;

  insert into public.profiles (id, full_name, role, email, operator_permissions)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'full_name', new.email),
    assigned_role,
    new.email,
    perms
  );
  return new;
end;
$$;

drop policy if exists "Admins update operator profiles" on public.profiles;
create policy "Admins update operator profiles"
  on public.profiles
  for update
  to authenticated
  using (public.is_admin() and role = 'operator')
  with check (public.is_admin() and role = 'operator');
