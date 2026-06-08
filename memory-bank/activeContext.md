# Active Context

> **Read this file at the start of every session.**

## Current focus
**Field operator shell (US-06)** — bottom nav: Home (dashboard stats) + Pilgrims (search/list); tap stat cards to filter list tab.

## Recent changes (2026-06-08)
- Migration `20260608120000_pilgrim_registry_extended.sql` — all registry columns on `pilgrim_details`.
- `Pilgrim` freezed model + `PilgrimDto` + `PilgrimRegistryRepository` (shared read/update).
- Field operator home: stats cards, status filter chips, enhanced search, `PilgrimListTile`.
- Field operator detail: header card + status edit + `PilgrimProfileSections` (grouped expandable profile).
- Pilgrim dashboard: full registration profile via `PilgrimProfileSections`.
- `seed.sql` demo pilgrim updated with sample extended registry data.

## Next steps
1. Apply migration: `supabase db reset` (or `supabase migration up`) + `npm run setup`.
2. Sign in as `operator@demo.local` → `/operator/field` — verify stats, search, profile sections.
3. Sign in as pilgrim → dashboard shows full registry profile.

## Key paths
| Concern | Location |
|---------|----------|
| Pilgrim model | `lib/features/pilgrim/domain/models/pilgrim.dart` |
| Registry repo | `lib/features/pilgrim/data/repositories/pilgrim_registry_repository.dart` |
| Field operator home | `lib/features/field_operator/presentation/widgets/field_operator_home_screen.dart` |
| Profile UI | `lib/features/pilgrim/presentation/widgets/pilgrim_profile_sections.dart` |
| Migration | `supabase/migrations/20260608120000_pilgrim_registry_extended.sql` |
