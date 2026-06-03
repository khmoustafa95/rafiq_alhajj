# Active Context

> **Read this file at the start of every session.**

## Current focus
**Notifications phase 3 (FCM)** — device tokens, Edge Function push, mobile registration.

## Recent changes (2026-06-03, phase 3)
- `device_tokens` table + `send-push-notification` Edge Function (firebase-admin).
- pg_net trigger on `notifications` INSERT → Edge Function.
- Flutter: `firebase_core` / `firebase_messaging`, token sync on auth, tap → route.
- Docs: `docs/push-notifications-setup.md`, runbook §11.

## Recent changes (2026-06-03, phase 2)
- Migration `20260603110000_notifications_phase2.sql` — RPC `send_notification_broadcast`, triggers on `content_library` / `competitions`.
- Admin screen `/admin/notifications/send` (audience: all pilgrims, group, operators).
- `NotificationToastHost` — SnackBar on new Realtime notification.
- Dashboard link **Send notification**.

## Recent changes (2026-06-03, phase 1)
- Migration `20260603100000_notifications.sql` (RLS, Realtime, demo welcome rows for pilgrims).
- Feature `lib/features/notifications/` — inbox, bell badge, deep links.

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
1. `supabase db reset` + `npm run setup` — apply phase 2 migration.
2. Admin: **Send notification** → all pilgrims; pilgrim device shows SnackBar + badge.
3. Admin: add CMS content or active competition → pilgrims get auto notifications.
4. Configure Firebase + `google-services.json` + Edge secrets; test push on Android.

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
