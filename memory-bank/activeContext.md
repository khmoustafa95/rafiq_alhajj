# Active Context

> **Read this file at the start of every session.**

## Current focus
**Staff web shell routing fix** — blank content pane + overlay hit-test errors on `/operator/intake`.

## Recent changes (2026-06-08)
- **Routing fix:** Replaced `StatefulShellRoute.indexedStack` (single branch, many sibling routes) with **`ShellRoute`** + `child` for staff web — matches how `context.go()` navigates between operator/admin pages.
- **`StaffWebShell`:** Uses `child` again; wraps content in `Material` for proper overlay ancestor.
- **`StaffWebPage`:** Root `SizedBox.expand` + bounded `LayoutBuilder` so pages fill the shell viewport.

## Next steps
1. **Hot restart** web app (not hot reload) — verify `/operator/intake` shows form, no console spam.
2. Test `/operator/pilgrims`, `/admin/dashboard` at wide + narrow widths.
3. Field operator Android unchanged (mobile shell).

## Key paths
| Concern | Location |
|---------|----------|
| Staff shell route | `lib/core/routing/app_router.dart` → `_staffWebShellRoute()` |
| Web layout primitives | `lib/core/widgets/staff_web_layout.dart` |
| Staff shell (sidebar/drawer) | `lib/core/widgets/staff_web_shell.dart` |
| Pilgrim registration | `lib/features/operator_intake/presentation/widgets/operator_intake_screen.dart` |
