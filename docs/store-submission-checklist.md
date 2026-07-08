# Store submission checklist (Google Play & App Store)

> Last updated: 2026-07-08

## Completed in codebase

- [x] Production bundle ID: `com.rafiqalhajj.app` (Android + iOS)
- [x] Branded launcher icons (`assets/icons/app_icon.png` + `flutter_launcher_icons`)
- [x] Privacy policy, terms, and account-deletion pages under `web/legal/`
- [x] In-app legal links (`LegalFooter` on login + profile)
- [x] Pilgrim account deletion (`Profile → Delete account` + edge fn `delete-my-account`)
- [x] Location permission rationale dialogs (tools + SOS)
- [x] SOS emergency disclaimer (not a substitute for national emergency services)
- [x] iOS `ITSAppUsesNonExemptEncryption = false`
- [x] Android release signing template (`android/key.properties.example`)
- [x] Production build scripts: `scripts/build-production-android.sh`, `scripts/build-production-ios.sh`

## Manual steps before upload

### Staging verification (recommended first)

1. `npm run staging:setup-db` — deploys `delete-my-account` edge function.
2. `npm run config:bootstrap` — adds legal URLs to `*.staging.json` if missing.
3. `npm run staging:build` (or push to `main` for CI deploy).
4. `npm run staging:verify-store` — checks legal sources + dart-define templates + `build/web/legal/*`.
5. Manual: legal links on login; **Profile → Delete account** on a disposable test pilgrim only.

### Both stores (production)

1. Copy `config/dart-defines/*.production.example.json` → `*.production.json` and fill secrets.
2. Set legal URLs to your hosted domain (e.g. `https://your-domain.web.app/legal/privacy.html`).
3. Register Firebase apps with package `com.rafiqalhajj.app` and add `google-services.json` / `GoogleService-Info.plist`.
4. Deploy `web/legal/*` with your web hosting (Firebase Hosting includes these static files).
5. Complete **Data Safety** (Play) and **App Privacy** (Apple) forms to match actual data collection.
6. Disable demo accounts on production Supabase Auth.
7. Smoke-test release build: login, SOS, push, offline content, account deletion.

### Google Play

1. Create upload keystore; copy `android/key.properties.example` → `android/key.properties`.
2. Run `scripts/build-production-android.sh`.
3. Upload `build/app/outputs/bundle/release/app-release.aab` to Play Console.
4. Provide privacy policy URL + account deletion URL (same as `ACCOUNT_DELETION_INFO_URL`).

### App Store

1. Set `DEVELOPMENT_TEAM` in Xcode; create App Store Connect app record.
2. Upload APNs auth key to Firebase for iOS push.
3. Run `scripts/build-production-ios.sh` (macOS) or archive via Xcode.
4. TestFlight: verify push, location, account deletion.

## dart-define keys (production)

| Key | Purpose |
|-----|---------|
| `PRIVACY_POLICY_URL` | Play + Apple privacy policy link |
| `TERMS_OF_SERVICE_URL` | Terms of service link |
| `ACCOUNT_DELETION_INFO_URL` | Play account deletion policy URL |
| `CRASH_REPORTING_ENABLED` | Set `false` until Crashlytics/Sentry is wired |
