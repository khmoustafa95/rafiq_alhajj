# Active Context

> **Read this file at the start of every session.**

## Current focus
**Content topics — media storage, offline, native audio** — رفع وسائط إلى Supabase Storage، تحميل اختياري للحاج، مشغّل صوت native، معاينة مسؤول، skeleton في الرئيسية.

## Recent changes (2026-06-09)
- **Storage:** migration `20260610120000_content_media_storage.sql` — bucket `content-media` + RLS; `ContentMediaStorageService` + FilePicker upload in admin topic edit.
- **Offline:** `ContentMediaCacheService` (Dio background downloads, manifest in app docs); profile card + per-topic download actions; YouTube excluded from cache.
- **Playback:** `resolvedMediaPlaybackUrlProvider`; `NativeAudioPlayer` (audioplayers on Android/iOS, WebView fallback on web); cache-aware `EducationalMediaViewer` + `ResolvedTopicImage`.
- **Network:** removed `videos` from `PublicContentFeed`; `content_library` fetch limited to `news`/`announcement`.
- **UX:** `ContentTopicsSectionSkeleton` on home loading; `AdminContentMediaPreview` in edit screen.
- **Packages:** `path_provider`, `dio`, `audioplayers`, `shimmer`.

## Next steps
1. Apply migration locally: `supabase db reset` or `supabase migration up`.
2. Manual test: admin upload → pilgrim view → enable offline in profile → play audio offline.
3. Deploy bucket policies to remote Supabase when ready.

## Key paths
| Concern | Location |
|---------|----------|
| Storage migration | `supabase/migrations/20260610120000_content_media_storage.sql` |
| Upload | `lib/features/content/data/storage/content_media_storage_service.dart` |
| Offline cache | `lib/features/content/application/services/content_media_cache_service.dart` |
| Providers | `lib/features/content/presentation/providers/content_media_providers.dart` |
| Native audio | `lib/core/widgets/native_audio_player.dart` |
| Admin preview/upload | `admin_content_topic_edit_screen.dart` |
| Offline UI | `content_offline_settings_card.dart`, `content_topic_offline_actions.dart` |
| Home skeleton | `content_media_widgets.dart` → `ContentTopicsSectionSkeleton` |
