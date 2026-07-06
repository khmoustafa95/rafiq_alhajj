# Flutter on a physical Android device against local Supabase (android-device · local).
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
    $DefinesFile = node ./scripts/resolve-dart-defines.mjs android-device local
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

Write-Host "Launching Flutter (physical device, android-device.local)..." -ForegroundColor Green
Write-Host "  dart-defines: $DefinesFile"
Write-Host "  Tip: set SUPABASE_URL to your PC LAN IP in the config file."
flutter run --dart-define-from-file="$DefinesFile"
