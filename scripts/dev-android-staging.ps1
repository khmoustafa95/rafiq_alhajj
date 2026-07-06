# Flutter on Android against staging Supabase (android · staging).
param(
    [string]$DefinesFile = ""
)

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

if (-not $DefinesFile) {
    $DefinesFile = node ./scripts/resolve-dart-defines.mjs android staging
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

Write-Host "Launching Flutter (Android, android.staging)..." -ForegroundColor Green
Write-Host "  dart-defines: $DefinesFile"
flutter run --dart-define-from-file="$DefinesFile"
