# Loads persistent staging CLI secrets from config/.env.staging.local
# and falls back to SUPABASE_URL in config/dart-defines/web.staging.json.
$ErrorActionPreference = "Stop"

$RootDir = Resolve-Path (Join-Path $PSScriptRoot "..")

function Import-DotEnvFile {
    param([string]$Path)

    if (-not (Test-Path $Path)) { return }

    Get-Content $Path | ForEach-Object {
        $line = $_.Trim()
        if ($line -eq '' -or $line.StartsWith('#')) { return }
        if ($line -match '^([^=]+)=(.*)$') {
            $name = $matches[1].Trim()
            $value = $matches[2].Trim().Trim('"').Trim("'")
            if ($value) {
                Set-Item -Path "env:$name" -Value $value
            }
        }
    }
}

$stagingEnvPath = Join-Path $RootDir "config\.env.staging.local"
Import-DotEnvFile -Path $stagingEnvPath

if (-not $env:SUPABASE_PROJECT_REF) {
    $webStagingPath = Join-Path $RootDir "config\dart-defines\web.staging.json"
    if (Test-Path $webStagingPath) {
        $json = Get-Content $webStagingPath -Raw | ConvertFrom-Json
        $url = [string]$json.SUPABASE_URL
        if ($url -match 'https://([^.]+)\.supabase\.co') {
            $env:SUPABASE_PROJECT_REF = $Matches[1]
        }
    }
}

if (-not $env:SUPABASE_URL -and $env:SUPABASE_PROJECT_REF) {
    $env:SUPABASE_URL = "https://$($env:SUPABASE_PROJECT_REF).supabase.co"
}
