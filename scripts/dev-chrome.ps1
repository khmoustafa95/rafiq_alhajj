# Start local Supabase (if Docker is running) then Flutter on Chrome.
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

if (-not (Test-Path "dart_defines.local.json")) {
    Write-Error "Missing dart_defines.local.json — copy from dart_defines.local.example.json"
}

Write-Host "Launching Flutter (Chrome)..." -ForegroundColor Green
flutter run -d chrome --dart-define-from-file=dart_defines.local.json
