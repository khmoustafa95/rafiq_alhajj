# Dart environment configuration

Enterprise pattern: **one self-contained JSON file per platform × environment**.

## Layout

```text

config/dart-defines/
  {platform}.{environment}.example.json   ← committed templates
  {platform}.{environment}.json           ← your secrets (gitignored)
```

| Platform | File suffix | Typical `SUPABASE_URL` |
| --- | --- | --- |
| `web` | `.local` / `.staging` / `.production` | `127.0.0.1` (local) or `https://*.supabase.co` |
| `android` | emulator + cloud envs | `http://10.0.2.2:55321` (Android emulator → host Docker) |
| `android-device` | physical phone + local only | `http://<PC-LAN-IP>:55321` (from `ipconfig`) |
| `ios` | future native runs | `127.0.0.1` or cloud |

## Matrix (this project)

| Scenario | Secret file | VS Code launch |
| --- | --- | --- |
| Web · local Supabase | `web.local.json` | `Web · Local` |
| Web · staging | `web.staging.json` | `Web · Staging` |
| Android emulator · local | `android.local.json` | `Android Emulator · Local` |
| Android phone · local | `android-device.local.json` | `Android Device · Local` |
| Android · staging | `android.staging.json` | `Android · Staging` |
| Web · production | `web.production.json` | `Web · Production` |
| Android · production | `android.production.json` | — (release build) |

## First-time setup

```powershell
npm run config:bootstrap
```

This copies templates → secret files (only when missing) and migrates legacy root files such as `dart_defines.staging.local.json`.

Then edit each `config/dart-defines/*.json` with real keys from `supabase status` and Firebase Console.

## Run commands

```powershell
npm run dev:web              # Chrome + local Supabase
npm run dev:android          # Emulator + local Supabase
npm run dev:android:device   # Physical device + local Supabase
npm run dev:web:staging      # Chrome + staging Supabase
npm run dev:android:staging  # Device/emulator + staging Supabase
```

Resolve path manually:

```powershell
node scripts/resolve-dart-defines.mjs web local
```

## CI / build scripts

All build scripts call `resolve-dart-defines.mjs` — no merging of partial files.

| Script | Resolves |
| --- | --- |
| `staging:build` | `web.staging` |
| `staging:build-apk` | `android.staging` |
| `staging:distribute-android` | `android.staging` |

## Rules (reuse in future projects)

1. **Never commit** `config/dart-defines/*.json` (only `*.example.json`).
2. **Never split** one scenario across multiple files (no web+android merge).
3. **Platform-specific Firebase keys**: web uses `FIREBASE_WEB_APP_ID`; mobile uses `FIREBASE_APP_ID`.
4. **Add `APP_ENV`** in every file for logging and feature flags.
5. **Legacy root files** (`dart_defines*.local.json`) are deprecated; resolver falls back until you run bootstrap.

See also: [docs/environments-workflow-ar.md](../../docs/environments-workflow-ar.md), [docs/runbook-ar.md](../../docs/runbook-ar.md), [docs/staging-setup-ar.md](../../docs/staging-setup-ar.md).
