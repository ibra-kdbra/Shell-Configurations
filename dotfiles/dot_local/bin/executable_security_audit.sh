#!/bin/bash
set -euo pipefail
# Script to run security audit & check failed login attempts

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
LOG="$SCRIPT_DIR/logs/security_report.log"
mkdir -p "$SCRIPT_DIR/logs"

echo "--- Security Audit: $(date) ---" >> "$LOG"

# Check for package vulnerabilities (requires 'arch-audit' package)
echo "[Vulnerability Report]" >> "$LOG"
/usr/bin/arch-audit >> "$LOG" 2>&1

# Report failed SSH logins in the last 24 hours
echo "[Failed Logins - Last 24hrs]" >> "$LOG"
/usr/bin/journalctl -u sshd --since "24 hours ago" | grep "Failed password" >> "$LOG"

echo "--- Audit Complete ---" >> "$LOG"
