# Staging smoke checklist

Run after each release candidate on **https://rafiq-alhajj-staging.web.app** (web) and a staging APK (Android).

Prerequisites:

- Migrations applied: `npm run staging:setup-db`
- Demo users seeded: `npm run staging:seed-users`
- Dart-defines filled for staging (see `docs/staging-setup-ar.md`)

Demo accounts (password `demo123456`):

| Role | Email |
| --- | --- |
| Admin | `admin@demo.local` |
| Operator | `operator@demo.local` |
| Pilgrim | `pilgrim@demo.local` |
| Field operator | `field@demo.local` |

---

## Admin

- [ ] Login → `/admin/dashboard` loads without infinite spinner
- [ ] Trip selector scopes KPIs (enrolled, SOS, unassigned)
- [ ] Urgent banner links: active SOS → `/admin/sos`; push failures → `/admin/notifications/failures`
- [ ] Pilgrim list: search, sort, column picker, import/export template
- [ ] Content: Announcements / News / Library tabs; cover upload; notify pilgrims toggle
- [ ] Competitions: paginated table; create quiz; pilgrim can play
- [ ] App versions: policies visible; store URLs set before raising `min_version`
- [ ] Push delivery log: failed rows visible; Retry works

## Operator (web)

- [ ] Group-scoped RLS: operator sees only assigned group pilgrims
- [ ] Single edit + bulk edit; notify only when logistics fields change
- [ ] Excel import: preview create/update/error → confirm → result counts
- [ ] Export → re-import round-trip (passport upsert)

## Field operator (mobile)

- [ ] Dashboard stats match filtered pilgrim list
- [ ] Dark mode: readable text on all screens (dashboard, list, detail, shell)
- [ ] SOS tab → monitor map; live or manual refresh

## Pilgrim (mobile + web)

- [ ] Home: Announcements → News → Educational Library → Continue learning
- [ ] Offline banner when disconnected; cached feed still readable
- [ ] Topic download → airplane mode → video/audio/PDF plays locally
- [ ] Wi-Fi-only download setting respected
- [ ] Competitions quiz: join + answer + progress saved
- [ ] Hajj journey steps load offline after first visit
- [ ] SOS raise → staff notified; cancel returns to idle
- [ ] Notifications: inbox, filter, tap routes correctly; badge clears on open

## Push (device)

- [ ] Android: sign in → token in `device_tokens`; broadcast → tray + inbox
- [ ] Quiet hours: non-urgent suppressed (configure in profile prefs)
- [ ] Web: FCM SW configured; background notification + click focuses app

## App version

- [ ] Optional update dialog dismisses per version
- [ ] Force update blocks app when `current < min_version`

---

## Sign-off

| Build | Date | Tester | Pass |
| --- | --- | --- | --- |
| | | | |
