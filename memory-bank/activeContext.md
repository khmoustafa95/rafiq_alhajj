# Active Context

> **Read this file at the start of every session.**

## Current focus
**Design.md updated** — documents applied Hajj Companion redesign (Phases 1–4), tokens, screen status, l10n keys; Phase 5 polish backlog listed.

## Previous focus (2026-06-06)
**Hajj Companion redesign applied** — new theme (green/gold/indigo), mobile bottom nav shell, redesigned home/notifications, web admin sidebar + CMS grid.

## Previous focus (2026-06-06)
**App redesign planning** — `Design.md` template at repo root.

## Previous focus (2026-06-06)
**Arabic default locale + AppBar language switcher** — `RafiqAppBar` on all screens; Quran surah names locale-aware.

## Recent changes (2026-06-06, locale v2)
- Language switcher moved from floating FAB to **`RafiqAppBar`** (chip in app bar actions on every screen).
- Staff login screens gained `RafiqAppBar`; removed `LanguageSwitcherOverlay`.
- Quran list/detail: surah names follow active locale; `toolsQuranSurahSubtitle` ARB key.

## Recent changes (2026-06-06, locale v1)
- Default locale **Arabic**; `LocaleController` + `shared_preferences`.

## Recent changes (2026-06-06, Arabic demo names)
- Demo user seeding moved to `scripts/seed-demo-users.mjs` (Node UTF-8). Windows PS 5.1 `ConvertFrom-Json` was corrupting Arabic → `????` in `profiles.full_name`.
- `npm run setup:users` now updates existing users + patches `profiles.full_name`.

## Recent changes (2026-06-06, profiles RLS)
- Migration `20260606100000_fix_profiles_rls_recursion.sql` — `is_admin()` / `is_operator_or_admin()` SECURITY DEFINER helpers; fixed policies on `profiles` that queried `profiles` under RLS.
- Symptom: "Cannot reach Supabase" on operator/pilgrim/admin login despite Supabase running and correct `dart_defines.local.json`.

## Recent changes (2026-06-05, performance / rebuild optimization)
- Derived auth providers: `authAccessModeProvider`, `authProfileIdProvider`, `authProfileFullNameProvider` — dependents rebuild only when value changes.
- Router refresh listens to `authAccessModeProvider` only (not every Supabase token refresh).
- `PushNotificationStarter` moved below `MaterialApp` so FCM init does not rebuild the whole app tree.
- Widget splits / `select`: Qibla compass, notification bell, competition actions, mark-all-read, login submit buttons.
- Pilgrim ritual toggle: optimistic update (no full-screen loading flash).

## Recent changes (2026-06-05, Android emulator OOM)
- Diagnosed `Lost connection to device`: Android **lowmemorykiller** kills app (~460 MB RSS) when emulator RAM/swap low.
- Runbook §3b + §9: increase AVD RAM to 4 GB+, prefer `gphone64` over `gphone16k`, logcat check.
- GoRouter `debugLogDiagnostics` via `AppConfig.routerDebugLogDiagnostics` (opt-in `--dart-define=ROUTER_DEBUG_LOG=true`); avoids `avoid_redundant_argument_values` lint when off.

## Recent changes (2026-06-05, Supabase sign-in fix)
- Android Gradle auto-loads `dart_defines.android.local.json` when Supabase keys missing from CLI.
- Debug manifest: `usesCleartextTraffic=true` for local HTTP Supabase.
- Auth errors split: missing config vs network connection (`authErrorNetworkConnection`).

## Recent changes (2026-06-03, zone fix)
- **`main.dart`:** `WidgetsFlutterBinding.ensureInitialized()` and FCM background handler moved **inside** `runZonedGuarded` so `runApp` and binding init share the same Zone (fixes Zone mismatch warning).
- Removed duplicate `ensureInitialized` from `AppBootstrap.initialize()`.

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
1. Run app with dart-defines: `flutter run --dart-define-from-file=dart_defines.android.local.json`
2. If sign-in fails: use JWT `ANON_KEY` from `supabase status -o env` (not Publishable key); confirm Supabase running; try without VPN.
3. `supabase db reset` + `npm run setup` if needed for notification migrations.
4. Configure Firebase when ready for push (see `docs/push-notifications-setup.md`).

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
