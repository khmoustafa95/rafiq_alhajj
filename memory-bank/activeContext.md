# Active Context

> **Read this file at the start of every session.**

## Current focus
**Ops hardening complete** — crash reporting hook, CI, demo user seed script, Gradle JVM tuning.

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
1. `npm run setup` — reset DB + demo users (auto).
2. `npm run dev` / `dev:android` — full feature smoke test.
3. Confirm `flutter build apk --debug` on your PC (Gradle daemon may need RAM).
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
