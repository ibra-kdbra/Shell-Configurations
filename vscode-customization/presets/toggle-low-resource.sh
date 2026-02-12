#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="${1:-status}"
OS_NAME="$(uname -s)"

case "$OS_NAME" in
  Linux)
    USER_DIR="$HOME/.config/Code/User"
    NORMAL_SETTINGS="$SCRIPT_DIR/settings.linux.jsonc"
    LOW_SETTINGS="$SCRIPT_DIR/settings.low-resource.linux.jsonc"
    ;;
  Darwin)
    USER_DIR="$HOME/Library/Application Support/Code/User"
    NORMAL_SETTINGS="$SCRIPT_DIR/settings.macos.jsonc"
    LOW_SETTINGS="$SCRIPT_DIR/settings.low-resource.macos.jsonc"
    ;;
  *)
    echo "Unsupported OS: $OS_NAME"
    echo "Use toggle-low-resource.ps1 on Windows."
    exit 1
    ;;
esac

mkdir -p "$USER_DIR"

MODE_DIR="$USER_DIR/vscode-customization-mode"
BACKUP_DIR="$MODE_DIR/backups"
MODE_FILE="$MODE_DIR/current-mode.txt"
PREV_FILE="$MODE_DIR/previous-settings.json"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

mkdir -p "$BACKUP_DIR"

current_mode() {
  if [[ -f "$MODE_FILE" ]]; then
    cat "$MODE_FILE"
  else
    echo "normal"
  fi
}

set_mode() {
  echo "$1" > "$MODE_FILE"
}

save_previous_if_needed() {
  if [[ -f "$USER_DIR/settings.json" && ! -f "$PREV_FILE" ]]; then
    cp "$USER_DIR/settings.json" "$PREV_FILE"
  fi
}

snapshot() {
  if [[ -f "$USER_DIR/settings.json" ]]; then
    cp "$USER_DIR/settings.json" "$BACKUP_DIR/settings.$TIMESTAMP.json"
  fi
}

case "$MODE" in
  on)
    save_previous_if_needed
    snapshot
    cp "$LOW_SETTINGS" "$USER_DIR/settings.json"
    set_mode "low-resource"
    echo "Low-resource mode: ON"
    echo "Applied: $LOW_SETTINGS"
    ;;
  off)
    snapshot
    if [[ -f "$PREV_FILE" ]]; then
      cp "$PREV_FILE" "$USER_DIR/settings.json"
      rm -f "$PREV_FILE"
      echo "Restored previous settings snapshot."
    else
      cp "$NORMAL_SETTINGS" "$USER_DIR/settings.json"
      echo "No previous snapshot found. Applied normal preset instead."
      echo "Applied: $NORMAL_SETTINGS"
    fi
    set_mode "normal"
    echo "Low-resource mode: OFF"
    ;;
  status)
    echo "Current mode: $(current_mode)"
    echo "Mode data dir: $MODE_DIR"
    ;;
  *)
    echo "Usage: $0 [on|off|status]"
    exit 1
    ;;
esac

echo "Reload VS Code: Ctrl+Shift+P -> Developer: Reload Window"
