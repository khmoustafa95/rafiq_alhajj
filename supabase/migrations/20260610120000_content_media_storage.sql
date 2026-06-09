-- Public bucket for educational topic media (audio, images, hosted videos).

insert into storage.buckets (id, name, public)
values ('content-media', 'content-media', true)
on conflict (id) do nothing;

drop policy if exists "Public read content media" on storage.objects;
create policy "Public read content media"
  on storage.objects
  for select
  to anon, authenticated
  using (bucket_id = 'content-media');

drop policy if exists "Admins upload content media" on storage.objects;
create policy "Admins upload content media"
  on storage.objects
  for insert
  to authenticated
  with check (bucket_id = 'content-media' and public.is_admin());

drop policy if exists "Admins update content media" on storage.objects;
create policy "Admins update content media"
  on storage.objects
  for update
  to authenticated
  using (bucket_id = 'content-media' and public.is_admin())
  with check (bucket_id = 'content-media' and public.is_admin());

drop policy if exists "Admins delete content media" on storage.objects;
create policy "Admins delete content media"
  on storage.objects
  for delete
  to authenticated
  using (bucket_id = 'content-media' and public.is_admin());
