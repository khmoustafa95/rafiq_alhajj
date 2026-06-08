# One-time / reset local backend + reminder for demo Auth users.
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

function Test-SupabaseProfilesSchema {
    $sql = @"
SELECT EXISTS (
  SELECT 1
  FROM information_schema.columns
  WHERE table_schema = 'public'
    AND table_name = 'profiles'
    AND column_name = 'email'
) AS ok;
"@
    $result = $sql | supabase db query 2>$null | ConvertFrom-Json
    return $result.rows[0].ok -eq $true
}

function Restart-SupabaseLocal {
    Write-Host "Restarting Supabase containers..." -ForegroundColor Cyan
    supabase stop | Out-Null
    Start-Sleep -Seconds 3
    supabase start
    if ($LASTEXITCODE -ne 0) {
        Write-Error "supabase start failed"
    }
}

Write-Host "Resetting Supabase (migrations + seed)..." -ForegroundColor Cyan
supabase db reset
$resetExitCode = $LASTEXITCODE

if ($resetExitCode -ne 0) {
    Write-Host ""
    Write-Warning "supabase db reset exited with code $resetExitCode (often a transient 502 while containers restart)."
    Write-Host "Checking whether migrations were applied..." -ForegroundColor Cyan

    if (-not (Test-SupabaseProfilesSchema)) {
        Write-Error "Database schema is incomplete after reset. Run: supabase stop; supabase start; supabase db reset --debug"
    }

    Write-Host "Migrations look OK. Recovering with a clean container restart..." -ForegroundColor Yellow
    Restart-SupabaseLocal
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
