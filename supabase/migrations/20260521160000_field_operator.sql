-- US-06: Field operator mobile — search pilgrims + update field status

alter table public.pilgrim_details
  add column if not exists field_status text;

comment on column public.pilgrim_details.field_status is
  'Field logistics status updated by mobile operator (pending, medical_done, arrived_hotel, etc.)';

create policy "Operators read pilgrim profiles"
  on public.profiles
  for select
  to authenticated
  using (
    role = 'pilgrim'
    and exists (
      select 1 from public.profiles op
      where op.id = auth.uid() and op.role in ('operator', 'admin')
    )
  );
