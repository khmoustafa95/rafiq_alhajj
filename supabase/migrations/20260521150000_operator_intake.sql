-- US-05: Operator pilgrim intake — documents + storage

insert into storage.buckets (id, name, public)
values ('pilgrim-documents', 'pilgrim-documents', false)
on conflict (id) do nothing;

create table public.pilgrim_documents (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  file_name text not null,
  storage_path text not null,
  document_type text,
  uploaded_by uuid references public.profiles (id),
  uploaded_at timestamptz not null default now()
);

create index pilgrim_documents_profile_idx on public.pilgrim_documents (profile_id);

alter table public.pilgrim_documents enable row level security;

create policy "Operators insert pilgrim documents metadata"
  on public.pilgrim_documents
  for insert
  to authenticated
  with check (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role in ('operator', 'admin')
    )
  );

create policy "Operators read pilgrim documents metadata"
  on public.pilgrim_documents
  for select
  to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role in ('operator', 'admin')
    )
    or profile_id = auth.uid()
  );

create policy "Operators update pilgrim details"
  on public.pilgrim_details
  for update
  to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role in ('operator', 'admin')
    )
  )
  with check (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role in ('operator', 'admin')
    )
  );

create policy "Operators read all pilgrim details"
  on public.pilgrim_details
  for select
  to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role in ('operator', 'admin')
    )
    or profile_id = auth.uid()
  );

-- Storage objects policies
create policy "Operators upload pilgrim files"
  on storage.objects
  for insert
  to authenticated
  with check (
    bucket_id = 'pilgrim-documents'
    and exists (
      select 1 from public.profiles
      where id = auth.uid() and role in ('operator', 'admin')
    )
  );

create policy "Operators and pilgrims read pilgrim files"
  on storage.objects
  for select
  to authenticated
  using (
    bucket_id = 'pilgrim-documents'
    and (
      exists (
        select 1 from public.profiles
        where id = auth.uid() and role in ('operator', 'admin')
      )
      or (storage.foldername(name))[1] = auth.uid()::text
    )
  );
