# Active Context

> **Read this file at the start of every session.**

## Current focus
**Admin pilgrim workflow overhaul** — completed this session (see below). Prior focus (`.cursorrules` conformance, pilgrim ↔ trips restructure) is done.

## Recent changes (2026-06-21) — admin pilgrim UX overhaul
- **Login language control shrunk:** `staff_web_login_scaffold` + shared `RafiqAppBar` now use `LanguageSwitcherAppBarAction(compact: true)` (icon-only); login lock icon `56.sp → 44.sp`.
- **Dev leakage removed:** `US-05/06/07` codes stripped from `operatorLoginSubtitle` / `fieldOperatorLoginSubtitle` / `adminLoginSubtitle` (both ARBs).
- **Full pilgrim field set (single source of truth):** new `pilgrim_field_catalog.dart` (`presentation/forms/`) defines every `pilgrims`/`trip_enrollments` column as a grouped `PilgrimField` (table + kind + l10n label) and builds the `FormGroup`, payloads, bind, and shared-values helpers. Reused by the intake form **and** edit form via the new `PilgrimFieldsForm` widget. Models `OperatorPilgrimRecord`/`Summary` are now **raw-row-backed** (getters), `PilgrimIntakeForm`/`OperatorPilgrimUpdate` carry `person`/`enrollment` maps. View select switched to `*`; new sortable ids. Edge `create-pilgrim` now accepts `person`/`enrollment` objects with **server-side column allowlists**.
- **Reliable creation (partial success):** `OperatorIntakeController.submit` creates the account first; document upload is a **best-effort** follow-up — failures set `lastUploadError` (warning snackbar) instead of discarding a created pilgrim.
- **Expanded table:** added `cluster / sticker / makkah_hotel / phone / whatsapp` columns + picker options + sortable ids (defaults still readable).
- **Shared defaults (fast entry):** `pilgrim_shared_defaults_provider` (keepAlive + `SharedPreferences`) persists shared logistics; auto-applied on load, re-applied after each create, cleared via the "Shared defaults" card (with `TripSelector`).
- **Safer uploads:** storage + `create-pilgrim` invoke moved to `pilgrim_intake_remote_data_source` (conforms to `data_sources/`); added 10 MB size cap, MIME/extension allowlist, filename sanitization, per-file resilience (private `pilgrim-documents` bucket unchanged).
- **WhatsApp "send login info":** new operator/admin-gated edge fn `reset-pilgrim-password` (resets password, returns email+new password). Table row action: confirm → reset → open `wa.me/<digits>?text=<localized credentials>` (`url_launcher`). Shown only when the pilgrim has a login + WhatsApp number.
- **Audits:** notifications system reviewed — FCM lifecycle (bind on login / unregister+deleteToken on sign-out / refresh), RLS-scoped reads/updates, realtime dedup, navigation all sound; **no fixes needed**. Code review: no `SupabaseClient` calls remain in `application`/`presentation` layers.
- **Verified:** `flutter analyze` → No issues found; `build_runner` + `gen-l10n` clean.
- **Action needed:** local Supabase **edge runtime must reload** to serve the new `reset-pilgrim-password` function (restart `supabase` / edge runtime). No migration/schema changes were made (schema already had all columns), so no `db reset` required.

## Recent changes (2026-06-21) — demo-user seeder fix (admin login)
- **Root cause of failed `admin@demo.local` login:** `scripts/seed-demo-users.mjs` imported `seedFakePilgrimRegistry`, which upserts into the **dropped `pilgrim_details` table** → the seeder threw *after* creating users; and its `updateUser` path only patched `user_metadata` (never re-set the password or `email_confirm`), so re-runs reported "Updated" without ever fixing credentials.
- **Fix:** removed the obsolete fake-registry import/call from the seeder (Arabic pilgrim data now comes from `seed.sql`); `updateUser` now also sends `password` + `email_confirm: true`, making the seeder idempotent/self-healing.
- **Verified:** `npm run setup:users` exits 0 for all 14 demo accounts; password-grant auth test → `LOGIN OK, role: admin, confirmed_at set`.

## Recent changes (2026-06-20) — `.cursorrules` conformance audit + rollout
- **`.cursorrules` updated:** blessed `AppColors` design tokens (wired into `ColorScheme`) as the color source of truth + banned raw `Color(0x…)` in widgets; fixed the outdated `AppLocalizations.of(context)!` example (generated lookup is non-nullable).
- **Dependencies:** added `reactive_forms` + `flutter_gen_runner` (dev); **removed unused `google_fonts`** (app uses the bundled system text theme).
- **Assets via `flutter_gen`:** config in `pubspec.yaml` (`flutter_gen: output: lib/core/gen/`), declared the missing `assets/virtual_tour/images/` + `pannellum/` dirs, generated `lib/core/gen/assets.gen.dart`, replaced both hardcoded asset strings with `Assets.virtualTour.images.*`.
- **`data_sources/` layer — full rollout (all repos):** every direct `SupabaseClient` call (`.from`/`.rpc`/`.storage`/`.functions`/`.auth`) now lives in `data/data_sources/<name>_remote_data_source.dart` (non-null client, `const` ctor, raw rows, `select` column constants, `_asMaps` helper). Repositories build the data source from the injected client (**same ctor signature → no provider changes**), keep all domain/DTO mapping + `try/catch` (`PostgrestException`/`AuthException`/`StorageException`/`FunctionException`). Canonical reference: `trips`. Covered: trips, system_settings, device_token, content (×2), admin_content (×2), notifications, auth, pilgrim (×2), admin_operators (manage-operator fn + group_access), admin_analytics, admin_groups (storage upload), operator_intake, competitions (×4, incl. RPC scoring), hajj_journey (×2). Verified: **no repository references `_client`/`.from('`/`.rpc(`/`Supabase.instance` anymore.**
- **`reactive_forms` — full rollout (all real forms):** `FormGroup` + `ReactiveForm`/`ReactiveTextField`/`ReactiveDropdownField` + `Validators` + `validationMessages` (same l10n keys). Canonical reference: `trip_editor_dialog`. Migrated: 4 login screens, admin content/topic/hajj-journey/competition/group/operator editors, operator intake + pilgrim detail, notification broadcast, admin settings, competition question editor, field-operator pilgrim. **No `TextFormField`/`GlobalKey<FormState>` remain.**
- **Verified:** `flutter analyze` → **No issues found**; `dart run build_runner build` clean.
- **Known residual `TextEditingController` (intentional, not validation forms):** search fields in `staff_data_table.dart` + `field_operator_pilgrims_screen.dart`; dynamic media-draft rows (`_MediaDraft`) with file pickers in `admin_content_topic_edit_screen.dart` + `admin_hajj_journey_edit_screen.dart` (would need `FormArray` refactor — left to preserve upload/preview behavior).

## Recent changes (2026-06-20) — phase 2 + final-form migrations
- **Migrations simplified to final form (no `pilgrim_details`, no backfill):** the legacy `pilgrim_details` table + the restructure/backfill migration were removed. `20260521140000_pilgrim_rituals.sql` is now the single pilgrim-domain foundation: it creates `groups`, `operator_group_access`, `trips`, `trip_groups`, `pilgrims`, `trip_enrollments`, and per-enrollment `ritual_logs`, plus RLS, the `pilgrim_enrollment_view`, and triggers (auto-create pilgrim + auto-enroll into the active trip; default operator group grants).
- **New helpers migration** `20260521121000_rls_helpers.sql` (`is_admin`, `is_operator_or_admin`) so all later policies reuse them; deleted `20260606100000_fix_profiles_rls_recursion.sql` and `20260608120000_pilgrim_registry_extended.sql` (folded in). `operator_intake`/`field_operator`/`admin_analytics`/`admin_pilgrim_management`/`enable_realtime` rewritten to target the new tables.
- **Operator → group permissions:** `operator_group_access(operator_id, group_id, can_write)` + `operator_can_read_group()` / `operator_can_write_group()`. `trip_enrollments` read/write RLS is group-scoped for operators (admins = all). Admin operator editor has a **Group access** section (read / read+write per group); `AdminOperatorsRepository` loads + replaces grants (`_setGroupAccess`). New operators default to all groups (DB trigger), admin can narrow.
- **Phase-2 reads/writes on new tables:** `operator_registry_repository` reads `pilgrim_enrollment_view` and is **keyed by `pilgrimId`** (route `/operator/pilgrims/:pilgrimId`); writes to `pilgrims` + `trip_enrollments`. `admin_analytics_repository` reads `pilgrims`/`trip_enrollments`/`ritual_logs`. `create-pilgrim` edge fn updates `pilgrims` + the active-trip `trip_enrollment`. Rituals are per `enrollment_id` (`pilgrim_remote_repository` + `pilgrim_dashboard_service` resolve the active enrollment). `realtime_tables.dart` updated.
- **Arabic seed:** `supabase/seed.sql` rewritten — 3 offices (with presidents), 2 trips (Hajj active / Umrah planning), 8 Arabic pilgrims, 10 enrollments (2 also in Umrah), trip_groups, Arabic content + competitions.
- **Verified:** `supabase db reset` runs clean; counts = 2 trips / 3 groups / 8 pilgrims / 10 enrollments; `flutter analyze` clean; `build_runner` + `gen-l10n` regenerated.

## Next steps
1. **Manual RLS test:** demo auth users now seed cleanly via `npm run setup:users` (incl. `admin@demo.local` / `demo123456`). Verify an operator scoped to one group sees only that group's enrollments; admin sees all.
2. **Optional:** add `TripSelector` to the operator pilgrim list (field-operator already has it); operator reads are already trip-scoped via `activeTrip`.
3. **Obsolete:** `scripts/seed-fake-pilgrim-registry.mjs` (+ `npm run setup:registry`) still target the dropped `pilgrim_details` table and are no longer wired into `setup:users`; retire them.

## Key paths
| Concern | Location |
|---------|----------|
| Pilgrim-domain foundation | `supabase/migrations/20260521140000_pilgrim_rituals.sql` |
| RLS helpers | `supabase/migrations/20260521121000_rls_helpers.sql` |
| Operator group access (model/UI) | `lib/features/admin_operators/**` (`operator_group_grant.dart`, edit screen) |
| Arabic seed | `supabase/seed.sql` |
| Operator registry (view reads, pilgrimId-keyed) | `lib/features/operator_intake/data/repositories/operator_registry_repository.dart` |
| Rituals per enrollment | `lib/features/pilgrim/data/repositories/pilgrim_remote_repository.dart` |
| Trips feature | `lib/features/trips/**` |
