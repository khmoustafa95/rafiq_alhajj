# Push notifications (FCM) — Phase 3

Arabic summary is in [runbook-ar.md](./runbook-ar.md#push-fcm) (add anchor section).

## Overview

- Flutter registers FCM tokens in `device_tokens` after sign-in.
- On `notifications` INSERT, Postgres (`pg_net`) calls Edge Function `send-push-notification`.
- The Edge Function sends **FCM HTTP v1 via `fetch`** — it mints an OAuth2 access
  token from `FIREBASE_SERVICE_ACCOUNT_JSON` using **Web Crypto** (RS256-signed
  JWT). It does **not** use `firebase-admin`: that library's `node:http2`
  transport is unsupported on the Supabase Edge (Deno) runtime and crashes with
  `ERR_NOT_IMPLEMENTED`.
- The function also **cleans up dead tokens**: any token FCM reports as `404` /
  `UNREGISTERED` is deleted from `device_tokens` (response includes `cleaned`).

## Notification display behavior

- **Background / terminated:** the OS shows the FCM `notification` payload in the
  system tray. Look-and-feel comes from the manifest defaults
  (`default_notification_channel_id` = `high_importance_channel`,
  `default_notification_icon` = `@drawable/ic_stat_notification`,
  `default_notification_color` = `@color/notification_color`).
- **Foreground (Android):** `PushNotificationService` listens to
  `FirebaseMessaging.onMessage` and renders a heads-up notification via
  `flutter_local_notifications` (channel created in `LocalNotificationsService`,
  id must match the manifest default). Tapping routes via `navigateFromPushData`.
- **Foreground (iOS):** shown by the OS via
  `setForegroundNotificationPresentationOptions(alert/badge/sound)`.
- **Fallback:** on web / when Firebase isn't configured, the in-app `SnackBar`
  (`NotificationToastHost`) covers the foreground case via Supabase Realtime.
- Requires Android Gradle **core library desugaring**
  (`desugar_jdk_libs`, enabled in `android/app/build.gradle.kts`).

## 1. Firebase project

1. Create a project in [Firebase Console](https://console.firebase.google.com/).
2. Add an **Android** app (`com.example.rafiq_alhajj` or your applicationId).
3. Add an **iOS** app (bundle id must match `FIREBASE_IOS_BUNDLE_ID`).
4. Download `google-services.json` → `android/app/google-services.json` (gitignored).
5. Enable the Gradle plugin (required for Android FCM build):
   - In `android/settings.gradle.kts` add:
     `id("com.google.gms.google-services") version "4.4.2" apply false`
   - In `android/app/build.gradle.kts` add `id("com.google.gms.google-services")`
     to the `plugins { }` block (already applied in this repo).
6. Download `GoogleService-Info.plist` → `ios/Runner/GoogleService-Info.plist` (gitignored).
7. Enable **Cloud Messaging**; upload an **APNs key** in Firebase Console.
8. iOS push entitlements are in `ios/Runner/RunnerDebug.entitlements` (development,
   used for Debug/Profile) and `ios/Runner/RunnerRelease.entitlements` (production,
   used for Release/App Store). Enable the **Push Notifications** capability in
   Xcode if codesign complains.
9. Create a **Service account** key (JSON) for the Edge Function.

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
   - **App open (foreground):** a heads-up notification appears via
     `flutter_local_notifications`.
   - **App backgrounded / killed:** the OS shows the FCM tray notification.

> Local runtime: `supabase start` does **not** load `supabase/.env` into the edge
> runtime. Run `supabase functions serve --env-file ./supabase/.env` (kept
> running) so pushes dispatch. `verify_jwt=false` is required for this function
> (the trigger calls it with `x-push-secret`, not a JWT).

## 6. Production webhook (hosted)

The SQL trigger uses `pg_net` with `host.docker.internal` for local dev. On hosted Supabase, either:

- Set database settings: `app.supabase_functions_url` and `app.push_webhook_secret`, or
- Add a **Database Webhook** on `public.notifications` INSERT → `send-push-notification` with header `x-push-secret`.

## Troubleshooting

| Issue | Check |
|-------|--------|
| No token in DB | `AppConfig.hasFirebase`, signed-in user, Android 13+ notification permission |
| Edge returns `FCM not configured` | `FIREBASE_SERVICE_ACCOUNT_JSON` secret |
| Edge returns `PUSH_WEBHOOK_SECRET not configured` | Set `PUSH_WEBHOOK_SECRET` in Supabase secrets / `supabase/.env` |
| Edge returns `Invalid push secret` | `PUSH_WEBHOOK_SECRET` must match DB trigger `x-push-secret` |
| Trigger never calls function | `pg_net` extension, Supabase functions URL reachable from DB container |
| Android build | `android/app/google-services.json` exists → Google Services plugin applied |
