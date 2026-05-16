#!/bin/bash
# Script to clean up developer environment caches

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
LOG="$SCRIPT_DIR/logs/dev_cleanup.log"
mkdir -p "$SCRIPT_DIR/logs"

echo "--- Dev Cleanup: $(date) ---" >> "$LOG"

# Clean Pip cache (older than 30 days)
/usr/bin/find ~/.cache/pip -type f -atime +30 -delete >> "$LOG" 2>&1

# Clean HuggingFace Hub cache (older than 30 days)
/usr/bin/find ~/.cache/huggingface/hub -type f -atime +30 -delete >> "$LOG" 2>&1

# Prune Docker (removes dangling images/containers)
if pgrep -x "dockerd" > /dev/null; then
    /usr/bin/docker system prune -f >> "$LOG" 2>&1
fi

echo "--- Cleanup Done: $(date) ---" >> "$LOG"
