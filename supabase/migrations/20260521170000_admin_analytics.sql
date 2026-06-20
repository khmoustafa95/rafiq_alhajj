-- US-07: Admin analytics — admin read policies across the domain.
-- (groups + pilgrim/enrollment/ritual read policies live in the pilgrim domain migration.)

create policy "Admins read groups"
  on public.groups
  for select
  to authenticated
  using (public.is_admin());

create policy "Admins read all profiles"
  on public.profiles
  for select
  to authenticated
  using (public.is_admin());
