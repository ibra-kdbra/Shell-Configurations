# Arch Linux Cron Automation Suite

This directory contains a suite of shell scripts designed to automate system maintenance, development cache cleanups, security auditing, and project backups on Arch Linux.

By keeping these scripts in your centralized shell configurations repository, you can track changes in Git while maintaining a clean, predictable, and robust automation schedule.

---

## Directory Structure

All files reside inside the `cron/` directory:
```text
cron/
├── README.md             # This documentation
└── scripts/
    ├── backup_projects.sh
    ├── dev_cleanup.sh
    ├── security_audit.sh
    ├── sys_maintenance.sh
    └── logs/             # Created automatically by scripts
        ├── backup.log
        ├── dev_cleanup.log
        ├── security_report.log
        └── sys_maintenance.log
```

### Git Ignored Logs
To keep runtime logs out of version control, ensure `cron/scripts/logs/` is added to your repository's `.gitignore` file:
```text
cron/scripts/logs/
```

---

## The Automation Scripts

Each script is designed to be **portable** and **self-contained**. They automatically discover their execution directory, create their own `logs` subfolder if missing, and output details cleanly.

### 1. System Maintenance (Root Level)
* **File:** [sys_maintenance.sh](./scripts/sys_maintenance.sh)
* **Log:** `logs/sys_maintenance.log`
* **Purpose:** Cleans the system package cache (retains only the last 2 versions to save disk space) and updates the system mirror list to the top 10 fastest HTTPS mirrors.

### 2. AI & Dev Janitor (User Level)
* **File:** [dev_cleanup.sh](./scripts/dev_cleanup.sh)
* **Log:** `logs/dev_cleanup.log`
* **Purpose:** Deletes cached files from Pip and HuggingFace Hub that haven't been accessed in over 30 days. It also prunes dangling Docker containers and images.

### 3. Security Auditor (Root Level)
* **File:** [security_audit.sh](./scripts/security_audit.sh)
* **Log:** `logs/security_report.log`
* **Purpose:** Runs `arch-audit` to detect known vulnerabilities (CVEs) in installed packages and extracts failed SSH login password attempts from the last 24 hours.

### 4. Project Redundancy (User Level)
* **File:** [backup_projects.sh](./scripts/backup_projects.sh)
* **Log:** `logs/backup.log`
* **Purpose:** Uses `rsync` to back up and mirror your development projects directory to your external backup partition.

---

## Implementation & Security

These scripts are active and configured under two separate crontabs. 

> [!NOTE]
> In the crontab entries below, replace `<path-to-workspace>` with the actual absolute path to your cloned repository on your system (e.g., `/home/username/Workspace/Personal/Shell-Configurations`).

### 1. Root Crontab (`sudo crontab -l`)
Handles administrative scripts requiring root privileges:
```cron
# Every Monday at 3:00 AM: Mirrors and Pacman Cleanup
0 3 * * 1 <path-to-workspace>/cron/scripts/sys_maintenance.sh

# Every day at 8:00 AM: Security Audit
0 8 * * * <path-to-workspace>/cron/scripts/security_audit.sh
```

> [!WARNING]
> **Security Hardening:** Because the root crontab executes these scripts with administrative privileges, their ownership has been restricted to `root` using `sudo chown root:root`. This prevents unprivileged users or user-level processes from modifying them.

### 2. User Crontab (`crontab -l`)
Handles user-level scripts that do not require elevated privileges:
```cron
# Every Sunday at 4:00 AM: AI/Dev Cache Cleanup
0 4 * * 0 <path-to-workspace>/cron/scripts/dev_cleanup.sh

# Every night at Midnight: Project Backup
0 0 * * * <path-to-workspace>/cron/scripts/backup_projects.sh
```

---

## Testing & Manual Execution

All scripts can be run independently at any time.

### Executable Permissions
To ensure they run, make sure the executable bit is set:
```bash
chmod +x <path-to-workspace>/cron/scripts/*.sh
```

### Run Manually
You can test any script manually by executing its absolute path:
```bash
# Test User tasks
<path-to-workspace>/cron/scripts/dev_cleanup.sh
<path-to-workspace>/cron/scripts/backup_projects.sh

# Test Root tasks
sudo <path-to-workspace>/cron/scripts/sys_maintenance.sh
sudo <path-to-workspace>/cron/scripts/security_audit.sh
```
Check the generated log files inside `<path-to-workspace>/cron/scripts/logs/` to verify successful execution.
