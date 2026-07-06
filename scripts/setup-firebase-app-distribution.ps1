# One-time Firebase App Distribution setup helper (Windows / PowerShell).
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

Write-Host ""
Write-Host "=== Rafiq Al-Hajj - Firebase App Distribution setup ===" -ForegroundColor Cyan
Write-Host ""

if (-not (Get-Command firebase -ErrorAction SilentlyContinue)) {
    Write-Error "Install Firebase CLI first: npm install -g firebase-tools"
}

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    Write-Error "Flutter SDK not found in PATH."
}

if (-not (Test-Path "android/app/google-services.json")) {
    Write-Host "STEP 1 - Android app in Firebase" -ForegroundColor Yellow
    Write-Host @"
1. Open https://console.firebase.google.com/project/rafiq-alhajj/overview
2. Add Android app if missing (package: com.example.rafiq_alhajj)
3. Download google-services.json -> android/app/google-services.json
"@
    Write-Error "google-services.json is required before continuing."
}

Write-Host "STEP 2 - Enable App Distribution" -ForegroundColor Yellow
Write-Host @"
Open Firebase Console -> Release & Monitor -> App Distribution -> Get started
"@

$groupName = $env:FIREBASE_APP_DISTRIBUTION_GROUPS
if (-not $groupName) {
    $groupName = Read-Host "Tester group name [client-preview]"
    if (-not $groupName) { $groupName = "client-preview" }
}

Write-Host ""
Write-Host "STEP 3 - Create tester group '$groupName' (safe if it already exists)" -ForegroundColor Yellow
firebase appdistribution:group:create $groupName --project rafiq-alhajj
# Exit code may be non-zero if group exists; continue.

Write-Host ""
Write-Host "STEP 4 - Add tester emails (comma-separated)" -ForegroundColor Yellow
$emails = Read-Host "Tester emails (leave empty to skip)"
if ($emails) {
    firebase appdistribution:testers:add $emails --group $groupName --project rafiq-alhajj
}

Write-Host ""
Write-Host "STEP 5 - Staging dart-defines for Android" -ForegroundColor Yellow
Write-Host @"
Copy-Item config/dart-defines/android.staging.example.json config/dart-defines/android.staging.json
Fill SUPABASE_* and FIREBASE_APP_ID (android:... from google-services.json).
Web staging uses config/dart-defines/web.staging.json — one file per scenario.
"@

Write-Host ""
Write-Host "STEP 6 - Apply DB migration (app_version_policies)" -ForegroundColor Yellow
Write-Host "Run: npm run staging:setup-db   (or supabase db push on staging)"

Write-Host ""
Write-Host "STEP 7 - First distribute" -ForegroundColor Yellow
Write-Host @"
npm run staging:distribute-android

Then in Admin -> Settings -> App versions -> Android:
- latest_version should auto-sync from pubspec.yaml
- Paste Firebase tester install URL into store_url (for in-app update button)
"@

$appId = node ./scripts/read-firebase-android-app-id.mjs
Write-Host ""
Write-Host "Detected Android Firebase App ID: $appId" -ForegroundColor Green
Write-Host "Done." -ForegroundColor Green
