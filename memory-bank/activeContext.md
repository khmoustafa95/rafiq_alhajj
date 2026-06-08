# Active Context

> **Read this file at the start of every session.**

## Current focus
**Admin operator management** — CRUD for center technicians with roles/permissions.

## Recent changes (2026-06-08, operators)
- **Migration** `20260608160000_admin_operator_management.sql`: `profiles.email`, `is_active`, `operator_permissions` (jsonb); admin update policy for operators; `handle_new_user` sets email + default perms.
- **Edge function** `manage-operator`: admin-only create/update (auth user + profile).
- **Flutter** `lib/features/admin_operators/`: list + edit screens, Riverpod providers, repository/service.
- **Routes:** `/admin/operators`, `/admin/operators/new`, `/admin/operators/:id/edit`; sidebar nav **Operators** for admins.

## Recent changes (2026-06-08, staff web)
- **Router:** Admins can access `/operator/pilgrims` (`_isAdminStaffWebRoute`).
- **Staff web:** responsive grids, web-safe metrics, realtime debounce, dashboard loading fix.

## Next steps
1. Apply migration + deploy `manage-operator` edge function to local/remote Supabase.
2. Hot restart web — open **Operators** from admin sidebar; create/edit an operator.
3. Optional: enforce `operator_permissions` on operator routes (intake, pilgrims, field tools).

## Key paths
| Concern | Location |
|---------|----------|
| Operator management UI | `lib/features/admin_operators/presentation/widgets/` |
| Edge function | `supabase/functions/manage-operator/` |
| Migration | `supabase/migrations/20260608160000_admin_operator_management.sql` |
| Routes | `lib/core/routing/app_routes.dart` |
