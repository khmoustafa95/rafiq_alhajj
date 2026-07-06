# Build a release APK for the staging environment (Windows / PowerShell).
param(
    [string]$DefinesFile = ""
)

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

$googleServices = "android/app/google-services.json"
if (-not (Test-Path $googleServices)) {
    Write-Error @"
Missing $googleServices (gitignored).
Download it from Firebase Console -> Project rafiq-alhajj -> Android app (com.example.rafiq_alhajj).
"@
}

if (-not $DefinesFile) {
    $DefinesFile = node ./scripts/resolve-dart-defines.mjs android staging
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}
elseif (-not (Test-Path $DefinesFile)) {
    Write-Error "Dart defines file not found: $DefinesFile"
}

$versionName = node ./scripts/read-pubspec-version.mjs
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
$buildNumber = node ./scripts/read-pubspec-version.mjs --build-number
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "==> Building Flutter Android APK (android.staging) v$versionName+$buildNumber"
Write-Host "    dart-defines: $DefinesFile"

flutter pub get
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

flutter build apk `
    --release `
    --build-name=$versionName `
    --build-number=$buildNumber `
    --dart-define-from-file="$DefinesFile"
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

$apkPath = Join-Path (Get-Location) "build/app/outputs/flutter-apk/app-release.apk"
Write-Host ""
Write-Host "APK ready: $apkPath" -ForegroundColor Green
Write-Host "Distribute with: npm run staging:distribute-android"
