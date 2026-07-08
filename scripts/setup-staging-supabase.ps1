# One-time setup for Supabase Staging cloud (Windows / PowerShell).
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

. "$PSScriptRoot\load-staging-env.ps1"

$projectRef = $env:SUPABASE_PROJECT_REF
if (-not $projectRef) {
    Write-Error @"
Missing SUPABASE_PROJECT_REF.

One-time setup (recommended):
  1. copy config\.env.staging.example config\.env.staging.local
  2. Fill SUPABASE_PROJECT_REF and SUPABASE_SERVICE_ROLE_KEY
  3. npm run staging:setup-db

Or set SUPABASE_URL in config/dart-defines/web.staging.json (project ref is derived).

Temporary override:
  `$env:SUPABASE_PROJECT_REF = 'your-project-ref'
"@
}

Write-Host "==> Linking local repo to Supabase project: $projectRef"
$linkArgs = @("link", "--project-ref", $projectRef)
if ($env:SUPABASE_SKIP_POOLER -eq "true") {
    $poolerUrl = Join-Path $PSScriptRoot "..\supabase\.temp\pooler-url"
    if (Test-Path $poolerUrl) {
        Remove-Item $poolerUrl -Force
    }
    $linkArgs += "--skip-pooler"
    Write-Host "Using direct DB connection (--skip-pooler)."
}
supabase @linkArgs
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "==> Pushing database migrations"
if (-not $env:SUPABASE_DB_PASSWORD) {
    Write-Warning @"
SUPABASE_DB_PASSWORD is not set — db push may hang at 'Initialising login role...'.

Add to config/.env.staging.local:
  SUPABASE_DB_PASSWORD=your-database-password

Dashboard -> Project Settings -> Database -> Database password
(This is the password you chose when creating the project, NOT service_role.)
"@
}
supabase db push
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "==> Applying seed data (Arabic demo content)"
$seedApplied = $false
try {
    supabase db query --linked -f supabase/seed.sql
    if ($LASTEXITCODE -eq 0) {
        $seedApplied = $true
        Write-Host "Seed applied via supabase db query."
    }
}
catch {
    # fall through to manual instructions
}

if (-not $seedApplied) {
    Write-Warning "Could not auto-seed. Run manually in Supabase SQL Editor:"
    Write-Host "  Paste contents of supabase/seed.sql"
}

Write-Host ""
Write-Host "==> Deploying Edge Functions (optional but recommended)"
$functions = @(
    "create-pilgrim",
    "manage-operator",
    "import-pilgrims",
    "reset-pilgrim-password",
    "send-push-notification",
    "delete-my-account",
    "promote-to-admin"
)
foreach ($fn in $functions) {
    if (Test-Path "supabase/functions/$fn") {
        Write-Host "Deploying $fn..."
        supabase functions deploy $fn --project-ref $projectRef
    }
}

if ($env:SUPABASE_SERVICE_ROLE_KEY) {
    Write-Host ""
    Write-Host "==> Seeding demo Auth users"
    $env:SUPABASE_URL = "https://${projectRef}.supabase.co"
    node scripts/seed-demo-users.mjs
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}
else {
    Write-Host ""
    Write-Host "Skip demo Auth users (set SUPABASE_SERVICE_ROLE_KEY to seed)."
    Write-Host "Dashboard -> Project Settings -> API -> service_role key"
}

Write-Host ""
Write-Host "Staging Supabase ready." -ForegroundColor Green
Write-Host "API URL: https://${projectRef}.supabase.co"
Write-Host "Copy anon key from Dashboard -> Project Settings -> API -> anon/public"
Write-Host "into dart_defines.staging.local.json, then build + deploy web."
