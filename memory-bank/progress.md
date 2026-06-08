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
| Field operator (US-06) | ✅ Stats dashboard, filters, full pilgrim profile, status updates |
| Admin analytics (US-07) | ✅ Web dashboard, charts, groups, live Supabase |
| Admin content CMS (US-08) | ✅ Web `/admin/content` CRUD on `content_library` |
| Admin operator management | ✅ Web `/admin/operators` CRUD + permissions (needs migration + edge fn deploy) |
| Admin group management | ✅ Web `/admin/groups` CRUD + members + logo upload (needs migration apply) |
| Admin system settings | ✅ Web `/admin/settings` global config (needs migration apply) |
| Operator pilgrim registry (US-09) | ✅ Web `/operator/pilgrims` list + logistics edit |
| Competitions (US-10) | ✅ Pilgrim join/leaderboard + admin CRUD |
| Dev one-command scripts | ✅ `npm run dev` / `scripts/*.ps1` |
| Android build stability | ✅ Gradle AGP + JVM tuning (re-verify APK on your machine) |
| Crash reporting hook | ✅ `CrashReporter` + `CRASH_REPORTING_ENABLED` dart-define |
| CI (analyze + test) | ✅ `.github/workflows/flutter_ci.yml` |
| Auth (US-03) | ✅ Login, pilgrim session, guest/pilgrim home |
| Supabase migrations | ✅ profiles + RLS (local) |
| In-app notifications (inbox) | ✅ Inbox, badge, Realtime stream, broadcast, triggers, SnackBar |
| Supabase Realtime (live data) | ✅ pilgrim registry, content, admin, competitions, rituals |
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

### 2026-06-09 — Admin system settings
- [x] Migration: `system_settings` global row + admin RLS + realtime
- [x] Flutter `admin_settings` feature + route + sidebar + l10n (en/ar)

### 2026-06-09 — Admin group management
- [x] Migration: group leadership fields, administration members, storage bucket, admin RLS
- [x] Flutter `admin_groups` feature + routes + sidebar + l10n (en/ar)

### 2026-06-08 — Staff web data tables
- [x] `StaffDataTable` reusable widget (sort, filter, pagination)
- [x] Server-side pagination: operators + pilgrims; client-side: content + competitions
- [x] All staff web list pages migrated to table layout

### 2026-06-08 — Admin operator management
- [x] Migration: `profiles` email, `is_active`, `operator_permissions`; admin update RLS
- [x] Edge function `manage-operator` (create/update operator accounts)
- [x] Flutter feature `admin_operators` + routes + sidebar nav + l10n (en/ar)

### 2026-06-08 — Admin dashboard loading fix
- [x] Debounced realtime invalidation (`realtime_refresh.dart`)
- [x] Admin dashboard: fetch before realtime subscribe; parallel Supabase queries
- [x] Dashboard UI: `skipLoadingOnReload`, show error detail, remove duplicate chart block


### 2026-06-08 (pm)
- **Staff web shell fix:** `StatefulShellRoute` → `ShellRoute` for operator/admin pages; `StaffWebPage` + `StaffWebShell` layout constraints fixed (blank intake pane + overlay hit-test errors).

### 2026-06-08
- **Staff web UI redesign:** `StaffWebPage` + form sections + responsive grid + sticky action bar; `StaffWebShell` drawer on narrow screens, role-based nav; operator intake/list/detail and all admin web pages refactored.
- **Staff web login redesign:** `StaffWebLoginScaffold` — responsive split hero/form (≥900px), scrollable compact layout on narrow screens; operator + admin login refactored; l10n hero highlights; fixes bottom overflow on web.
- **Field operator shell:** bottom nav (Home stats dashboard + Pilgrims list); replaced monolithic home screen.
- **Supabase Realtime:** migration + `watchSupabaseTable` helper; providers invalidate on table changes.
- **Fake pilgrim data:** 12 demo pilgrims (`pilgrim@demo.local` … `pilgrim12@demo.local`) with full registry in `scripts/fake-pilgrim-registry.json`; seeded via `seed-fake-pilgrim-registry.mjs` (all 5 `field_status` values, varied clusters/groups/health/hotels).
- **US-06 extended registry:** `Pilgrim` model with full Excel/Kobo field set; migration `20260608120000_pilgrim_registry_extended.sql`; `PilgrimRegistryRepository`; field operator stats + status filters + redesigned list; operator/pilgrim full profile sections (`PilgrimProfileSections`); seed demo data updated.

### 2026-06-06
- **Auth fix:** Added 15s timeout for Supabase `signInWithPassword` and profile fetch in `SupabaseAuthRepository`; timeout now maps to `network` error so login loading does not hang on bad config/network.
- **Haram guide v2:** Ritual guide cards (Tawaf/Sa'i/Zamzam steps), `flutter_map` OSM around Kaaba, Pannellum + real Makkah CC0 panorama + Kaaba photo (Wikimedia); renamed «دليل الحرم».
- **Home previews:** `QuickActionTiles` horizontal scroll (4 tools from `islamicToolsCatalog`) + see all; `ContentSection` `maxItems`/`onSeeAll`; `ContentListScreen` routes for full videos/news lists.
- **Runtime fix:** `AppTypography` uses bundled `ThemeData` text theme (no `google_fonts` CDN); `runZonedGuarded` error callback logs only — fixes Zone mismatch + offline emulator crash.
- **Home journey CTA:** Guest card — «تواصل معنا» opens WhatsApp inquiries (`963951957301`); «إدخال معلومات التسجيل» → `/login`. Removed register-now / duplicate pilgrim-login buttons.
- **Design (applied):** Hajj Companion visual system — `AppColors`/`AppTypography`/`AppDecorations`, Inter via `google_fonts`, mobile `PilgrimShellScreen` (Home/Guidance/Services/Profile), redesigned home (prayer hero, quick actions, journey CTA, news cards), notifications (featured hero, filter chips, accent cards, Qibla FAB), web `StaffWebShell` + admin dashboard KPI cards + CMS content grid.
- **Design:** Added `Design.md` — editable redesign spec template (brand, theme, components, per-screen inventory, phased apply instructions).
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

### 2026-06-08
- Admin dashboard: fixed infinite loading (realtime debounce + defer subscribe until after first fetch).
- Parallel Supabase dashboard queries + 30s timeout; `skipLoadingOnReload` on dashboard UI.
- Staff web: row-safe button styles, layout fixes for operator intake / pilgrim list.

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
