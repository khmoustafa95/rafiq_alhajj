-- Admin promotion controls: only bootstrap / super admins may grant the admin role.

alter table public.profiles
  add column if not exists can_manage_admins boolean not null default false;

comment on column public.profiles.can_manage_admins is
  'When true, this admin may promote staff to admin. Bootstrap admins only; promoted admins get false.';

-- Existing admin rows (dev/staging) become super admins.
update public.profiles
set can_manage_admins = true
where role = 'admin';

create or replace function public.can_manage_admins()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.profiles
    where id = auth.uid()
      and role = 'admin'
      and can_manage_admins = true
  );
$$;

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  assigned_role public.user_role;
  perms jsonb;
  manage_admins boolean;
begin
  assigned_role := coalesce(
    (new.raw_user_meta_data ->> 'role')::public.user_role,
    'pilgrim'::public.user_role
  );

  manage_admins := coalesce(
    (new.raw_user_meta_data ->> 'can_manage_admins')::boolean,
    false
  );

  if assigned_role <> 'admin' then
    manage_admins := false;
  end if;

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

  insert into public.profiles (
    id,
    full_name,
    role,
    email,
    operator_permissions,
    can_manage_admins
  )
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'full_name', new.email),
    assigned_role,
    new.email,
    perms,
    manage_admins
  );
  return new;
end;
$$;
