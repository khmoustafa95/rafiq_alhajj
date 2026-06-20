-- US-06: Field operator mobile — operators read pilgrim profiles to search.
-- (Field status now lives on trip_enrollments; see the pilgrim domain migration.)

create policy "Operators read pilgrim profiles"
  on public.profiles
  for select
  to authenticated
  using (role = 'pilgrim' and public.is_operator_or_admin());
