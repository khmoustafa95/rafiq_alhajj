# One-time / reset local backend + reminder for demo Auth users.
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

Write-Host "Resetting Supabase (migrations + seed)..." -ForegroundColor Cyan
supabase db reset
if ($LASTEXITCODE -ne 0) {
    Write-Error "supabase db reset failed"
}

Write-Host ""
Write-Host "Seeding demo Auth users..." -ForegroundColor Cyan
& "$PSScriptRoot\seed-demo-users.ps1"

Write-Host ""
Write-Host "Demo accounts (password: demo123456):" -ForegroundColor Yellow
Write-Host "  pilgrim@demo.local … pilgrim12@demo.local (12 pilgrims, varied field status)"
Write-Host "  operator@demo.local"
Write-Host "  admin@demo.local"
Write-Host ""
Write-Host "Then run: npm run dev  or  npm run dev:android" -ForegroundColor Green
