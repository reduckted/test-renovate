$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

Write-Host "PROCESSOR_ARCHITECTURE = $env:PROCESSOR_ARCHITECTURE"
Write-Host "PATHEXT = $env:PATHEXT"

$InstallDir = "./cli-tools"
$Version = Get-Content -Path "global.json" | ConvertFrom-Json | Select-Object -ExpandProperty sdk | Select-Object -ExpandProperty version

if (Test-Path $InstallDir) {
    Remove-Item -Path $InstallDir -Recurse
}

New-Item -Type Directory -Path $InstallDir | Out-Null

Invoke-WebRequest -Uri "https://dot.net/v1/dotnet-install.ps1" -OutFile "$InstallDir/dotnet-install.ps1"

& $InstallDir/dotnet-install.ps1 -InstallDir $InstallDir -Version $Version
