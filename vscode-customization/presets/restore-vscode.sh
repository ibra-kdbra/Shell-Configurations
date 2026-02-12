#!/usr/bin/env bash
set -euo pipefail

OS_NAME="$(uname -s)"
case "$OS_NAME" in
  Linux)
    USER_DIR="$HOME/.config/Code/User"
    ;;
  Darwin)
    USER_DIR="$HOME/Library/Application Support/Code/User"
    ;;
  *)
    echo "Unsupported OS: $OS_NAME"
    echo "Use restore-vscode.ps1 on Windows."
    exit 1
    ;;
esac

LATEST_POINTER="$USER_DIR/vscode-customization-backups/latest.txt"

if [[ ! -f "$LATEST_POINTER" ]]; then
  echo "No backup pointer found: $LATEST_POINTER"
  exit 1
fi

BACKUP_DIR="$(cat "$LATEST_POINTER")"

if [[ ! -d "$BACKUP_DIR" ]]; then
  echo "Backup directory not found: $BACKUP_DIR"
  exit 1
fi

[[ -f "$BACKUP_DIR/settings.json" ]] && cp "$BACKUP_DIR/settings.json" "$USER_DIR/settings.json"
[[ -f "$BACKUP_DIR/keybindings.json" ]] && cp "$BACKUP_DIR/keybindings.json" "$USER_DIR/keybindings.json"

echo "Rollback completed from: $BACKUP_DIR"
echo "Reload VS Code: Ctrl+Shift+P -> Developer: Reload Window"
