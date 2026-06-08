# Active Context

> **Read this file at the start of every session.**

## Current focus
**Content CMS server pagination + table definition caching** on staff list screens.

## Recent changes (2026-06-09)
- **Content CMS:** `fetchPage` in repository; `adminContentListPageProvider(query)` replaces client-side full-list pagination; `AdminContentDelete` notifier.
- **Performance:** `StaffTableDefinitionCache` caches columns/filters per locale on operators, groups, content, competitions, pilgrim list screens.

## Next steps
1. Hot restart web — test offline banner, table layout on narrow viewport, error retry flows.
2. Optional: server-side pagination for content CMS; column/filter caching on list screens.

## Key paths
| Concern | Location |
|---------|----------|
| Error UX | `lib/core/utils/staff_error_message.dart`, `lib/core/widgets/staff_error_view.dart` |
| Offline | `lib/core/network/staff_connectivity.dart`, `lib/core/widgets/staff_connectivity_banner.dart` |
| Search sanitize | `lib/core/utils/postgrest_search_sanitize.dart` |
| Staff table | `lib/core/widgets/staff_data_table.dart` |
