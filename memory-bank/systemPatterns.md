# System Patterns

## Architecture: 4 layers, feature-first

Organize by **feature**, then by layer:

```
lib/
  features/
    <feature_name>/
      presentation/
        widgets/       # ONE public widget per file
        states/        # Freezed immutable states
        controllers/   # @riverpod Notifier / AsyncNotifier
      application/
        services/      # Use-cases, coordinates repos + UI
      domain/
        models/        # Pure business entities
      data/
        repositories/  # Abstract + concrete
        dtos/          # Serialization (json_serializable)
        data_sources/  # SupabaseClient calls
```

Shared cross-cutting code (if needed): `lib/core/` (routing, theme, l10n, errors) — **not created yet**.

## State management
- **Riverpod** with code generation: `@riverpod`, `Notifier`, `AsyncNotifier`.
- UI reads providers; controllers call application services.

## Routing
- **go_router** — declarative, typed routes (not integrated yet).

## Data flow
```
Widget → Controller → Service → Repository → DataSource → Supabase
                ↑                              ↓
              State                         DTO → Domain model
```

## Data layer pattern (implemented across ALL features, 2026-06-20)
- **`data_sources/<name>_remote_data_source.dart`** owns every `SupabaseClient` call (`.from`/`.rpc`/`.storage`/`.functions`/`.auth`). Holds a **non-null** `SupabaseClient`, `const` ctor, returns **raw** rows (`Map`/`List<Map>`/scalars), holds `select` column constants, has an `_asMaps` helper. No mapping, no DTOs, no try/catch here.
- **Repository** builds its data source in the constructor from the injected client — `Repo([SupabaseClient? client]) : _remote = client == null ? null : XRemoteDataSource(client);` — so **providers/DI are unchanged**. The repo keeps ALL DTO/row→domain mapping and ALL `try/catch`, and exposes `isAvailable => _remote != null`.
- Canonical reference: `lib/features/trips/data/`.

## Offline secure media (pilgrims, 2026-06-26)
- **Two storage buckets:** public `content-media` for `public` topics; private `content-media-private` for `pilgrim_only` (storage RLS: SELECT=admins or `profiles.role='pilgrim'`, write=admins). Private objects are referenced in the DB as a `private://<path>` sentinel; public ones keep full `https` URLs. No content-table schema change.
- **Resolver order** (`ContentMediaCacheService.resolvePlaybackUrl`): encrypted local copy (decrypt-to-temp) → signed URL for `private://` → plain URL. YouTube/Vimeo are never cached (skipped) and play via WebView; local-file/direct/signed MP4 play via `video_player`+`chewie`.
- **Encryption at rest:** `MediaEncryptionService` — 256-bit key in `flutter_secure_storage` (iOS device-bound), AES-CTR chunked via `keyStreamIndex` (1 MiB chunks). Encrypted blobs in `ApplicationSupport/content_media_enc/` (Android backup-excluded via `res/xml/*` rules); plaintext only briefly in `Temp/content_media_dec/`. Logout wipes both + rotates the key.
- **Downloads** route through `ContentMediaDownloadController`: per-media states + progress, Dio `CancelToken` pause, retry w/ backoff, Wi-Fi-only gate (`connectivity_plus`), quota (1 GiB default) + LRU eviction, Content-Type/size validation (rejects HTML/oversized).
- Admin uploads route to the bucket matching topic visibility (`uploadBytes(isPrivate:)`); `ensureBucketForRef` re-homes objects across buckets when visibility changes.

## Forms (implemented across all validation forms, 2026-06-20)
- Use **`reactive_forms`**: one `FormGroup` (built in `initState`, `dispose()`d), `ReactiveForm` wrapper, `ReactiveTextField` / `ReactiveDropdownField`, `Validators.*` + `validationMessages` mapping to l10n keys. Int fields use `IntValueAccessor()` + `FormControl<int>`. Submit: `if (!form.valid) { form.markAllAsTouched(); return; }`.
- Canonical reference: `lib/features/trips/presentation/widgets/trip_editor_dialog.dart`.
- Exceptions: plain search fields (list filters) and dynamic media-draft rows with file pickers may keep `TextEditingController` (not validation forms).

## Assets
- **`flutter_gen`** generates `lib/core/gen/assets.gen.dart`. NEVER hardcode asset path strings — use `Assets.*` (e.g. `Assets.virtualTour.images.kaaba.image(...)`). Declare asset dirs in `pubspec.yaml`; regenerate via `build_runner`.

## Error handling
- Wrap network/DB in `try/catch` **in the repository** (around data-source calls).
- Catch `PostgrestException` / `AuthException` (and `StorageException`/`FunctionException` where used) explicitly.

## UI rules
- **Colors:** use `AppColors` design tokens (the blessed source of truth, also wired into `ColorScheme`) or `Theme.of(context).colorScheme`. NEVER write raw `Color(0x…)` in widgets — add the value to `AppColors` first.
- Never hardcode strings — `AppLocalizations.of(context).key` (non-nullable; no `!`).
- Sizes via `flutter_screenutil` (`16.w`, `24.h`, `14.sp`).

## Code generation
- `freezed` + `json_serializable` for models/DTOs; `riverpod_generator`; `flutter_gen_runner` for assets.
- Run `dart run build_runner build` after schema/asset changes.

## Naming & files
- One **public** widget per file under `widgets/`.
- Private sub-widgets may live in the same file or sibling widget files.

## Pilgrim data model (post 2026-06-20 restructure)
- **`pilgrims`** = person identity (passport-keyed, unique partial index; optional `profile_id` for login). Person-stable fields only (names, passport, contact).
- **`trips`** = seasonal journey (`type` hajj/umrah, `season_year`, `status`). The "coalition" for a season.
- **`trip_groups`** = travel office (`groups`) participation in a trip; `status` active/withdrawn (join/withdraw per season).
- **`trip_enrollments`** = one pilgrim in one trip; holds ALL per-trip logistics (visa, sticker, hotels, flights, mashaer, field status). `unique(pilgrim_id, trip_id)`. A pilgrim may have many enrollments → many trips.
- **`ritual_logs`** keyed by `enrollment_id` (rituals are per-trip).
- **`pilgrim_enrollment_view`** (security_invoker) flattens person+enrollment+trip+group; all operator/admin reads go through it, scoped by `trip_id` (active trip). Writes hit `pilgrims` (identity) + `trip_enrollments` (logistics) keyed by `pilgrim_id`.
- **`operator_group_access`** = per-operator group grants (`can_write`). RLS helpers `operator_can_read_group()` / `operator_can_write_group()` gate `trip_enrollments` for operators; admins see all. New operators get all-group access via the `grant_operator_default_group_access` trigger; admins narrow it in the operator editor.
- **Migrations are final-form** (dev data is disposable): the whole domain is built by `20260521140000_pilgrim_rituals.sql` on top of `20260521121000_rls_helpers.sql` — there is **no** `pilgrim_details` table and no backfill migration. Arabic demo data lives in `supabase/seed.sql`.

## Current codebase reality
- Only `lib/main.dart` exists (Flutter default template).
- **No** feature folders, Riverpod, go_router, or Supabase yet.
- `main.dart` appears to have invalid syntax (`.fromSeed`, `.center`) — fix before first run.
