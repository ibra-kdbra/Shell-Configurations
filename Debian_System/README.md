# Debian System - Suckless Software Setup

This directory contains a complete minimal configuration for Debian using the Suckless software suite. It provides a fast, lightweight, and highly customizable X11 desktop environment focused on tiling window management, efficiency, and minimalism.

## Overview

This setup transforms a base Debian installation into a productive desktop environment featuring:
- DWM: Extreme fast and dynamic tiling window manager
- Alacritty: GPU-accelerated terminal emulator
- Dmenu: Efficient application launcher
- Dwmblocks: Modular status bar system
- Sxhkd: Simple and fast hotkey daemon
- Custom status scripts for system monitoring

## Directories

- **alacrity/**: Alacritty configuration file (alacritty.yml) for terminal customization
- **bin/**: Status indicator scripts used by dwmblocks:
  - `alert_battery`: Battery alert notifications
  - `audio`: Audio control script
  - `battery`: Battery status display
  - `clock`: Current time display
  - `empty`: Placeholder script
  - `pacupdate`: Package update checker
  - `volume`: Volume control script
  - `web`: Web browser shortcuts
  - `scripts/`: Additional utility scripts
- **dmenu/**: Dmenu application launcher with source code, configuration headers, and compiled binaries
- **DWM/**: Dynamic Window Manager source code, custom configuration, and compiled binaries
- **DWM_BLOCKS/**: Dwmblocks status bar with modular blocks source and binaries
- **sxhkd/**: Sxhkd hotkey daemon configuration file (sxhkdrc)

## Dependencies

Install required development packages:
```bash
sudo apt update
sudo apt install build-essential libx11-dev libxft-dev libxinerama-dev libharfbuzz-dev
```

For additional features:
```bash
sudo apt install libxext-dev libxcb1-dev libxcb-randr0-dev
```

## Installation

1. Compile and install each component (run as root if needed):
   ```bash
   cd dmenu && make clean install
   cd ../DWM && make clean install
   cd ../DWM_BLOCKS && make clean install
   ```

2. Copy configuration files to your home directory:
   ```bash
   mkdir -p ~/.config/alacritty
   cp alacritty/alacritty.yml ~/.config/alacritty/
   cp -r bin ~/bin_debian  # Or integrate into PATH
   cp sxhkd/sxhkdrc ~/.config/sxhkdrc
   ```

3. Set up X session by adding to your `.xinitrc` or display manager:
   ```bash
   sxhkd &
   dwmblocks &
   exec dwm
   ```

4. Start X with `startx` or select DWM from your login manager.

## Usage

- Windows are managed in a master-stack tiling layout by default.
- Use dmenu (launched by hotkey) for application launching.
- Dwmblocks displays system info on the status bar.
- Sxhkd handles custom keybindings defined in sxhkdrc.
- Customize behavior by editing `config.h` files and recompiling.

## Customization

All Suckless tools are patched and configured via `config.h` files:
- Edit `DWM/config.h` for window manager settings (keybinds, borders, layouts).
- Modify `DWM_BLOCKS/blocks.h` to change status bar modules.
- Update `sxhkd/sxhkdrc` for hotkey combinations.
- Recompile after changes: `make clean install`

## Proxy Configuration (Enterprise Networks)

If your environment requires proxy settings:
```bash
export ALL_PROXY=172.30.1.254:3128
export http_proxy=http://$ALL_PROXY
export https_proxy=https://$ALL_PROXY
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$http_proxy
```

## Notes and Warnings

- These tools follow the Suckless philosophy: simple, minimal, source-available, and suck fewer resources.
- Always backup configurations before rebuilding.
- Scripts in bin/ may require adjustments for your specific hardware (battery paths, audio devices).
- Sxhkd must be running for keyboard shortcuts to work.
- This setup assumes a basic Xorg installation; ensure your graphics drivers are properly configured.

## Resources

- [DWM - suckless.org](https://dwm.suckless.org/)
- [Dmenu - suckless.org](https://tools.suckless.org/dmenu/)
- [Alacritty - alacritty.org](https://alacritty.org/)
- [Dwmblocks - suckless.org](https://dwm.suckless.org/status_monitor/)

This configuration provides a solid foundation for efficient computing on Debian Linux.
