# Active Context

> **Read this file at the start of every session.**

## Current focus
**Admin system settings** — `/admin/settings` route with persisted global configuration.

## Recent changes (2026-06-09, settings)
- **Migration** `20260609140000_system_settings.sql`: `system_settings` table (single `global` row), admin update RLS, realtime.
- **Flutter** `lib/features/admin_settings/`: repository, service, providers, settings screen with sections (organization, operations, intake, features, notifications, shortcuts, integrations).
- **Routes:** `/admin/settings`; sidebar **Settings** nav item (last in admin menu).

## Next steps
1. Run `supabase db reset` or `db push` to apply `system_settings` migration.
2. Hot restart web — open **Settings**, edit and save.
3. Optional: enforce settings in operator intake, maintenance banner, feature toggles.

## Key paths
| Concern | Location |
|---------|----------|
| Settings UI | `lib/features/admin_settings/presentation/widgets/admin_settings_screen.dart` |
| Migration | `supabase/migrations/20260609140000_system_settings.sql` |
| Providers | `lib/features/admin_settings/presentation/providers/system_settings_providers.dart` |
