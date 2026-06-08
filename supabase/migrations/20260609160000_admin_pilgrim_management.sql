-- Admin pilgrim profile updates + staff group lookup for filters.

create policy "Operators read groups"
  on public.groups
  for select
  to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'operator'
    )
  );

create policy "Admins update pilgrim profiles"
  on public.profiles
  for update
  to authenticated
  using (public.is_admin() and role = 'pilgrim')
  with check (public.is_admin() and role = 'pilgrim');

create index if not exists profiles_group_id_idx on public.profiles (group_id);

create index if not exists pilgrim_details_gender_idx on public.pilgrim_details (gender);
