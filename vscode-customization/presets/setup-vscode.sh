#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS_NAME="$(uname -s)"

case "$OS_NAME" in
  Linux)
    SETTINGS_SOURCE="$SCRIPT_DIR/settings.linux.jsonc"
    USER_DIR="$HOME/.config/Code/User"
    ;;
  Darwin)
    SETTINGS_SOURCE="$SCRIPT_DIR/settings.macos.jsonc"
    USER_DIR="$HOME/Library/Application Support/Code/User"
    ;;
  *)
    echo "Unsupported OS: $OS_NAME"
    echo "Use setup-vscode.ps1 on Windows."
    exit 1
    ;;
esac

KEYBINDINGS_SOURCE="$SCRIPT_DIR/keybindings.core.jsonc"
EXTENSIONS_SOURCE="$SCRIPT_DIR/extensions.core.txt"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP_DIR="$USER_DIR/vscode-customization-backups/$TIMESTAMP"
LATEST_POINTER="$USER_DIR/vscode-customization-backups/latest.txt"

mkdir -p "$USER_DIR"

if [[ -f "$USER_DIR/settings.json" || -f "$USER_DIR/keybindings.json" ]]; then
  mkdir -p "$BACKUP_DIR"
  [[ -f "$USER_DIR/settings.json" ]] && cp "$USER_DIR/settings.json" "$BACKUP_DIR/settings.json"
  [[ -f "$USER_DIR/keybindings.json" ]] && cp "$USER_DIR/keybindings.json" "$BACKUP_DIR/keybindings.json"
  echo "$BACKUP_DIR" > "$LATEST_POINTER"
  echo "Backup created: $BACKUP_DIR"
fi

cp "$SETTINGS_SOURCE" "$USER_DIR/settings.json"
cp "$KEYBINDINGS_SOURCE" "$USER_DIR/keybindings.json"

echo "Applied settings and keybindings to: $USER_DIR"

if command -v code >/dev/null 2>&1; then
  echo "Installing extensions..."
  while IFS= read -r extension || [[ -n "$extension" ]]; do
    [[ -z "$extension" ]] && continue
    code --install-extension "$extension" >/dev/null || true
  done < "$EXTENSIONS_SOURCE"
  echo "Extensions installation step completed."
else
  echo "'code' CLI not found."
  echo "Install VS Code CLI and run again to auto-install extensions."
fi

echo "Done. Reload VS Code: Ctrl+Shift+P -> Developer: Reload Window"
echo "To rollback latest backup: ./vscode-customization/presets/restore-vscode.sh"
