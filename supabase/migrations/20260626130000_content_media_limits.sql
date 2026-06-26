-- Harden the public `content-media` bucket: cap object size and restrict the
-- accepted MIME types to images / audio / short video.
--
-- WHY:
--  * file_size_limit mirrors the global storage cap (50 MiB) so oversized
--    uploads are rejected predictably. The Flutter client (UploadConstraints)
--    enforces tighter per-type caps and rejects before any bytes are sent.
--  * allowed_mime_types blocks executable/markup types (e.g. text/html,
--    image/svg+xml) that could be abused for stored-XSS via this public bucket.
--
-- SECURITY NOTE (public read — accepted, documented):
--  This bucket is PUBLIC (anon read on every object). Educational content is
--  meant to be public, so this is acceptable. However, media attached to a
--  `pilgrim_only` topic is therefore ALSO world-readable by direct URL even
--  though its DB row is RLS-gated. If truly private content media is needed
--  later, move it to a private bucket and serve via signed URLs
--  (storage.createSignedUrl) instead of getPublicUrl.

update storage.buckets
set
  file_size_limit = 52428800, -- 50 MiB in bytes
  allowed_mime_types = array[
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
where id = 'content-media';
