# One-time Firebase Hosting setup for the staging site (Windows / PowerShell).
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

$projectId = if ($env:FIREBASE_PROJECT_ID) { $env:FIREBASE_PROJECT_ID } else { "rafiq-alhajj" }
$siteId = if ($env:FIREBASE_STAGING_SITE_ID) { $env:FIREBASE_STAGING_SITE_ID } else { "rafiq-alhajj-staging" }

if (-not (Get-Command firebase -ErrorAction SilentlyContinue)) {
    Write-Error "Install Firebase CLI: npm install -g firebase-tools"
}

Write-Host "==> Ensuring Firebase project: $projectId"
firebase use $projectId
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "==> Creating hosting site (ignored if it already exists): $siteId"
firebase hosting:sites:create $siteId --project $projectId 2>$null

Write-Host "==> Binding deploy target staging -> $siteId"
firebase target:apply hosting staging $siteId --project $projectId
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host ""
Write-Host "Staging site ready." -ForegroundColor Green
Write-Host "Stable client URL after first deploy:"
Write-Host "  https://${siteId}.web.app"
Write-Host "  https://${siteId}.firebaseapp.com"
