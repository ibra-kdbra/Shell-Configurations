#!/bin/bash
# Script to update mirrors and clean package cache

# Auto-detect script directory and set log path
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
LOG="$SCRIPT_DIR/logs/sys_maintenance.log"
mkdir -p "$SCRIPT_DIR/logs"

echo "--- Starting Maintenance: $(date) ---" >> "$LOG"

# Clean pacman cache (keeps only the last 2 versions)
/usr/bin/paccache -r -k 2 >> "$LOG" 2>&1

# Update mirrors (Top 10 fastest HTTPS mirrors)
/usr/bin/reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist >> "$LOG" 2>&1

echo "--- Finished Maintenance: $(date) ---" >> "$LOG"
