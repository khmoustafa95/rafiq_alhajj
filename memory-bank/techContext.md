# Tech Context

## Stack

| Area | Package / tool | Version (resolved) |
|------|----------------|-------------------|
| Framework | Flutter SDK | Dart ^3.11.4 |
| State | `flutter_riverpod` | ^3.3.1 |
| State codegen | `riverpod_annotation` / `riverpod_generator` | ^4.0.2 / ^4.0.3 |
| Routing | `go_router` | ^17.2.3 |
| Backend | `supabase_flutter` | ^2.12.4 |
| Models | `freezed` / `freezed_annotation` | ^3.2.5 / ^3.1.0 |
| JSON | `json_serializable` / `json_annotation` | ^6.9.5 / ^4.11.0 |
| L10n | `flutter_localizations` + `intl` | SDK / ^0.20.2 |
| Responsiveness | `flutter_screenutil` | ^5.9.3 |
| Forms | `reactive_forms` | ^18.2.2 |
| Assets codegen | `flutter_gen_runner` (dev) → `lib/core/gen/assets.gen.dart` | ^5.14.1 |
| Codegen runner | `build_runner` | ^2.15.0 |
| Lints | `flutter_lints` | ^6.0.0 |
| Push (FCM) | `firebase_core` / `firebase_messaging` | ^3.15 / ^15.2 |

> **Removed:** `google_fonts` (unused — app uses the bundled system text theme via `AppTypography`).
> **Fonts:** Inter `.ttf` files exist under `assets/fonts/` but are not currently declared/wired (system theme used).

## Dev environment
- **OS:** Windows 10
- **Supabase local:** CLI v2.90.0 via Docker (not set up in repo)
- **Android emulator localhost:** `10.0.2.2` for Supabase/API

## Linting (`analysis_options.yaml`)
- Base: `package:flutter_lints/flutter.yaml`
- Strict analyzer: `strict-casts`, `strict-inference`, `strict-raw-types`
- Excludes: `*.g.dart`, `*.freezed.dart`
- Extended rules: style, imports (`always_use_package_imports`), safety (`discarded_futures`, `use_build_context_synchronously`), etc.

## Localization
- `pubspec.yaml`: `flutter: generate: true`
- **TODO:** `l10n.yaml`, `lib/l10n/*.arb`

## Commands
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
dart analyze
npm run setup          # db reset + demo Auth users
npm run dev            # Chrome
npm run dev:android    # Android emulator/device
```

## CI
- `.github/workflows/flutter_ci.yml` — `flutter analyze` + `flutter test` on push/PR to `main`/`master`.

## Local run documentation
- **Arabic runbook:** `docs/runbook-ar.md` — Supabase setup, `dart_defines.*.json`, demo accounts (`demo123456`), Chrome vs mobile flows.
- **Templates:** `dart_defines.local.example.json`, `dart_defines.android.local.example.json`, `dart_defines.staging.example.json`, `dart_defines.production.example.json`.
- **Crash reporting:** `CRASH_REPORTING_ENABLED=true` in release dart-defines; wire Sentry/Crashlytics in `ConfiguredCrashReporter`.
- **Push (FCM):** `docs/push-notifications-setup.md`; `FIREBASE_*` dart-defines; Edge secrets `FIREBASE_SERVICE_ACCOUNT_JSON`, `PUSH_WEBHOOK_SECRET`.
- **Push (FCM Web):** extra web-only dart-defines `FIREBASE_WEB_APP_ID`, `FIREBASE_AUTH_DOMAIN`, `FIREBASE_STORAGE_BUCKET`, `FIREBASE_VAPID_KEY`, `FIREBASE_MEASUREMENT_ID` (from a Firebase **Web app** + Cloud Messaging Web Push VAPID cert). The service worker `web/firebase-messaging-sw.js` holds the same public web config inline (can't read dart-defines) — keep its placeholders in sync.

## Version notes
- `json_annotation` pinned to **^4.11.0** (not 4.12) so `riverpod_generator` + `json_serializable` resolve with Flutter SDK `meta` pin.
- `riverpod_lint` / `custom_lint` **not** added due to dependency conflicts.

## Project layout
```
lib/main.dart          # Default counter (broken syntax)
memory-bank/
.cursor/rules/
```
