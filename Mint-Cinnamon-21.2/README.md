# Linux Mint Cinnamon 21.2 Customization Suite

A collection of bash scripts to customize Linux Mint Cinnamon 21.2 according to personal preferences. This setup focuses on removing unwanted default packages, installing alternative software, and configuring a lightweight tiling window manager environment.

## Overview

This customization suite transforms a fresh Linux Mint Cinnamon 21.2 installation into a personalized desktop environment with:
- Alternative applications replacing default ones
- Lightweight tiling window manager (Chadwm)
- Custom themes and icons
- Development tools (VS Code, Git)
- Productivity tools (Alacritty terminal, Flameshot screenshot tool)
- File sharing capabilities (Samba)
- Personal configuration backups

## Scripts

Run the scripts in numerical order for a complete setup, or execute individual scripts as needed.

- **0-current-selection.sh**: Master installation script that runs all primary setup scripts (1-8 and 900)
- **1-remove-apt-packages.sh**: Removes unwanted default packages (Hexchat, Transmission, LibreOffice, Celluloid, etc.)
- **2-install-apt-packages.sh**: Installs core alternative packages (Alacritty, Flameshot, Picom, MPD, i3lock, etc.)
- **3-install-keys-add-repos-packages.sh**: Adds third-party repositories and installs browsers/apps (Vivaldi, Google Chrome, Brave, VS Code)
- **4-install-chadwm-extras.sh**: Installs additional dependencies for Chadwm window manager
- **5-install-chadwm.sh**: Compiles and installs Chadwm tiling window manager
- **6-install-candy-icons.sh**: Installs Candy icon theme
- **7-install-sardi-surfn-icons.sh**: Installs Sardi/Surfn icon themes
- **8-install-samba.sh**: Configures Samba for network file sharing
- **900-install-personal-settings-folders.sh**: Backs up current settings and applies personal configurations
- **install-zsh-v1.sh**: Installs and configures Zsh shell
- **setup-git-v5.sh**: Configures Git with personal settings
- **up.sh**: Update packages from all repositories

## Directories

- **arco-chadwm/**: Chadwm window manager configuration and related tools (based on ArcoLinux scripts)
- **deb/**: Desktop files for installing .deb packages (Discord, GitFiend, Insync, Pacstall)
- **personal/**: Personal configuration files for Bash, Thunar file manager, and Variety wallpaper changer

## Usage

1. Clone or download this repository to your Linux Mint system.
2. Run the scripts with sudo permissions:
   ```bash
   chmod +x *.sh
   sudo ./1-remove-apt-packages.sh  # Remove unwanted software first
   # Continue with subsequent scripts or run them all via 0-current-selection.sh
   ```
3. Reboot after completing the installation, and select Chadwm as the window manager if desired.

## Warnings

- These scripts make significant changes to your system package manager and may remove software you want to keep.
- Review and understand each script before running.
- Backup important data before proceeding.
- Scripts are provided as-is; use at your own risk.

## Requirements

- Linux Mint Cinnamon 21.2
- Internet connection for downloading packages
- Administrator (sudo) privileges

