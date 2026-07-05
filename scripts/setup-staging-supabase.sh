#!/usr/bin/env bash
# One-time setup for Supabase Staging (cloud free tier).
#
# Prerequisites:
#   - supabase CLI logged in: supabase login
#   - A Supabase cloud project created at https://supabase.com/dashboard
#
# Usage:
#   export SUPABASE_PROJECT_REF=your-project-ref
#   ./scripts/setup-staging-supabase.sh
#
# Optional (seed demo Auth users after DB is ready):
#   export SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
#   node scripts/seed-demo-users.mjs

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

PROJECT_REF="${SUPABASE_PROJECT_REF:-}"
if [[ -z "$PROJECT_REF" ]]; then
  echo "Set SUPABASE_PROJECT_REF to your Supabase cloud project ref."
  echo "Find it in Dashboard → Project Settings → General → Reference ID."
  exit 1
fi

echo "==> Linking local repo to Supabase project: $PROJECT_REF"
supabase link --project-ref "$PROJECT_REF"

echo "==> Pushing database migrations"
supabase db push

echo "==> Applying seed data (Arabic demo content)"
if supabase db query --linked -f supabase/seed.sql 2>/dev/null; then
  echo "Seed applied via supabase db query."
else
  echo "Trying psql via linked connection string..."
  DB_URL="$(supabase db url --linked 2>/dev/null || true)"
  if [[ -n "$DB_URL" ]] && command -v psql >/dev/null 2>&1; then
    psql "$DB_URL" -v ON_ERROR_STOP=1 -f supabase/seed.sql
  else
    echo "Could not auto-seed. Run manually in Supabase SQL Editor:"
    echo "  Paste contents of supabase/seed.sql"
  fi
fi

echo ""
echo "==> Deploying Edge Functions (optional but recommended)"
for fn in create-pilgrim manage-operator import-pilgrims reset-pilgrim-password send-push-notification; do
  if [[ -d "supabase/functions/$fn" ]]; then
    echo "Deploying $fn..."
    supabase functions deploy "$fn" --project-ref "$PROJECT_REF" || true
  fi
done

if [[ -n "${SUPABASE_SERVICE_ROLE_KEY:-}" ]]; then
  echo ""
  echo "==> Seeding demo Auth users"
  SUPABASE_URL="https://${PROJECT_REF}.supabase.co" \
    node scripts/seed-demo-users.mjs
else
  echo ""
  echo "Skip demo Auth users (set SUPABASE_SERVICE_ROLE_KEY to seed)."
  echo "Dashboard → Project Settings → API → service_role key"
fi

echo ""
echo "Staging Supabase ready."
echo "API URL: https://${PROJECT_REF}.supabase.co"
echo "Copy anon key from Dashboard → Project Settings → API → anon/public"
echo "into dart_defines.staging.local.json, then build + deploy web."
