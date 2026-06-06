-- Fix infinite recursion when policies on `profiles` query `profiles` under RLS.
-- Use SECURITY DEFINER helpers so role checks bypass RLS on the lookup row.

create or replace function public.is_admin()
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select exists (
    select 1
    from public.profiles
    where id = auth.uid() and role = 'admin'
  );
$$;

create or replace function public.is_operator_or_admin()
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select exists (
    select 1
    from public.profiles
    where id = auth.uid() and role in ('operator', 'admin')
  );
$$;

drop policy if exists "Operators read pilgrim profiles" on public.profiles;
create policy "Operators read pilgrim profiles"
  on public.profiles
  for select
  to authenticated
  using (
    role = 'pilgrim'
    and public.is_operator_or_admin()
  );

drop policy if exists "Admins read all profiles" on public.profiles;
create policy "Admins read all profiles"
  on public.profiles
  for select
  to authenticated
  using (public.is_admin());
