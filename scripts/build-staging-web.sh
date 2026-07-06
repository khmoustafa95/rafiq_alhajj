#!/usr/bin/env bash
# Build Flutter Web for the staging environment (web · staging).
set -euo pipefail
cd "$(dirname "$0")/.."

DEFINES_FILE="${1:-}"
DEFINES_JSON="${STAGING_DART_DEFINES_JSON:-}"

if [[ -n "$DEFINES_JSON" ]]; then
  DEFINES_FILE="$(mktemp)"
  trap 'rm -f "$DEFINES_FILE"' EXIT
  printf '%s' "$DEFINES_JSON" >"$DEFINES_FILE"
elif [[ -z "$DEFINES_FILE" ]]; then
  DEFINES_FILE="$(node ./scripts/resolve-dart-defines.mjs web staging)"
fi

if [[ ! -f "$DEFINES_FILE" ]]; then
  echo "Dart defines file not found: $DEFINES_FILE"
  exit 1
fi

echo "==> Building Flutter Web (web.staging) with $DEFINES_FILE"
flutter pub get
flutter build web \
  --release \
  --dart-define-from-file="$DEFINES_FILE" \
  --base-href="/"

if command -v node >/dev/null 2>&1; then
  echo "==> Syncing Firebase service worker from dart-defines (if configured)"
  node ./scripts/patch-firebase-sw.mjs "$DEFINES_FILE" ./build/web/firebase-messaging-sw.js
fi

echo ""
echo "Build complete: build/web"
