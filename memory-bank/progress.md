# Progress

> **Update this file after every completed task.**

## Changelog
- **2026-06-21 — Admin pilgrim workflow overhaul:** compact login language control + smaller icons; removed `US-0x` codes from ARBs; full pilgrim field set exposed via a single `pilgrim_field_catalog` (intake + edit forms + table) with raw-backed models and server-side column allowlists in `create-pilgrim`; resilient creation (best-effort doc upload, partial-success warning); expanded table columns (cluster/sticker/makkah_hotel/phone/whatsapp); persisted "shared defaults" + `TripSelector` for fast entry; uploads moved to `pilgrim_intake_remote_data_source` with size/MIME guards; WhatsApp "send login info" row action backed by new operator/admin-gated `reset-pilgrim-password` edge fn; notifications audit (no fixes needed). `flutter analyze` clean. ⚠ Restart local edge runtime to serve `reset-pilgrim-password`.

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
| Competitions (US-10) | ✅ Quizzes: admin questions + pilgrim play + RPC scoring |
| Hajj journey CMS + path | ✅ Services hub, profile split, ritual path + media |
| Content topics (thematic media) | ✅ Topics + media series, home section, pilgrim/guest detail, admin CMS |
| Content media storage + offline | ✅ Supabase bucket upload, Dio cache, profile/topic offline UI (apply migration) |
| Native audio (Android/iOS) | ✅ `audioplayers`; web keeps WebView fallback |
| Dev one-command scripts | ✅ `npm run dev` / `scripts/*.ps1` |
| Android build stability | ✅ Gradle AGP + JVM tuning (re-verify APK on your machine) |
| Crash reporting hook | ✅ `CrashReporter` + `CRASH_REPORTING_ENABLED` dart-define |
| CI (analyze + test) | ✅ `.github/workflows/flutter_ci.yml` |
| Auth (US-03) | ✅ Login, pilgrim session, guest/pilgrim home |
| Supabase migrations | ✅ profiles + RLS (local) |
| In-app notifications (inbox) | ✅ Inbox, badge, Realtime stream, broadcast, triggers, SnackBar; **guest public feed** |
| Pilgrim ↔ trips restructure | ✅ Final-form migrations (no `pilgrim_details`), Arabic seed, trips feature, operator/admin/edge write paths + rituals-per-enrollment, operator→group permissions; `db reset` + analyze clean (live RLS = manual QA) |
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

### 2026-06-21 — Demo-user seeder fix (admin login)
- [x] Removed obsolete `seedFakePilgrimRegistry` import/call from `seed-demo-users.mjs` (targeted dropped `pilgrim_details`; Arabic data now in `seed.sql`).
- [x] `updateUser` now re-sets `password` + `email_confirm: true` → seeder is idempotent/self-healing for existing accounts.
- [x] Verified `npm run setup:users` exits 0; password-grant test → admin login OK (`role: admin`, email confirmed).

### 2026-06-20 — `.cursorrules` conformance audit + rollout
- [x] **Audit** of codebase vs updated `.cursorrules`; `flutter analyze` already clean.
- [x] **`.cursorrules`** updated: blessed `AppColors` tokens (wired into `ColorScheme`) + banned raw `Color(0x…)` in widgets; fixed outdated `AppLocalizations.of(context)!` example.
- [x] **Deps:** added `reactive_forms` + `flutter_gen_runner`; removed unused `google_fonts`.
- [x] **`flutter_gen`** assets: `lib/core/gen/assets.gen.dart`; declared `virtual_tour/images` + `pannellum` dirs; replaced 2 hardcoded asset paths with `Assets.*`.
- [x] **`data_sources/` layer rolled out to ALL repositories** (~21 features): every `SupabaseClient` call (`.from`/`.rpc`/`.storage`/`.functions`/`.auth`) moved to `data/data_sources/*_remote_data_source.dart`; repos build the DS from the injected client (no provider changes) and keep mapping + try/catch. Canonical: `trips`. Verified: no repo references `_client`/`.from('`/`.rpc(`/`Supabase.instance`.
- [x] **`reactive_forms` rolled out to all validation forms** (17 incl. trip editor): `FormGroup`/`ReactiveForm`/`ReactiveTextField`/`ReactiveDropdownField` + `Validators` + `validationMessages`. No `TextFormField`/`GlobalKey<FormState>` remain. Canonical: `trip_editor_dialog`.
- [x] Verified: `flutter analyze` → No issues found; `build_runner` clean.
- [ ] Residual (intentional): search fields + dynamic media-draft rows keep `TextEditingController` (not validation forms); Inter fonts under `assets/fonts/` not yet wired.

### 2026-06-20 — Pilgrim ↔ trips (phase 2 + final-form migrations)
- [x] **Migrations rewritten to final form** (dev data is disposable): dropped `pilgrim_details` + the restructure/backfill migration. `20260521140000_pilgrim_rituals.sql` now builds the whole pilgrim domain directly (`groups`, `operator_group_access`, `trips`, `trip_groups`, `pilgrims`, `trip_enrollments`, per-enrollment `ritual_logs`, RLS, view, triggers).
- [x] New `20260521121000_rls_helpers.sql` (`is_admin`/`is_operator_or_admin`); deleted `fix_profiles_rls_recursion` + `pilgrim_registry_extended`; `operator_intake`/`field_operator`/`admin_analytics`/`admin_pilgrim_management`/`enable_realtime` retargeted to new tables.
- [x] **Operator → group permissions:** `operator_group_access` + `operator_can_read_group()`/`operator_can_write_group()`; `trip_enrollments` RLS group-scoped for operators. Admin operator editor "Group access" section (read / read+write per group); repo loads + replaces grants; new operators default to all groups via DB trigger.
- [x] **Phase-2 app:** operator registry keyed by `pilgrimId` (route `/operator/pilgrims/:pilgrimId`), reads view + writes `pilgrims`/`trip_enrollments`; admin analytics on new tables; rituals per `enrollment_id`; `create-pilgrim` edge fn writes `pilgrims` + active-trip enrollment; `realtime_tables.dart` updated.
- [x] **Arabic seed** (`supabase/seed.sql`): 3 offices, 2 trips (Hajj active / Umrah planning), 8 pilgrims, 10 enrollments, Arabic content/competitions.
- [x] Verified: `supabase db reset` clean (2 trips/3 groups/8 pilgrims/10 enrollments); `flutter analyze` clean; `build_runner` + `gen-l10n` regenerated.
- [ ] Pending: live RLS test with demo auth users; retire/refresh `scripts/seed-fake-pilgrim-registry.mjs` (still targets `pilgrim_details`).

### 2026-06-20 — Pilgrim ↔ trips restructure (phase 1)
- [x] Migration `20260620120000_pilgrim_trips_restructure.sql`: `trips`, `trip_groups`, `pilgrims` (passport identity), `trip_enrollments` (per-trip logistics); `ritual_logs.enrollment_id`; `pilgrim_documents.pilgrim_id`/`enrollment_id`.
- [x] Backfill legacy `pilgrim_details` → person + enrollment under stable legacy trip; `group_name` → `groups`/`trip_groups`; rituals/documents relinked. RLS for all new tables; `pilgrim_enrollment_view` (security_invoker); realtime added.
- [x] Flutter `trips` feature: models, `TripsRepository`, providers, admin `/admin/trips` + `/admin/trips/:id/offices`, sidebar nav, `TripSelector`. `PilgrimRegistryRepository` reads the view (optional `tripId`), writes `trip_enrollments`; field operator wired to active trip. l10n en/ar; `flutter analyze` clean.
- [ ] Pending: operator intake / `create-pilgrim` edge fn / operator + admin-analytics reads still on legacy `pilgrim_details`; rituals still keyed by profile id. Apply migration after Docker is up (`supabase db reset`).

### 2026-06-08 — Realtime rebuild loop fix
- [x] Root cause: `watchSupabaseTables` inside autoDispose providers → `invalidateSelf` → dispose/resubscribe → initial snapshot → loop.
- [x] `realtime_sync_providers.dart` keepAlive listeners + `RealtimeInvalidationRegistry` + `attachRealtimeSync()` on all list/detail providers.
- [x] Skip first stream emission per subscription in `realtime_refresh.dart`.

### 2026-06-08 — Pilgrim table column visibility
- [x] Added travel permit, medical test, and hotel columns to operator/admin pilgrim registry table.
- [x] Column picker dialog (show/hide); preferences persisted in `SharedPreferences` across app restarts.
- [x] Server-side sort for `travel_permit`, `medical_test`, `hotel` columns.

### 2026-06-09 — Content server pagination + table cache
- [x] Content CMS server-side pagination (`fetchPage`, `adminContentListPageProvider`)
- [x] `StaffTableDefinitionCache` on all staff list screens (locale-aware column/filter caching)

### 2026-06-09 — Admin staff web hardening
- [x] PostgREST search sanitization (operators, groups, pilgrims)
- [x] Auth redirect deferred while session loading
- [x] Shared staff error/offline UX (`StaffErrorView`, connectivity banner)
- [x] Responsive table toolbar/pagination; performance tweaks (detail providers, select, keepAlive)
- [x] `connectivity_plus` dependency for offline detection

### 2026-06-09 — Pilgrims table selection + admin upsert
- [x] Optional row selection + bulk actions on `StaffDataTable`
- [x] Pilgrims filters (gender, group), admin add/edit, bulk group assign
- [x] Migration admin pilgrim profile update + operator group read

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

### 2026-06-18 — Guest notifications + UX fixes
- [x] Removed guest redirect on `/notifications` (shell/bottom nav preserved).
- [x] `public_announcements` table + broadcast mirror; guest inbox from public content + admin broadcasts.
- [x] Profile: single pilgrim login button; home topics carousel overflow fixed.

### 2026-06-09 — Content media storage, offline, native audio
- [x] Migration `20260610120000_content_media_storage.sql` — `content-media` bucket + RLS.
- [x] Admin upload (cover + media files) with live preview; `ContentMediaStorageService`.
- [x] Optional offline downloads (`ContentMediaCacheService`, background Dio); profile settings + per-topic actions.
- [x] `NativeAudioPlayer` on Android/iOS; cache-aware `EducationalMediaViewer` / resolved image URLs.
- [x] Removed unused `videos` from public feed; `content_library` query filters news/announcement only.
- [x] `ContentTopicsSectionSkeleton` on home while topics load.
- [x] `flutter analyze` clean.

### 2026-06-09 (continued)
- **Content topics:** `content_topics` + `content_topic_media` tables, shared `EducationalMediaViewer`, home «مواضيع تعليمية» carousel, topic detail with media series, admin CMS at `/admin/content/topics`, seed (فقه الحج, آداب المدينة).
- **Hajj journey restructure:** Services hub (`/services`), profile shows registry only, Duolingo-style ritual path (`/journey`), ritual detail with video/audio/image slideshow, admin CMS (`/admin/hajj-journey`), migration `20260609210000_hajj_journey_cms.sql` with Islamic demo content.

### 2026-06-09
- **Ordering questions:** `ordering` enum value, `submit_competition_ordering_answer` RPC, drag-reorder quiz UI + admin step editor, demo seed question.
- **Competition quizzes UI:** Duolingo-style learning path, responsive list/detail/quiz screens, segmented quiz progress, option cards, feedback banner, gradient headers.
- **Competition quizzes MVP:** `competition_questions` / options / attempts tables, `submit_competition_answer` RPC, admin question editor on competition edit, pilgrim `CompetitionQuizScreen`, demo seed questions.
- Replaced deprecated `dart:html` in `agent_debug_log_web.dart` with `package:web` fetch + `dart:js_interop`; added direct `web` dependency.

### 2026-05-19
- Added `dart_defines.local.json` / Android variant (gitignored) and example templates.
- Added Cursor/VS Code launch configs for local Supabase.

### 2026-05-18
- Initialized Memory Bank, packages, linting.
- Built full app shell: bootstrap, routing, theme, l10n, error handling.
