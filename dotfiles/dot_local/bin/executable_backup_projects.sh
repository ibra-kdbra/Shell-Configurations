#!/bin/bash
set -euo pipefail
# Backup to an external drive or a different partition

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
LOG="$SCRIPT_DIR/logs/backup.log"
mkdir -p "$SCRIPT_DIR/logs"

SOURCE="$HOME/Documents/Projects"
DEST="/run/media/$USER/BackupDrive/Projects_Mirror"

if [ -d "$DEST" ]; then
    /usr/bin/rsync -av --delete "$SOURCE" "$DEST" > "$LOG" 2>&1
else
    echo "Backup Drive not found at $(date)" >> "$LOG"
fi
