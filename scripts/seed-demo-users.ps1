# Creates local demo Auth users via Supabase Admin API (after db reset).
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

function Get-ServiceRoleKey {
    $envFile = Join-Path (Get-Location) ".env.local"
    if (Test-Path $envFile) {
        foreach ($line in Get-Content $envFile) {
            if ($line -match '^SERVICE_ROLE_KEY=(.+)$') {
                return $Matches[1].Trim().Trim('"')
            }
        }
    }

    $status = supabase status -o env 2>&1 | Out-String
    if ($status -match 'SERVICE_ROLE_KEY="?([^"\r\n]+)"?') {
        return $Matches[1]
    }
    if ($status -match "SERVICE_ROLE_KEY='([^']+)'") {
        return $Matches[1]
    }
    return $null
}

$key = Get-ServiceRoleKey
if (-not $key) {
    Write-Warning "Could not read SERVICE_ROLE_KEY. Create users manually in Studio."
    exit 0
}

$baseUrl = "http://127.0.0.1:54321"
$headers = @{
    apikey         = $key
    Authorization  = "Bearer $key"
    "Content-Type" = "application/json"
}

$users = @(
    @{
        email    = "pilgrim@demo.local"
        password = "demo123456"
        metadata = @{ role = "pilgrim"; full_name = "أحمد الحاج" }
    },
    @{
        email    = "operator@demo.local"
        password = "demo123456"
        metadata = @{ role = "operator"; full_name = "محمد التقني" }
    },
    @{
        email    = "admin@demo.local"
        password = "demo123456"
        metadata = @{ role = "admin"; full_name = "خالد المسؤول" }
    }
)

foreach ($u in $users) {
    $body = @{
        email          = $u.email
        password       = $u.password
        email_confirm  = $true
        user_metadata  = $u.metadata
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
