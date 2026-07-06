#!/usr/bin/env bash
# Build a release APK for the staging environment (android · staging).
set -euo pipefail
cd "$(dirname "$0")/.."

if [[ ! -f android/app/google-services.json ]]; then
  echo "Missing android/app/google-services.json" >&2
  exit 1
fi

DEFINES_FILE="${1:-}"
if [[ -z "$DEFINES_FILE" ]]; then
  DEFINES_FILE="$(node ./scripts/resolve-dart-defines.mjs android staging)"
fi

VERSION_NAME="$(node ./scripts/read-pubspec-version.mjs)"
BUILD_NUMBER="$(node ./scripts/read-pubspec-version.mjs --build-number)"

echo "==> Building Flutter Android APK (android.staging) v${VERSION_NAME}+${BUILD_NUMBER}"
flutter pub get
flutter build apk \
  --release \
  --build-name="$VERSION_NAME" \
  --build-number="$BUILD_NUMBER" \
  --dart-define-from-file="$DEFINES_FILE"

echo "APK ready: build/app/outputs/flutter-apk/app-release.apk"
