# Game Converter - Shell Script GUI for Game Format Conversions

Game Converter is a user-friendly GUI application for converting various game disc image formats using chdman and ciso. It supports both single-file and batch conversions with Zenity dialogs for easy operation.

## Features

- **Single or Batch Conversions**: Process individual files or entire directories
- **CHDMAN Support**:
  - Convert cue, gdi, or toc files to CHD (MAME compressed format)
  - Option to use CHDman v4 (0.145) or v5 (0.221)
- **CHD Extractions**:
  - Convert CHD to gdi/bin/raw format (creates game-named folders)
  - Convert CHD to bin/cue format (creates game-named folders)
- **CISO Support**:
  - Convert ISO to CSO with 9 compression levels (1-9, where 1 is fastest/low compression, 9 is slowest/high compression)
  - Convert CSO back to ISO (uncompress)
- **Safety Features**:
  - Never overwrites existing files or folders
  - Automatically deletes incomplete conversions when canceled
- **Desktop Integration**: Creates menu shortcut under Accessories > Game Converter

## Directory Contents

- `chdman4` & `chdman5`: Pre-compiled chdman binaries for Linux
- `game-converter.desktop`: Desktop menu shortcut file
- `game-converter.png`: Application icon
- `game-converter.sh`: Main script file

## Dependencies

Ensure the following packages are installed:
- `ciso`: For ISO ↔ CSO conversions
- `libsdl1.2debian`: Required for chdman
- `zenity`: For GUI dialogs

On Debian/Ubuntu-based systems:
```bash
sudo apt update && sudo apt install libsdl1.2debian zenity
# Install ciso (may require manual compilation or PPA)
```

## Installation

1. Download or clone this repository
2. Make the script executable:
   ```bash
   chmod +x game-converter.sh
   ```
3. Run the script, which will create the desktop shortcut and required directories:
   ```bash
   ./game-converter.sh
   ```
4. Alternatively, install globally:
   ```bash
   sudo mkdir -p /usr/share/game-converter
   sudo cp chdman4 chdman5 game-converter.sh /usr/share/game-converter/
   sudo cp game-converter.desktop /usr/share/applications/
   sudo cp game-converter.png /usr/share/icons/hicolor/48x48/apps/
   ```

## Usage

Launch Game Converter from your desktop menu or run:
```bash
./game-converter.sh
```

Select conversion type (single file or batch) and format through intuitive Zenity dialogs. Cancellations safely remove incomplete files.

## Tested On

- Linux Mint (primary development system)

Feedback welcome for other distributions!

## Development Notes

### TODO/List

- **Progress Bar Enhancement**: The progress bar for single CHD conversions currently pulsates. Improvement needed to show actual percentage by parsing chdman's stderr output in real-time (writing current line to temp file and extracting percentage).