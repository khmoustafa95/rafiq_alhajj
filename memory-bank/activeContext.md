# Active Context

> **Read this file at the start of every session.**

## Current focus
**Staff web data tables** — reusable sort/filter/pagination for all admin list pages.

## Recent changes (2026-06-08, tables)
- **`StaffDataTable<T>`** (`lib/core/widgets/staff_data_table.dart`): search, column sort, dropdown filters, pagination bar.
- **`StaffTableQuery` / `PaginatedResult`** + **`StaffTableProcessor`** for client-side paging (content, competitions).
- **Server-side pagination** (Supabase `range` + `count`) for operators and pilgrims repositories/providers.
- **List screens on web** now use the table: operators, pilgrims, content, competitions.
- **Operator edit form** layout tightened (active toggle card, inline password generate, 2-col permissions).

## Next steps
1. Hot restart web — verify table sort/filter/pagination on all staff list pages.
2. Deploy `manage-operator` edge function if not done (create/edit operators).
3. Optional: enforce `operator_permissions` on operator routes.

## Key paths
| Concern | Location |
|---------|----------|
| Reusable table | `lib/core/widgets/staff_data_table.dart` |
| Table query model | `lib/core/models/staff_table_query.dart` |
| Client paging helper | `lib/core/utils/staff_table_processor.dart` |
