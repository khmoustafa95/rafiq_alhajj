# Active Context

> **Read this file at the start of every session.**

## Current focus
**Admin group management** — CRUD for Hajj groups with leadership and administration members.

## Recent changes (2026-06-09, groups)
- **Migration** `20260609120000_admin_groups_management.sql`: `groups` extended (logo, president); `group_administration_members` table; `group-assets` storage bucket; admin CRUD RLS.
- **Flutter** `lib/features/admin_groups/`: list (`StaffDataTable`) + edit form (logo, president, dynamic member rows with photo upload).
- **Routes:** `/admin/groups`, `/admin/groups/new`, `/admin/groups/:id/edit`; sidebar **Groups** nav item.

## Next steps
1. Run `supabase db reset` or `db push` to apply group migration.
2. Hot restart web — test add/edit group with logo and members.
3. Optional: assign pilgrims to groups from admin pilgrim detail.

## Key paths
| Concern | Location |
|---------|----------|
| Group management UI | `lib/features/admin_groups/presentation/widgets/` |
| Migration | `supabase/migrations/20260609120000_admin_groups_management.sql` |
| Storage bucket | `group-assets` |
