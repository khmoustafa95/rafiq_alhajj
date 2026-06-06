# Creates local demo Auth users via Supabase Admin API (after db reset).
# Arabic names are seeded by Node (UTF-8 safe). Windows PowerShell 5.1 corrupts
# Arabic when using ConvertFrom-Json / Invoke-RestMethod.
$ErrorActionPreference = "Stop"
Set-Location (Join-Path $PSScriptRoot "..")

$nodeScript = Join-Path $PSScriptRoot "seed-demo-users.mjs"
if (-not (Test-Path $nodeScript)) {
    Write-Error "Missing $nodeScript"
}

node $nodeScript
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}
