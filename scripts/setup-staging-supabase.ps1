# One-time setup for Supabase Staging cloud (Windows / PowerShell).
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

$projectRef = $env:SUPABASE_PROJECT_REF
if (-not $projectRef) {
    Write-Error @"
Set SUPABASE_PROJECT_REF to your Supabase cloud project ref.
Find it in Dashboard -> Project Settings -> General -> Reference ID.

Example:
  `$env:SUPABASE_PROJECT_REF = 'your-project-ref'
  npm run staging:setup-db
"@
}

Write-Host "==> Linking local repo to Supabase project: $projectRef"
supabase link --project-ref $projectRef
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "==> Pushing database migrations"
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
