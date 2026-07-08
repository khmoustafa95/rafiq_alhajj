#!/usr/bin/env bash
# Staging smoke test for store-readiness (legal build + config verification).
# Does not require Supabase credentials — checks repo + optional web build output.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "==> Verifying store setup (sources + dart-defines templates)"
node ./scripts/verify-staging-store-setup.mjs

if [[ -d build/web ]]; then
  echo ""
  echo "==> Verifying legal pages in existing build/web"
  node ./scripts/verify-legal-build.mjs build/web
else
  echo ""
  echo "==> Skipping build/web check (run staging:build first to verify deployed legal pages)"
fi

echo ""
echo "Manual staging checks (after deploy):"
echo "  1. Open https://rafiq-alhajj-staging.web.app/legal/privacy.html"
echo "  2. Login screen shows Privacy Policy + Terms links"
echo "  3. Profile → Delete account (pilgrim@demo.local) — requires delete-my-account edge fn on staging Supabase"
echo "  4. npm run staging:setup-db deploys delete-my-account (re-run if branch not merged yet)"
