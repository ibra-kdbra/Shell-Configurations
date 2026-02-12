$ErrorActionPreference = "Stop"

$UserDir = Join-Path $env:APPDATA "Code\User"
$LatestPointer = Join-Path $UserDir "vscode-customization-backups\latest.txt"

if (-not (Test-Path $LatestPointer)) {
    Write-Error "No backup pointer found: $LatestPointer"
}

$BackupDir = (Get-Content $LatestPointer -Raw).Trim()

if (-not (Test-Path $BackupDir)) {
    Write-Error "Backup directory not found: $BackupDir"
}

$SettingsBackup = Join-Path $BackupDir "settings.json"
$KeybindingsBackup = Join-Path $BackupDir "keybindings.json"

if (Test-Path $SettingsBackup) {
    Copy-Item $SettingsBackup (Join-Path $UserDir "settings.json") -Force
}

if (Test-Path $KeybindingsBackup) {
    Copy-Item $KeybindingsBackup (Join-Path $UserDir "keybindings.json") -Force
}

Write-Host "Rollback completed from: $BackupDir"
Write-Host "Reload VS Code: Ctrl+Shift+P -> Developer: Reload Window"
