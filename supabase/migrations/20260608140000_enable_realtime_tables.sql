-- Enable Supabase Realtime for live UI refresh across the app.

alter publication supabase_realtime add table public.profiles;
alter publication supabase_realtime add table public.pilgrim_details;
alter publication supabase_realtime add table public.ritual_logs;
alter publication supabase_realtime add table public.content_library;
alter publication supabase_realtime add table public.competitions;
alter publication supabase_realtime add table public.competition_entries;
alter publication supabase_realtime add table public.groups;
alter publication supabase_realtime add table public.pilgrim_documents;
