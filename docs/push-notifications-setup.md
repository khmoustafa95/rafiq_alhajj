# Push notifications (FCM) — Phase 3

Arabic summary is in [runbook-ar.md](./runbook-ar.md#push-fcm) (add anchor section).

## Overview

- Flutter registers FCM tokens in `device_tokens` after sign-in.
- On `notifications` INSERT, Postgres (`pg_net`) calls Edge Function `send-push-notification`.
- Edge Function sends FCM HTTP v1 via `firebase-admin` and `FIREBASE_SERVICE_ACCOUNT_JSON`.

## 1. Firebase project

1. Create a project in [Firebase Console](https://console.firebase.google.com/).
2. Add an **Android** app (`com.example.rafiq_alhajj` or your applicationId).
3. Add an **iOS** app (bundle id must match `FIREBASE_IOS_BUNDLE_ID`).
4. Download `google-services.json` → `android/app/google-services.json` (gitignored).
5. Enable the Gradle plugin (required for Android FCM build):
   - In `android/settings.gradle.kts` add:
     `id("com.google.gms.google-services") version "4.4.2" apply false`
   - In `android/app/build.gradle.kts` at the bottom add:
     `apply(plugin = "com.google.gms.google-services")`
6. Download `GoogleService-Info.plist` → `ios/Runner/GoogleService-Info.plist` (gitignored).
7. Enable **Cloud Messaging**; create a **Service account** key (JSON) for the Edge Function.

## 2. Dart defines (mobile)

Add to `dart_defines.local.json` / `dart_defines.android.local.json`:

```json
{
  "SUPABASE_URL": "http://127.0.0.1:54321",
  "SUPABASE_ANON_KEY": "...",
  "FIREBASE_PROJECT_ID": "your-project-id",
  "FIREBASE_API_KEY": "AIza...",
  "FIREBASE_APP_ID": "1:123456789:android:abcdef",
  "FIREBASE_MESSAGING_SENDER_ID": "123456789",
  "FIREBASE_IOS_BUNDLE_ID": "com.example.rafiqAlhajj"
}
```

Values come from Firebase project settings and `google-services.json`.

## 3. Supabase Edge Function secrets

Create `supabase/.env` (gitignored) or set secrets in hosted dashboard:

```env
FIREBASE_SERVICE_ACCOUNT_JSON={"type":"service_account",...}
PUSH_WEBHOOK_SECRET=dev-local-push-secret
```

Local:

```bash
supabase secrets set FIREBASE_SERVICE_ACCOUNT_JSON="$(cat path/to/service-account.json)"
supabase secrets set PUSH_WEBHOOK_SECRET=dev-local-push-secret
supabase functions serve send-push-notification
```

## 4. Database reset

```bash
supabase db reset
npm run setup
```

## 5. Test flow

1. Run app on **Android emulator/device** with Firebase dart-defines and `google-services.json`.
2. Sign in as `pilgrim@demo.local`.
3. From admin web: **Send notification** → all pilgrims.
4. Pilgrim device should receive a system notification; tap opens the target screen.

## 6. Production webhook (hosted)

The SQL trigger uses `pg_net` with `host.docker.internal` for local dev. On hosted Supabase, either:

- Set database settings: `app.supabase_functions_url` and `app.push_webhook_secret`, or
- Add a **Database Webhook** on `public.notifications` INSERT → `send-push-notification` with header `x-push-secret`.

## Troubleshooting

| Issue | Check |
|-------|--------|
| No token in DB | `AppConfig.hasFirebase`, signed-in user, Android 13+ notification permission |
| Edge returns `FCM not configured` | `FIREBASE_SERVICE_ACCOUNT_JSON` secret |
| Trigger never calls function | `pg_net` extension, Supabase functions URL reachable from DB container |
| Android build | `android/app/google-services.json` exists → Google Services plugin applied |
