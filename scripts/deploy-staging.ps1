# Build staging web and deploy to Firebase Hosting (Windows / PowerShell).
param(
    [string]$DefinesFile = ""
)

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

if ($DefinesFile) {
    & "$PSScriptRoot\build-staging-web.ps1" -DefinesFile $DefinesFile
}
else {
    & "$PSScriptRoot\build-staging-web.ps1"
}
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

if (-not (Get-Command firebase -ErrorAction SilentlyContinue)) {
    Write-Error "firebase CLI not found. Install: npm install -g firebase-tools"
}

Write-Host "==> Deploying to Firebase Hosting (staging)"
firebase deploy --only hosting:staging --project rafiq-alhajj
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host ""
Write-Host "Staging URL: https://rafiq-alhajj-staging.web.app" -ForegroundColor Green
