-- Add `pdf` to the educational media enum.
--
-- WHY: Library topics now support PDF documents as a media item alongside
-- video / audio / image. This MUST be its own migration (transaction): Postgres
-- forbids using a newly added enum value in the same transaction that adds it,
-- so later migrations / seed inserts that reference 'pdf' run in separate txns.

alter type public.content_media_type add value if not exists 'pdf';
