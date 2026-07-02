# Content offline smoke test checklist

Use this checklist after merging PR #3 (Phase 1) and PR #4 (enhancements).

## Prerequisites
- Local Supabase: `supabase start`
- Flutter run with dart-defines, e.g. `flutter run -d chrome --dart-define-from-file=dart_defines.local.json`
- Pilgrim account: `pilgrim@demo.local` / `demo123456`

## Automated (CI / local)
```bash
flutter test test/content_offline_smoke_test.dart test/widget_test.dart
flutter analyze lib test
```

Covers: `CatalogSnapshot` TTL, catalog cache read/search, quiz queue, media resume position cache, stale indicator widget.

## Manual — pilgrim (mobile preferred)

### 1. Stale-while-revalidate + badge
1. Open home while online; wait for feed to load.
2. Enable airplane mode.
3. Kill and reopen the app.
4. **Expect:** feed/topics still visible; `ContentStaleIndicator` shows saved-catalog message.
5. Disable airplane mode; pull to refresh.
6. **Expect:** badge disappears after refresh completes.

### 2. Video/audio resume
1. Sign in as pilgrim; open an educational topic with native video or audio (not YouTube).
2. Play for ~30s; leave the topic.
3. Reopen the same topic/media.
4. **Expect:** playback resumes near the previous position.

### 3. My Downloads
1. Profile → enable offline downloads; wait for at least one topic to cache.
2. Open **My downloads** (`/content/downloads` from profile card link).
3. **Expect:** grouped topics with file count and size; tap opens topic detail.

### 4. Local search
1. With cached catalog (step 3), go to Topics list → search icon.
2. Search a known topic or news title fragment.
3. Enable airplane mode; search again.
4. **Expect:** hits from local cache only; empty state when no match.

### 5. Quiz offline queue
1. Open an active competition quiz while online; answer one question successfully.
2. Enable airplane mode before the next submit.
3. Submit an answer.
4. **Expect:** snackbar “Answer saved — will sync when you're back online”.
5. Restore connectivity.
6. **Expect:** answer syncs; quiz progress updates without re-submitting.

### 6. Wi-Fi onboarding
1. Fresh install or clear app data; sign in as pilgrim.
2. Open home once.
3. **Expect:** one-time Wi-Fi download dialog; “Not now” dismisses permanently.

### 7. Push prefetch (optional)
1. Send FCM/data push with `route=contentTopic` and a valid `id`.
2. **Expect:** topic metadata (and media if offline enabled) prefetched before navigation.

## Notes
- YouTube/Vimeo videos do not support offline resume or encrypted cache.
- Web build skips some download UI (`!AppPlatform.isWeb` guards).
