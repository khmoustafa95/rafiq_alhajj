# Build staging APK and upload to Firebase App Distribution (Windows / PowerShell).
param(
    [string]$Groups = "",
    [string]$ReleaseNotes = "",
    [switch]$SkipBuild,
    [switch]$SkipVersionSync
)

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

if (-not (Get-Command firebase -ErrorAction SilentlyContinue)) {
    Write-Error "firebase CLI not found. Install: npm install -g firebase-tools"
}

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Error "node not found."
}

if (-not $SkipBuild) {
    & "$PSScriptRoot\build-staging-android.ps1"
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

$apkPath = Join-Path (Get-Location) "build/app/outputs/flutter-apk/app-release.apk"
if (-not (Test-Path $apkPath)) {
    Write-Error "APK not found at $apkPath. Run npm run staging:build-apk first."
}

$firebaseAppId = node ./scripts/read-firebase-android-app-id.mjs
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

if (-not $Groups) {
    $Groups = $env:FIREBASE_APP_DISTRIBUTION_GROUPS
}
if (-not $Groups) {
    $Groups = "client-preview"
}

if (-not $ReleaseNotes) {
    $ReleaseNotes = $env:FIREBASE_APP_DISTRIBUTION_NOTES
}
if (-not $ReleaseNotes) {
    $versionName = node ./scripts/read-pubspec-version.mjs
    $ReleaseNotes = "Rafiq Al-Hajj staging build v$versionName"
}

Write-Host "==> Uploading to Firebase App Distribution"
Write-Host "    App ID: $firebaseAppId"
Write-Host "    Groups: $Groups"

firebase appdistribution:distribute $apkPath `
    --app $firebaseAppId `
    --project rafiq-alhajj `
    --groups $Groups `
    --release-notes $ReleaseNotes
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

if (-not $SkipVersionSync) {
    Write-Host ""
    Write-Host "==> Syncing android latest_version in Supabase"
    node ./scripts/update-android-version-policy.mjs
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Version policy sync failed. Update /admin/settings/app-versions manually."
    }
}

Write-Host ""
Write-Host "Firebase App Distribution upload complete." -ForegroundColor Green
Write-Host "Testers in group '$Groups' will receive an email invite."
Write-Host "Optional: set ANDROID_DISTRIBUTION_INSTALL_URL before distribute to auto-fill store_url."
