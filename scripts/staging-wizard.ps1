# Interactive one-time Staging setup wizard (Windows / PowerShell).
# Run from repo root: powershell -ExecutionPolicy Bypass -File ./scripts/staging-wizard.ps1

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

Write-Host ""
Write-Host "=== Rafiq Al-Hajj - Staging setup wizard ===" -ForegroundColor Cyan
Write-Host "Stable client URL after deploy: https://rafiq-alhajj-staging.web.app"
Write-Host ""

function Require-Command($name) {
    if (-not (Get-Command $name -ErrorAction SilentlyContinue)) {
        Write-Error "Missing command: $name. Install it first (see docs/staging-setup-ar.md)."
    }
}

Require-Command supabase
Require-Command node
Require-Command flutter

# --- Step 1: Supabase cloud project ---
Write-Host "STEP 1/5 - Supabase cloud project" -ForegroundColor Yellow
Write-Host @"
1. Open https://supabase.com/dashboard
2. New project → name: rafiq-alhajj-staging
3. Choose a strong DB password (save it)
4. Wait until the project is ready
5. Project Settings → General → copy Reference ID
6. Project Settings → API → copy:
   - Project URL
   - anon / publishable key
   - service_role key (secret - never commit)
"@

$projectRef = Read-Host "Paste Supabase Reference ID"
$supabaseUrl = Read-Host "Paste Supabase URL (https://xxx.supabase.co)"
$anonKey = Read-Host "Paste Supabase anon/publishable key"
$serviceRoleKey = Read-Host "Paste Supabase service_role key" -AsSecureString
$serviceRolePlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($serviceRoleKey)
)

if (-not $supabaseUrl.StartsWith("https://")) {
    $supabaseUrl = "https://$projectRef.supabase.co"
}

# Persist CLI secrets so staging:* scripts work without re-entering env vars.
$stagingEnvPath = Join-Path $PSScriptRoot "..\config\.env.staging.local"
$stagingEnvContent = @"
# Auto-written by staging-wizard.ps1 — gitignored
SUPABASE_PROJECT_REF=$projectRef
SUPABASE_URL=$supabaseUrl
SUPABASE_SERVICE_ROLE_KEY=$serviceRolePlain
"@
[IO.File]::WriteAllText($stagingEnvPath, $stagingEnvContent.Trim(), (New-Object System.Text.UTF8Encoding $false))
Write-Host "Wrote $stagingEnvPath (persistent staging CLI secrets)" -ForegroundColor Green

# --- Step 2: Write dart defines ---
Write-Host ""
Write-Host "STEP 2/5 - Writing config/dart-defines/web.staging.json" -ForegroundColor Yellow

$webDefines = [ordered]@{
    APP_ENV                   = "staging"
    APP_PLATFORM              = "web"
    SUPABASE_URL              = $supabaseUrl
    SUPABASE_ANON_KEY         = $anonKey
    CRASH_REPORTING_ENABLED   = "false"
    FIREBASE_PROJECT_ID       = "rafiq-alhajj"
    FIREBASE_API_KEY          = "AIzaSyB6yQydgip8E8MfCWjVn8fmL0a3Er9rj2k"
    FIREBASE_MESSAGING_SENDER_ID = "459655824918"
    FIREBASE_WEB_APP_ID       = "1:459655824918:web:42f67ac7e460e2ab901737"
    FIREBASE_AUTH_DOMAIN      = "rafiq-alhajj.firebaseapp.com"
    FIREBASE_STORAGE_BUCKET   = "rafiq-alhajj.firebasestorage.app"
    FIREBASE_VAPID_KEY        = ""
    FIREBASE_MEASUREMENT_ID   = ""
}

$configDir = Join-Path $PWD "config\dart-defines"
New-Item -ItemType Directory -Force -Path $configDir | Out-Null

$webDefinesPath = Join-Path $configDir "web.staging.json"
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[IO.File]::WriteAllText($webDefinesPath, ($webDefines | ConvertTo-Json), $utf8NoBom)
Write-Host "Wrote $webDefinesPath" -ForegroundColor Green

Write-Host "Copy android.staging.example.json -> android.staging.json and fill FIREBASE_APP_ID from google-services.json"
$androidExample = Join-Path $configDir "android.staging.example.json"
$androidPath = Join-Path $configDir "android.staging.json"
if ((Test-Path $androidExample) -and -not (Test-Path $androidPath)) {
    $androidJson = Get-Content $androidExample -Raw | ConvertFrom-Json
    $androidJson.SUPABASE_URL = $supabaseUrl
    $androidJson.SUPABASE_ANON_KEY = $anonKey
    $androidJson.FIREBASE_PROJECT_ID = "rafiq-alhajj"
    $androidJson.FIREBASE_API_KEY = "AIzaSyB6yQydgip8E8MfCWjVn8fmL0a3Er9rj2k"
    $androidJson.FIREBASE_MESSAGING_SENDER_ID = "459655824918"
    [IO.File]::WriteAllText($androidPath, ($androidJson | ConvertTo-Json), $utf8NoBom)
    Write-Host "Wrote $androidPath (update FIREBASE_APP_ID before APK build)" -ForegroundColor Yellow
}

# --- Step 3: Link + push DB ---
Write-Host ""
Write-Host "STEP 3/5 - Supabase login + migrations" -ForegroundColor Yellow
Write-Host "A browser window will open for supabase login if needed."
supabase login
supabase link --project-ref $projectRef
supabase db push

Write-Host "Applying seed.sql..."
$seedApplied = $false
try {
    supabase db query --linked -f supabase/seed.sql
    $seedApplied = $true
} catch {
    Write-Warning "supabase db query failed. Paste supabase/seed.sql in SQL Editor manually."
}

# --- Step 4: Demo users ---
Write-Host ""
Write-Host "STEP 4/5 - Seeding demo Auth users" -ForegroundColor Yellow
$env:SUPABASE_URL = $supabaseUrl
$env:SUPABASE_SERVICE_ROLE_KEY = $serviceRolePlain
node ./scripts/seed-demo-users.mjs

# --- Step 5: Auth redirect URLs reminder ---
Write-Host ""
Write-Host "STEP 5/5 - Supabase Auth URLs (manual in Dashboard)" -ForegroundColor Yellow
Write-Host @"
In Supabase Dashboard → Authentication → URL Configuration:

  Site URL:
    https://rafiq-alhajj-staging.web.app

  Redirect URLs (add both):
    https://rafiq-alhajj-staging.web.app/**
    https://rafiq-alhajj-staging.firebaseapp.com/**
"@

Write-Host ""
Write-Host "=== Supabase staging is ready ===" -ForegroundColor Green
Write-Host ""
Write-Host "Next - Firebase Hosting (run in a new terminal):" -ForegroundColor Cyan
Write-Host "  npm install -g firebase-tools"
Write-Host "  firebase login"
Write-Host "  npm run staging:setup-hosting"
Write-Host "  npm run staging:deploy"
Write-Host ""
Write-Host "Or add GitHub Secrets for auto-deploy (see docs/staging-setup-ar.md section 5)."
Write-Host ""
Write-Host "Demo login for client:" -ForegroundColor Yellow
Write-Host '  admin@demo.local / demo123456'
