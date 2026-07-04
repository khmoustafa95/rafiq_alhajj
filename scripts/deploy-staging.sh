#!/usr/bin/env bash
# Build staging web and deploy to Firebase Hosting (site: rafiq-alhajj-staging).
#
# Prerequisites:
#   npm install -g firebase-tools
#   firebase login
#   firebase target:apply hosting staging rafiq-alhajj-staging
#
# Usage:
#   ./scripts/deploy-staging.sh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

"$ROOT_DIR/scripts/build-staging-web.sh" "${1:-}"

if ! command -v firebase >/dev/null 2>&1; then
  echo "firebase CLI not found. Install: npm install -g firebase-tools"
  exit 1
fi

echo "==> Deploying to Firebase Hosting (staging)"
firebase deploy --only hosting:staging --project rafiq-alhajj

echo ""
echo "Staging URL: https://rafiq-alhajj-staging.web.app"
