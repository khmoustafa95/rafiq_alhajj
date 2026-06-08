# Active Context

> **Read this file at the start of every session.**

## Current focus
**Pilgrims table enhancements** — selectable rows, bulk actions, filters, admin upsert.

## Recent changes (2026-06-09)
- **StaffDataTable** optional selection: checkboxes, select-all, bulk action bar (`selectable`, `rowKey`, `bulkActions`).
- **Pilgrims list:** gender + group filters, gender/group columns, admin Add pilgrim, bulk assign/clear group.
- **Pilgrim detail:** admin can edit full name, gender, group + logistics.
- **Migration** `20260609160000_admin_pilgrim_management.sql`: admin profile update RLS, operators read groups.
- **Router:** admin can access `/operator/intake` for pilgrim creation.

## Next steps
1. Apply migration: `supabase db reset` or `db push`.
2. Hot restart web — test pilgrim filters, selection, bulk assign, admin edit/create.
3. Optional: use selection on other tables (operators delete, etc.).

## Key paths
| Concern | Location |
|---------|----------|
| Table selection API | `lib/core/widgets/staff_data_table.dart` |
| Pilgrims list | `lib/features/operator_intake/presentation/widgets/operator_pilgrim_list_screen.dart` |
| Pilgrim detail (upsert) | `lib/features/operator_intake/presentation/widgets/operator_pilgrim_detail_screen.dart` |
| Registry repo | `lib/features/operator_intake/data/repositories/operator_registry_repository.dart` |
