#!/usr/bin/env bash
# Build Flutter Web for the staging environment.
#
# Usage:
#   ./scripts/build-staging-web.sh
#   ./scripts/build-staging-web.sh path/to/dart_defines.staging.json
#
# CI passes secrets via STAGING_DART_DEFINES_JSON; local runs can use a file.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

DEFINES_FILE="${1:-}"
DEFINES_JSON="${STAGING_DART_DEFINES_JSON:-}"

if [[ -n "$DEFINES_JSON" ]]; then
  DEFINES_FILE="$(mktemp)"
  trap 'rm -f "$DEFINES_FILE"' EXIT
  printf '%s' "$DEFINES_JSON" >"$DEFINES_FILE"
elif [[ -z "$DEFINES_FILE" ]]; then
  if [[ -f "dart_defines.staging.json" ]]; then
    DEFINES_FILE="dart_defines.staging.json"
  elif [[ -f "dart_defines.staging.local.json" ]]; then
    DEFINES_FILE="dart_defines.staging.local.json"
  else
    echo "Missing staging dart-defines."
    echo "Create dart_defines.staging.local.json from dart_defines.staging.example.json"
    echo "or set STAGING_DART_DEFINES_JSON."
    exit 1
  fi
fi

if [[ ! -f "$DEFINES_FILE" ]]; then
  echo "Dart defines file not found: $DEFINES_FILE"
  exit 1
fi

echo "==> Building Flutter Web (staging) with $DEFINES_FILE"
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
echo "Build complete: $ROOT_DIR/build/web"
echo "Deploy with: firebase deploy --only hosting:staging"
