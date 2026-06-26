-- Private bucket for `pilgrim_only` educational media.
--
-- WHY:
--  The existing `content-media` bucket is PUBLIC (anon read), so media attached
--  to a `pilgrim_only` topic was world-readable by direct URL even though its DB
--  row is RLS-gated. Pilgrim-only media now lives here instead and is served via
--  short-lived signed URLs (storage.createSignedUrl). The Flutter client stores a
--  `private://<path>` sentinel in `content_topic_media.url` for objects in this
--  bucket and resolves a signed URL on demand (online) or an encrypted local copy
--  (offline).
--
-- ACCESS MODEL (mirrors public.content_topics pilgrim policy):
--  * SELECT: admins, or authenticated pilgrims (profiles.role = 'pilgrim').
--    createSignedUrl requires this SELECT permission for the caller.
--  * INSERT/UPDATE/DELETE: admins only.

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'content-media-private',
  'content-media-private',
  false,
  52428800, -- 50 MiB
  array[
    'image/jpeg',
    'image/png',
    'image/webp',
    'image/gif',
    'audio/mpeg',
    'audio/mp4',
    'audio/aac',
    'audio/wav',
    'audio/ogg',
    'video/mp4',
    'video/webm',
    'video/quicktime'
  ]
)
on conflict (id) do update
set
  public = excluded.public,
  file_size_limit = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "Pilgrims read private content media" on storage.objects;
create policy "Pilgrims read private content media"
  on storage.objects
  for select
  to authenticated
  using (
    bucket_id = 'content-media-private'
    and (
      public.is_admin()
      or exists (
        select 1
        from public.profiles p
        where p.id = auth.uid() and p.role = 'pilgrim'
      )
    )
  );

drop policy if exists "Admins upload private content media" on storage.objects;
create policy "Admins upload private content media"
  on storage.objects
  for insert
  to authenticated
  with check (bucket_id = 'content-media-private' and public.is_admin());

drop policy if exists "Admins update private content media" on storage.objects;
create policy "Admins update private content media"
  on storage.objects
  for update
  to authenticated
  using (bucket_id = 'content-media-private' and public.is_admin())
  with check (bucket_id = 'content-media-private' and public.is_admin());

drop policy if exists "Admins delete private content media" on storage.objects;
create policy "Admins delete private content media"
  on storage.objects
  for delete
  to authenticated
  using (bucket_id = 'content-media-private' and public.is_admin());
