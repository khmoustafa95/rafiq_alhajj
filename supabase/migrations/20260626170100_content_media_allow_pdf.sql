-- Allow PDF documents in both content media buckets.
--
-- WHY: Library topics can now attach PDFs. Mirror the existing MIME allow-lists
-- (20260626130000_content_media_limits.sql + 20260626160000_content_media_private_bucket.sql)
-- and append `application/pdf`. The Flutter client (UploadConstraints.pdf)
-- enforces a tighter per-type cap and rejects before any bytes are sent.

update storage.buckets
set allowed_mime_types = array[
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
    'video/quicktime',
    'application/pdf'
  ]
where id in ('content-media', 'content-media-private');
