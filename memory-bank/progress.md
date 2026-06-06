# Progress

> **Update this file after every completed task.**

## Status summary
| Area | Status |
|------|--------|
| App shell (main, bootstrap, errors) | ✅ Done |
| Riverpod | ✅ `ProviderScope` + `@riverpod` router |
| go_router | ✅ Home + 404 |
| Theme (light/dark) | ✅ `AppTheme` |
| l10n (en/ar) | ✅ ARB + codegen |
| ScreenUtil | ✅ In `AppRoot` |
| Supabase init | ✅ Local dart-define files + launch configs |
| Feature modules | ✅ Home + auth + public content (US-01/03) |
| Public content (US-01) | ✅ Videos, news, detail, RLS |
| Islamic tools (US-02) | ✅ Prayer, Qibla, Quran, Adhkar (offline) |
| Pilgrim dashboard (US-04) | ✅ Rituals + logistics, offline sync |
| Operator intake (US-05) | ✅ Web login, form, storage, create-pilgrim |
| Field operator (US-06) | ✅ Mobile search, status updates, share copy |
| Admin analytics (US-07) | ✅ Web dashboard, charts, groups, live Supabase |
| Admin content CMS (US-08) | ✅ Web `/admin/content` CRUD on `content_library` |
| Operator pilgrim registry (US-09) | ✅ Web `/operator/pilgrims` list + logistics edit |
| Competitions (US-10) | ✅ Pilgrim join/leaderboard + admin CRUD |
| Dev one-command scripts | ✅ `npm run dev` / `scripts/*.ps1` |
| Android build stability | ✅ Gradle AGP + JVM tuning (re-verify APK on your machine) |
| Crash reporting hook | ✅ `CrashReporter` + `CRASH_REPORTING_ENABLED` dart-define |
| CI (analyze + test) | ✅ `.github/workflows/flutter_ci.yml` |
| Auth (US-03) | ✅ Login, pilgrim session, guest/pilgrim home |
| Supabase migrations | ✅ profiles + RLS (local) |
| In-app notifications (inbox) | ✅ Inbox, badge, Realtime, broadcast, triggers, SnackBar |
| FCM push (phase 3) | ✅ device_tokens, Edge Function, Flutter registration (needs Firebase project) |

## Completed
- [x] Memory Bank + linting + dependencies
- [x] l10n configuration (en/ar)
- [x] `main.dart` with `runZonedGuarded` + bootstrap error UI + retry
- [x] `AppBootstrap` (Flutter/Platform errors, optional Supabase)
- [x] `AppRoot` — Riverpod, ScreenUtil, themes, l10n, `MaterialApp.router`
- [x] `appRouter` provider (go_router)
- [x] `HomeScreen`, `RouteNotFoundScreen`, `BootstrapFailureApp`
- [x] Widget test for `AppRoot`
- [x] Local Supabase dart-define JSON + `.vscode/launch.json`

## Backlog
- [x] Crash reporting hook in bootstrap
- [x] Auth feature (US-03 pilgrim login)
- [x] US-01 public content (videos, news on home)
- [x] US-02 Islamic tools (offline prayer, qibla, quran, adhkar)
- [x] US-04 pilgrim rituals + logistics dashboard
- [x] US-05 operator web intake (pilgrim registration + documents + credentials)
- [x] US-06 field operator mobile (search pilgrims, update field status)
- [x] US-07 admin analytics web (charts, pilgrim/group/operator metrics)
## Backlog (notifications)
- [x] Admin broadcast compose UI
- [x] DB triggers (content published, competition activated)
- [x] In-session SnackBar on new notification
- [x] FCM push (device tokens + Edge Function)

## Changelog

### 2026-06-06
- **Locale:** Arabic default; `LocaleController` + persisted preference; global `LanguageSwitcherFab` with bottom sheet picker.
- **Auth:** Fixed profiles RLS infinite recursion (`42P17`) that broke login for all roles; misreported as `authErrorNetworkConnection`. Migration `20260606100000_fix_profiles_rls_recursion.sql`.
- Fixed `avoid_redundant_argument_values` on GoRouter `debugLogDiagnostics`; moved opt-in flag to `AppConfig.routerDebugLog` / `routerDebugLogDiagnostics` getter.

### 2026-06-05 (session 3)
- **Performance:** Riverpod derived auth providers, narrowed router refresh, `PushNotificationStarter`, widget splits (Qibla, bell, logins, notifications, pilgrim optimistic toggle).

### 2026-06-05 (session 2)
- **Android emulator:** `Lost connection to device` traced to OOM kill (`lowmemorykiller`, ~460 MB RSS on `gphone16k`). Runbook troubleshooting + AVD RAM guidance. GoRouter verbose route logging opt-in only.

### 2026-06-05 (Supabase Android sign-in)
- Gradle merges `dart_defines.android.local.json` into debug builds; cleartext HTTP for local Supabase; clearer auth error messages.

### 2026-06-03 (zone fix)
- Fixed Flutter **Zone mismatch**: all startup (`ensureInitialized`, FCM handler, `_launchApp` / `runApp`) now runs inside the same `runZonedGuarded` zone.

### 2026-06-03 (phase 3)
- **FCM push:** `device_tokens`, Edge `send-push-notification`, pg_net trigger, Flutter FCM bind/unbind, `docs/push-notifications-setup.md`.

### 2026-06-03 (phase 2)
- **Notifications:** RPC broadcast, content/competition triggers, `/admin/notifications/send`, `NotificationToastHost` SnackBar.

### 2026-06-03 (phase 1)
- **Notifications MVP:** `notifications` table + RLS + Realtime; inbox route `/notifications`; bell + unread badge; AR/EN l10n.

### 2026-05-21 (session 2)
- Crash reporting: `lib/core/telemetry/crash_reporter.dart`, wired in bootstrap + `main.dart`.
- CI: GitHub Actions `flutter_ci.yml` (analyze + test).
- `scripts/seed-demo-users.ps1` + `npm run setup:users`; `dev-setup` seeds Auth automatically.
- Staging/production `dart_defines.*.example.json`; Gradle JVM limits for Android daemon stability.

### 2026-05-21
- **US-10:** Competitions feature + migration + dev scripts + Android Gradle hardening.
- **US-09:** Operator pilgrim registry — search list, detail logistics update on web.
- **US-08:** Admin content CMS — list/create/edit/delete, RLS for admins, routes under `/admin/content`.
- Added `docs/runbook-ar.md` (Arabic ops guide: Supabase, demo users, launch configs, routes per role).
- Fixed deprecated `RadioListTile.onChanged` / `groupValue` in field operator pilgrim screen via `RadioGroup`.
- **US-07:** Admin web `/admin/dashboard`, `groups` table, `fl_chart` analytics (pilgrims by group, field status, operator uploads, ritual %).
- **US-06:** Field operator mobile `/operator/field`, pilgrim search, `field_status` updates, clipboard share summary.
- **US-05:** Operator web `/operator/login` + `/operator/intake`, `create-pilgrim` edge function, `pilgrim-documents` storage, staff sign-in.
- **US-04:** Pilgrim dashboard `/pilgrim`, ritual checklist with offline cache + Supabase sync, logistics card.
- **US-02:** Islamic tools hub, prayer times (adhan + GPS cache), Qibla compass, offline Quran, adhkar.
- **US-01:** `content_library` table, public feed on home, content detail route, seed data.
- **US-03:** Pilgrim login (`/login`), Supabase Auth, `profiles.role`, guest vs pilgrim home UI, migration + seed docs.
- Created Notion page **Rafiq Al-Hajj — Flutter Dev Status (Cursor sync)** under project workspace (team-visible snapshot of memory-bank).

### 2026-05-19
- Added `dart_defines.local.json` / Android variant (gitignored) and example templates.
- Added Cursor/VS Code launch configs for local Supabase.

### 2026-05-18
- Initialized Memory Bank, packages, linting.
- Built full app shell: bootstrap, routing, theme, l10n, error handling.
