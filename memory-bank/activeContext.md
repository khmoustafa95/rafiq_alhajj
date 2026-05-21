# Active Context

> **Read this file at the start of every session.**

## Current focus
**US-07 shipped** — admin web analytics dashboard with live charts from Supabase.

## Recent changes (2026-05-21)
- Field operator pilgrim screen: `RadioListTile` group migrated to `RadioGroup` (Flutter 3.32+ radio API).
- Migration `20260521170000_admin_analytics.sql` (`groups` table, admin read policies).
- `admin_analytics` feature: KPI cards + bar/pie charts (`fl_chart`).
- `AppAccessMode.admin`, `signInAdmin`, routes `/admin/login` + `/admin/dashboard`.
- Web routing: operators → intake, admins → dashboard; link from operator login.

## Next steps
1. `supabase db reset` + demo admin/operator/pilgrim users.
2. Test Chrome: `/admin/login` → dashboard charts refresh from DB.
3. Product backlog beyond MVP user stories (content CMS, competitions, etc.).

## Key paths
| Concern | Location |
|---------|----------|
| Admin dashboard | `lib/features/admin_analytics/presentation/widgets/admin_dashboard_screen.dart` |
| Analytics repo | `lib/features/admin_analytics/data/repositories/admin_analytics_repository.dart` |
| Migration | `supabase/migrations/20260521170000_admin_analytics.sql` |

## Run (admin web)
```bash
supabase db reset
supabase auth users create admin@demo.local --password demo123456 --email-confirm --user-metadata "{\"role\":\"admin\",\"full_name\":\"خالد المسؤول\"}"
flutter run -d chrome --dart-define-from-file=dart_defines.local.json
```

Open `/admin/login` or use **Admin analytics sign in** from operator login page.  
Demo: `admin@demo.local` / `demo123456`
