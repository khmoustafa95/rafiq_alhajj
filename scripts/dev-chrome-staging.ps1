# Flutter on Chrome against staging Supabase (web · staging).
param(
    [string]$DefinesFile = ""
)

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

if (-not $DefinesFile) {
    $DefinesFile = node ./scripts/resolve-dart-defines.mjs web staging
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

Write-Host "Launching Flutter (Chrome, web.staging)..." -ForegroundColor Green
Write-Host "  dart-defines: $DefinesFile"
flutter run -d chrome --dart-define-from-file="$DefinesFile"
