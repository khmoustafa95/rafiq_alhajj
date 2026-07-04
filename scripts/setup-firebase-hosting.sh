#!/usr/bin/env bash
# One-time Firebase Hosting setup for the staging site.
#
# Creates hosting site rafiq-alhajj-staging and binds the "staging" deploy target.
#
# Usage:
#   ./scripts/setup-firebase-hosting.sh

set -euo pipefail

PROJECT_ID="${FIREBASE_PROJECT_ID:-rafiq-alhajj}"
SITE_ID="${FIREBASE_STAGING_SITE_ID:-rafiq-alhajj-staging}"

if ! command -v firebase >/dev/null 2>&1; then
  echo "Install Firebase CLI: npm install -g firebase-tools"
  exit 1
fi

echo "==> Ensuring Firebase project: $PROJECT_ID"
firebase use "$PROJECT_ID"

echo "==> Creating hosting site (ignored if it already exists): $SITE_ID"
firebase hosting:sites:create "$SITE_ID" --project "$PROJECT_ID" 2>/dev/null || true

echo "==> Binding deploy target staging → $SITE_ID"
firebase target:apply hosting staging "$SITE_ID" --project "$PROJECT_ID"

echo ""
echo "Staging site ready."
echo "Stable client URL after first deploy:"
echo "  https://${SITE_ID}.web.app"
echo "  https://${SITE_ID}.firebaseapp.com"
