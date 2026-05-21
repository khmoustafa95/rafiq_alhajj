# Progress

> **Update this file after every completed task.**

## Status summary
| Area | Status |
|------|--------|
| App shell (main, bootstrap, errors) | ✅ Done |
| Riverpod | ✅ `ProviderScope` + `@riverpod` router |
| go_router | ✅ Home + 404 |
| Theme (light/dark) | ✅ `AppTheme` |
| l10n (en/ar) | ✅ ARB + codegen |
| ScreenUtil | ✅ In `AppRoot` |
| Supabase init | ✅ Local dart-define files + launch configs |
| Feature modules | ✅ Home + auth + public content (US-01/03) |
| Public content (US-01) | ✅ Videos, news, detail, RLS |
| Islamic tools (US-02) | ✅ Prayer, Qibla, Quran, Adhkar (offline) |
| Pilgrim dashboard (US-04) | ✅ Rituals + logistics, offline sync |
| Operator intake (US-05) | ✅ Web login, form, storage, create-pilgrim |
| Field operator (US-06) | ✅ Mobile search, status updates, share copy |
| Admin analytics (US-07) | ✅ Web dashboard, charts, groups, live Supabase |
| Auth (US-03) | ✅ Login, pilgrim session, guest/pilgrim home |
| Supabase migrations | ✅ profiles + RLS (local) |

## Completed
- [x] Memory Bank + linting + dependencies
- [x] l10n configuration (en/ar)
- [x] `main.dart` with `runZonedGuarded` + bootstrap error UI + retry
- [x] `AppBootstrap` (Flutter/Platform errors, optional Supabase)
- [x] `AppRoot` — Riverpod, ScreenUtil, themes, l10n, `MaterialApp.router`
- [x] `appRouter` provider (go_router)
- [x] `HomeScreen`, `RouteNotFoundScreen`, `BootstrapFailureApp`
- [x] Widget test for `AppRoot`
- [x] Local Supabase dart-define JSON + `.vscode/launch.json`

## Backlog
- [x] Auth feature (US-03 pilgrim login)
- [x] US-01 public content (videos, news on home)
- [x] US-02 Islamic tools (offline prayer, qibla, quran, adhkar)
- [x] US-04 pilgrim rituals + logistics dashboard
- [x] US-05 operator web intake (pilgrim registration + documents + credentials)
- [x] US-06 field operator mobile (search pilgrims, update field status)
- [x] US-07 admin analytics web (charts, pilgrim/group/operator metrics)
- [ ] Crash reporting hook in bootstrap

## Changelog

### 2026-05-21
- Added `docs/runbook-ar.md` (Arabic ops guide: Supabase, demo users, launch configs, routes per role).
- Fixed deprecated `RadioListTile.onChanged` / `groupValue` in field operator pilgrim screen via `RadioGroup`.
- **US-07:** Admin web `/admin/dashboard`, `groups` table, `fl_chart` analytics (pilgrims by group, field status, operator uploads, ritual %).
- **US-06:** Field operator mobile `/operator/field`, pilgrim search, `field_status` updates, clipboard share summary.
- **US-05:** Operator web `/operator/login` + `/operator/intake`, `create-pilgrim` edge function, `pilgrim-documents` storage, staff sign-in.
- **US-04:** Pilgrim dashboard `/pilgrim`, ritual checklist with offline cache + Supabase sync, logistics card.
- **US-02:** Islamic tools hub, prayer times (adhan + GPS cache), Qibla compass, offline Quran, adhkar.
- **US-01:** `content_library` table, public feed on home, content detail route, seed data.
- **US-03:** Pilgrim login (`/login`), Supabase Auth, `profiles.role`, guest vs pilgrim home UI, migration + seed docs.
- Created Notion page **Rafiq Al-Hajj — Flutter Dev Status (Cursor sync)** under project workspace (team-visible snapshot of memory-bank).

### 2026-05-19
- Added `dart_defines.local.json` / Android variant (gitignored) and example templates.
- Added Cursor/VS Code launch configs for local Supabase.

### 2026-05-18
- Initialized Memory Bank, packages, linting.
- Built full app shell: bootstrap, routing, theme, l10n, error handling.
