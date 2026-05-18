# Active Context

> **Read this file at the start of every session.**

## Current focus
**App shell complete** — bootstrap, Riverpod, go_router, theme, l10n, and error handling are wired. Ready for feature development.

## Recent changes (2026-05-18)
- Replaced counter demo with production app shell.
- Added l10n (`l10n.yaml`, `app_en.arb`, `app_ar.arb`).
- Added `AppBootstrap` with Supabase optional init, zone error handling, retry UI.
- Added `AppRoot` (Riverpod + ScreenUtil + MaterialApp.router + themes + l10n).
- Added `@riverpod` `appRouter` with home route and 404 screen.
- Added `HomeScreen` feature widget.

## Next steps
1. Add Supabase dart-defines for local dev (`SUPABASE_URL`, `SUPABASE_ANON_KEY`).
2. Initialize `supabase/` CLI project and migrations.
3. Implement first real feature (auth or onboarding).
4. Add `ProviderObserver` / crash reporting in release bootstrap.

## Key paths
| Concern | Location |
|---------|----------|
| Entry | `lib/main.dart` |
| Bootstrap | `lib/core/bootstrap/app_bootstrap.dart` |
| Router | `lib/core/routing/app_router.dart` |
| Theme | `lib/core/theme/app_theme.dart` |
| Strings | `lib/l10n/*.arb` |

## Run
```bash
flutter run
# With Supabase:
flutter run --dart-define=SUPABASE_URL=http://10.0.2.2:54321 --dart-define=SUPABASE_ANON_KEY=your-key
```
