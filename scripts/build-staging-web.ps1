# Build Flutter Web for the staging environment (Windows / PowerShell).
param(
    [string]$DefinesFile = ""
)

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

$definesJson = $env:STAGING_DART_DEFINES_JSON
$tempDefinesFile = $null

if ($definesJson) {
    $tempDefinesFile = [IO.Path]::GetTempFileName()
    [IO.File]::WriteAllText($tempDefinesFile, $definesJson)
    $DefinesFile = $tempDefinesFile
}
elseif (-not $DefinesFile) {
    if (Test-Path "dart_defines.staging.json") {
        $DefinesFile = "dart_defines.staging.json"
    }
    elseif (Test-Path "dart_defines.staging.local.json") {
        $DefinesFile = "dart_defines.staging.local.json"
    }
    else {
        Write-Error @"
Missing staging dart-defines.
Create dart_defines.staging.local.json from dart_defines.staging.example.json
or set STAGING_DART_DEFINES_JSON.
"@
    }
}

if (-not (Test-Path $DefinesFile)) {
    Write-Error "Dart defines file not found: $DefinesFile"
}

try {
    Write-Host "==> Building Flutter Web (staging) with $DefinesFile"
    flutter pub get
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

    flutter build web `
        --release `
        --dart-define-from-file="$DefinesFile" `
        --base-href="/"
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

    if (Get-Command node -ErrorAction SilentlyContinue) {
        Write-Host "==> Syncing Firebase service worker from dart-defines (if configured)"
        node ./scripts/patch-firebase-sw.mjs $DefinesFile ./build/web/firebase-messaging-sw.js
        if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    }

    Write-Host ""
    Write-Host "Build complete: $(Get-Location)\build\web" -ForegroundColor Green
    Write-Host "Deploy with: firebase deploy --only hosting:staging"
}
finally {
    if ($tempDefinesFile -and (Test-Path $tempDefinesFile)) {
        Remove-Item $tempDefinesFile -Force
    }
}
