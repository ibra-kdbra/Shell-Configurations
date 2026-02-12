param(
    [ValidateSet("on", "off", "status")]
    [string]$Mode = "status"
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$UserDir = Join-Path $env:APPDATA "Code\User"
$NormalSettings = Join-Path $ScriptDir "settings.windows.jsonc"
$LowSettings = Join-Path $ScriptDir "settings.low-resource.windows.jsonc"

$ModeDir = Join-Path $UserDir "vscode-customization-mode"
$BackupDir = Join-Path $ModeDir "backups"
$ModeFile = Join-Path $ModeDir "current-mode.txt"
$PrevFile = Join-Path $ModeDir "previous-settings.json"
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

New-Item -ItemType Directory -Force $UserDir | Out-Null
New-Item -ItemType Directory -Force $BackupDir | Out-Null

function Get-CurrentMode {
    if (Test-Path $ModeFile) {
        return (Get-Content $ModeFile -Raw).Trim()
    }
    return "normal"
}

function Set-CurrentMode([string]$Value) {
    Set-Content -Path $ModeFile -Value $Value -Encoding UTF8
}

function Save-PreviousIfNeeded {
    $SettingsPath = Join-Path $UserDir "settings.json"
    if ((Test-Path $SettingsPath) -and -not (Test-Path $PrevFile)) {
        Copy-Item $SettingsPath $PrevFile -Force
    }
}

function SnapshotCurrent {
    $SettingsPath = Join-Path $UserDir "settings.json"
    if (Test-Path $SettingsPath) {
        Copy-Item $SettingsPath (Join-Path $BackupDir "settings.$Timestamp.json") -Force
    }
}

switch ($Mode) {
    "on" {
        Save-PreviousIfNeeded
        SnapshotCurrent
        Copy-Item $LowSettings (Join-Path $UserDir "settings.json") -Force
        Set-CurrentMode "low-resource"
        Write-Host "Low-resource mode: ON"
        Write-Host "Applied: $LowSettings"
    }
    "off" {
        SnapshotCurrent
        if (Test-Path $PrevFile) {
            Copy-Item $PrevFile (Join-Path $UserDir "settings.json") -Force
            Remove-Item $PrevFile -Force
            Write-Host "Restored previous settings snapshot."
        }
        else {
            Copy-Item $NormalSettings (Join-Path $UserDir "settings.json") -Force
            Write-Host "No previous snapshot found. Applied normal preset instead."
            Write-Host "Applied: $NormalSettings"
        }
        Set-CurrentMode "normal"
        Write-Host "Low-resource mode: OFF"
    }
    "status" {
        Write-Host "Current mode: $(Get-CurrentMode)"
        Write-Host "Mode data dir: $ModeDir"
    }
}

Write-Host "Reload VS Code: Ctrl+Shift+P -> Developer: Reload Window"
