# Start local Supabase then Flutter on Chrome (web · local).
param(
    [string]$DefinesFile = ""
)

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

Write-Host "Checking Supabase..." -ForegroundColor Cyan
$null = supabase status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Starting Supabase stack..." -ForegroundColor Yellow
    supabase start
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Supabase failed to start. Is Docker Desktop running?"
    }
}

if (-not $DefinesFile) {
    $DefinesFile = node ./scripts/resolve-dart-defines.mjs web local
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

Write-Host "Launching Flutter (Chrome, web.local)..." -ForegroundColor Green
Write-Host "  dart-defines: $DefinesFile"
flutter run -d chrome --dart-define-from-file="$DefinesFile"
