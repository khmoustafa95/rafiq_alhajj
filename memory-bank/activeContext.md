# Active Context

> **Read this file at the start of every session.**

## Current focus
**`.cursorrules` architecture conformance** — the updated rules added: `data_sources/` layer (all `SupabaseClient` calls), `reactive_forms` for all forms, `flutter_gen` for assets (no hardcoded paths), and blessed `AppColors` as the color source of truth. A full audit + rollout was completed this session. Prior focus (pilgrim ↔ trips restructure) is done; see below.

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
1. **Manual RLS test:** create demo auth users (`supabase auth users create …` from `seed.sql` header), then verify an operator scoped to one group sees only that group's enrollments; admin sees all.
2. **Optional:** add `TripSelector` to the operator pilgrim list (field-operator already has it); operator reads are already trip-scoped via `activeTrip`.
3. **Obsolete:** `scripts/seed-fake-pilgrim-registry.mjs` / `npm run setup:users` still target `pilgrim_details` — Arabic data now lives in `seed.sql`; update or retire the script.

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
