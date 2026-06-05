# Creates local demo Auth users via Supabase Admin API (after db reset).
# User data (incl. Arabic names) lives in seed-demo-users.json (UTF-8) to avoid PS encoding issues.
$ErrorActionPreference = "Stop"
Set-Location (Join-Path $PSScriptRoot "..")

function Get-ServiceRoleKey {
    $candidates = @(
        (Join-Path (Get-Location) ".env.local"),
        (Join-Path (Get-Location) "supabase\.env")
    )

    foreach ($envFile in $candidates) {
        if (-not (Test-Path $envFile)) {
            continue
        }
        foreach ($line in Get-Content $envFile -Encoding UTF8) {
            if ($line -match '^(SERVICE_ROLE_KEY|SUPABASE_SERVICE_ROLE_KEY)=(.+)$') {
                return $Matches[2].Trim().Trim('"').Trim("'")
            }
        }
    }

    $prevEap = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        $status = (supabase status -o env 2>&1) | Out-String
    } finally {
        $ErrorActionPreference = $prevEap
    }
    $patterns = @(
        'SERVICE_ROLE_KEY="([^"]+)"',
        "SERVICE_ROLE_KEY='([^']+)'",
        'SERVICE_ROLE_KEY=([^\s\r\n]+)',
        'SUPABASE_SERVICE_ROLE_KEY="([^"]+)"',
        "SUPABASE_SERVICE_ROLE_KEY='([^']+)'",
        'SECRET_KEY="([^"]+)"',
        "SECRET_KEY='([^']+)'"
    )

    foreach ($pattern in $patterns) {
        if ($status -match $pattern) {
            return $Matches[1]
        }
    }

    return $null
}

$key = Get-ServiceRoleKey
if (-not $key) {
    Write-Warning "Could not read SERVICE_ROLE_KEY. Run: supabase status -o env"
    Write-Warning "Or add SERVICE_ROLE_KEY=... to .env.local (see supabase/.env.example). Create users in Studio if needed."
    exit 1
}

$usersFile = Join-Path $PSScriptRoot "seed-demo-users.json"
if (-not (Test-Path $usersFile)) {
    Write-Error "Missing $usersFile"
}

$usersJson = Get-Content $usersFile -Raw -Encoding UTF8
$users = $usersJson | ConvertFrom-Json

$baseUrl = "http://127.0.0.1:54321"
$headers = @{
    apikey         = $key
    Authorization  = "Bearer $key"
    "Content-Type" = "application/json"
}

foreach ($u in $users) {
    $body = @{
        email         = $u.email
        password      = $u.password
        email_confirm = $true
        user_metadata = $u.metadata
    } | ConvertTo-Json -Depth 5 -Compress

    try {
        $null = Invoke-RestMethod `
            -Uri "$baseUrl/auth/v1/admin/users" `
            -Method Post `
            -Headers $headers `
            -Body $body

        Write-Host "Created $($u.email)" -ForegroundColor Green
    } catch {
        $msg = $_.Exception.Message
        if ($msg -match "already|duplicate|exists") {
            Write-Host "Exists: $($u.email)" -ForegroundColor DarkYellow
        } else {
            Write-Warning "Failed $($u.email): $msg"
        }
    }
}

Write-Host ""
Write-Host "Demo password for all accounts: demo123456" -ForegroundColor Yellow
