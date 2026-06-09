# Active Context

> **Read this file at the start of every session.**

## Current focus
**Pilgrim registry table** — full column set + user-controlled column visibility persisted across sessions.

## Recent changes (2026-06-08)
- **Pilgrim table columns:** Added travel permit, medical test, and hotel columns; server-side sort for new columns in `operator_registry_repository`.
- **Column visibility:** `StaffTableColumnVisibilityStorage` + column picker dialog; `pilgrimTableColumnVisibilityProvider` persists hidden column ids via `SharedPreferences` (works on web and mobile).
- **UI:** "Columns" toolbar button on pilgrim list opens checkbox dialog; full name column always visible.

## Next steps
1. Hot restart — hide columns, close app, reopen — confirm preferences persist.
2. Optional: horizontal scroll if many columns visible on narrow viewports; reuse column visibility on other staff tables.

## Key paths
| Concern | Location |
|---------|----------|
| Column visibility | `lib/core/widgets/staff_table_column_visibility.dart` |
| Pilgrim prefs provider | `lib/features/operator_intake/presentation/providers/pilgrim_table_column_visibility_provider.dart` |
| Pilgrim list screen | `lib/features/operator_intake/presentation/widgets/operator_pilgrim_list_screen.dart` |
| Staff table | `lib/core/widgets/staff_data_table.dart` |
