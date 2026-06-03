# Start local Supabase then Flutter on Android (emulator/device).
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

Write-Host "Checking Supabase..." -ForegroundColor Cyan
$status = supabase status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Starting Supabase stack..." -ForegroundColor Yellow
    supabase start
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Supabase failed to start. Is Docker Desktop running?"
    }
}

if (-not (Test-Path "dart_defines.android.local.json")) {
    Write-Error "Missing dart_defines.android.local.json — copy from dart_defines.android.local.example.json"
}

Write-Host "Launching Flutter (Android)..." -ForegroundColor Green
flutter run --dart-define-from-file=dart_defines.android.local.json
