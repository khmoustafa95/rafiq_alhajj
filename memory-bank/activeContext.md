# Active Context

> **Read this file at the start of every session.**

## Current focus
**In-app notifications MVP** — Supabase `notifications` table, inbox UI, bell badge + Realtime unread count.

## Recent changes (2026-06-03)
- Migration `20260603100000_notifications.sql` (RLS, Realtime, demo welcome rows for pilgrims).
- Feature `lib/features/notifications/` — repository, Riverpod providers, list screen, deep links.
- Route `/notifications`; bell on home (signed-in), pilgrim dashboard, admin/operator dashboards.
- l10n keys `notifications*` (AR/EN).

## Recent changes (2026-05-21 session 2)
- `CrashReporter` + `CRASH_REPORTING_ENABLED` for release telemetry wiring.
- `.github/workflows/flutter_ci.yml`; `npm run setup` now runs `seed-demo-users.ps1`.
- `dart_defines.staging.example.json` / `production.example.json`.
- Android `gradle.properties`: 4G heap, parallel off, worker cap.

## Recent changes (2026-05-21)
- **US-10:** Competitions (`/competitions`, `/admin/competitions`), seed data, pilgrim join + leaderboard.
- **Dev:** `scripts/dev-chrome.ps1`, `dev-android.ps1`, `dev-setup.ps1`, `npm run dev`.
- **Android:** `android.newDsl=false`, AGP 8.11.1 force for legacy plugins, Aliyun Maven mirrors, `file_picker`/`geolocator` bumps.
- **US-09:** Operator `/operator/pilgrims` list + detail edit; uses existing operator RLS on `profiles` / `pilgrim_details`.
- **US-08:** Admin CMS `/admin/content`, migration `20260521180000_admin_content_cms.sql`, dashboard link.
- Arabic runbook: `docs/runbook-ar.md` (commands, demo accounts, platforms, routes).
- `dart_defines.android.local.example.json` + README link to runbook.
- Field operator pilgrim screen: `RadioListTile` group migrated to `RadioGroup` (Flutter 3.32+ radio API).
- Migration `20260521170000_admin_analytics.sql` (`groups` table, admin read policies).
- `admin_analytics` feature: KPI cards + bar/pie charts (`fl_chart`).
- `AppAccessMode.admin`, `signInAdmin`, routes `/admin/login` + `/admin/dashboard`.
- Web routing: operators → intake, admins → dashboard; link from operator login.

## Next steps
1. `supabase db reset` then `npm run setup` — apply notifications migration + demo users.
2. Sign in as `pilgrim@demo.local` — open bell → welcome notification → mark read.
3. Phase 2: admin broadcast UI, content/competition triggers, FCM push.
4. Production: hosted Supabase, Play Store signing, plug Sentry/Crashlytics into `ConfiguredCrashReporter`.

## Key paths
| Concern | Location |
|---------|----------|
| Admin dashboard | `lib/features/admin_analytics/presentation/widgets/admin_dashboard_screen.dart` |
| Analytics repo | `lib/features/admin_analytics/data/repositories/admin_analytics_repository.dart` |
| Migration | `supabase/migrations/20260521170000_admin_analytics.sql` |

## Run (admin web)
```bash
supabase db reset
supabase auth users create admin@demo.local --password demo123456 --email-confirm --user-metadata "{\"role\":\"admin\",\"full_name\":\"خالد المسؤول\"}"
flutter run -d chrome --dart-define-from-file=dart_defines.local.json
```

Open `/admin/login` or use **Admin analytics sign in** from operator login page.  
Demo: `admin@demo.local` / `demo123456`
