param(
    [switch]$SkipExtensions
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$SettingsSource = Join-Path $ScriptDir "settings.windows.jsonc"
$KeybindingsSource = Join-Path $ScriptDir "keybindings.core.jsonc"
$ExtensionsSource = Join-Path $ScriptDir "extensions.core.txt"
$UserDir = Join-Path $env:APPDATA "Code\User"
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$BackupRoot = Join-Path $UserDir "vscode-customization-backups"
$BackupDir = Join-Path $BackupRoot $Timestamp
$LatestPointer = Join-Path $BackupRoot "latest.txt"

New-Item -ItemType Directory -Force $UserDir | Out-Null

if ((Test-Path (Join-Path $UserDir "settings.json")) -or (Test-Path (Join-Path $UserDir "keybindings.json"))) {
    New-Item -ItemType Directory -Force $BackupDir | Out-Null
    if (Test-Path (Join-Path $UserDir "settings.json")) {
        Copy-Item (Join-Path $UserDir "settings.json") (Join-Path $BackupDir "settings.json") -Force
    }
    if (Test-Path (Join-Path $UserDir "keybindings.json")) {
        Copy-Item (Join-Path $UserDir "keybindings.json") (Join-Path $BackupDir "keybindings.json") -Force
    }
    New-Item -ItemType Directory -Force $BackupRoot | Out-Null
    Set-Content -Path $LatestPointer -Value $BackupDir -Encoding UTF8
    Write-Host "Backup created: $BackupDir"
}

Copy-Item $SettingsSource (Join-Path $UserDir "settings.json") -Force
Copy-Item $KeybindingsSource (Join-Path $UserDir "keybindings.json") -Force

Write-Host "Applied settings and keybindings to: $UserDir"

if (-not $SkipExtensions) {
    $CodeCli = Get-Command code -ErrorAction SilentlyContinue
    if ($CodeCli) {
        Write-Host "Installing extensions..."
        Get-Content $ExtensionsSource | ForEach-Object {
            $ext = $_.Trim()
            if ($ext) {
                code --install-extension $ext | Out-Null
            }
        }
        Write-Host "Extensions installation step completed."
    }
    else {
        Write-Host "'code' CLI not found. Skipping extension installation."
        Write-Host "Open VS Code and enable the code CLI, then rerun this script."
    }
}

Write-Host "Done. Reload VS Code: Ctrl+Shift+P -> Developer: Reload Window"
Write-Host "To rollback latest backup: .\vscode-customization\presets\restore-vscode.ps1"
