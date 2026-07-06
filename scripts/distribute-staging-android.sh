#!/usr/bin/env bash
# Build staging APK and upload to Firebase App Distribution (Linux / CI).
set -euo pipefail
cd "$(dirname "$0")/.."

GROUPS="${FIREBASE_APP_DISTRIBUTION_GROUPS:-client-preview}"
NOTES="${FIREBASE_APP_DISTRIBUTION_NOTES:-}"

if [[ "${SKIP_BUILD:-}" != "1" ]]; then
  bash ./scripts/build-staging-android.sh
fi

APK="build/app/outputs/flutter-apk/app-release.apk"
if [[ ! -f "$APK" ]]; then
  echo "APK not found: $APK" >&2
  exit 1
fi

APP_ID="$(node ./scripts/read-firebase-android-app-id.mjs)"
if [[ -z "$NOTES" ]]; then
  VERSION="$(node ./scripts/read-pubspec-version.mjs)"
  NOTES="Rafiq Al-Hajj staging build v${VERSION}"
fi

firebase appdistribution:distribute "$APK" \
  --app "$APP_ID" \
  --project rafiq-alhajj \
  --groups "$GROUPS" \
  --release-notes "$NOTES"

if [[ "${SKIP_VERSION_SYNC:-}" != "1" ]]; then
  node ./scripts/update-android-version-policy.mjs || true
fi

echo "Firebase App Distribution upload complete."
