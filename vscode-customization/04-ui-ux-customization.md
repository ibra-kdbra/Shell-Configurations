# VS Code UI/UX Rice Guide (Tokyo Night Storm)

Complete reference for the VS Code rice. This covers every visible UI element — from title bar to status bar, command palette to context menus, scrollbars to notifications.

---

## Prerequisites

### APC Customize UI++ Extension

The rice uses **APC Customize UI++** (`drcika.apc-extension`) to inject custom CSS into VS Code's Electron shell. This enables rounded corners, blur shadows, thin scrollbars, and panel transparency that `workbench.colorCustomizations` alone cannot achieve.

- **Install:** Already included in `presets/extensions.core.txt`
- **Linux permissions:** APC patches VS Code's internal files. You must grant write access:

```bash
sudo chown -R $(whoami) "$(which code | xargs dirname)/../"
# Or for AUR installs:
sudo chown -R $(whoami) /opt/visual-studio-code/
```

- **After every VS Code update:** Re-enable via `Ctrl+Shift+P` → `Enable Apc extension`
- **Windows (all-user install):** Run VS Code as Administrator once after install
- **macOS:** Usually works without extra permissions

### UI Font: Inter

The rice uses **Inter** for all non-editor UI text (sidebar, tabs, status bar, menus). The editor font remains JetBrains Mono.

| Platform | Install Command |
| --- | --- |
| **Arch Linux** | `pacman -S inter-font` |
| **Debian/Ubuntu** | `apt install fonts-inter` |
| **Fedora** | `dnf install google-noto-sans-fonts` (or download Inter) |
| **macOS** | `brew install --cask font-inter` |
| **Windows** | Download from [rsms.me/inter](https://rsms.me/inter/) |

### Compositor (for transparency)

The rice applies subtle transparency to the sidebar, panel, and title bar. This requires a compositor:

| Platform | Compositor | Notes |
| --- | --- | --- |
| **Linux (X11)** | Picom, Compton | Add `picom --backend glx &` to autostart |
| **Linux (Wayland)** | Hyprland, Sway, KWin, Mutter | Native compositor, works out of the box |
| **macOS** | Built-in | Native vibrancy via `apc.electron.vibrancy` |
| **Windows 11** | Built-in | Acrylic/Mica via `apc.electron.backgroundMaterial` (22H2+) |

> **Note:** On Linux, `apc.electron.opacity` is a no-op. Transparency comes from `"transparent": true` + `"backgroundColor": "#00000000"` combined with your compositor.

---

## What the Rice Changes

### Overview

| UI Region | What Changed |
| --- | --- |
| **Global** | Focus borders, shadows, sash colors, icon tint |
| **Title Bar** | Dark bg, blue accent on active, transparent border |
| **Activity Bar** | Dark bg, blue active indicator, rounded icon hover |
| **Sidebar** | Slightly transparent (#1f2335 @ 92% opacity), hidden borders |
| **Tabs** | Rounded top corners, blue top-border on active, dark inactive |
| **Panel** | Transparent bg, blue active tab underline |
| **Status Bar** | Dark bg, muted fg, yellow debug mode, blue remote indicator |
| **Scrollbars** | Thin (6px), rounded, semi-transparent slider |
| **Command Palette** | Rounded (12px), drop shadow, dark background |
| **Context Menus** | Rounded (8px), drop shadow |
| **Suggest Widget** | Rounded (8px), drop shadow, blue selection |
| **Hover Widget** | Rounded (8px), drop shadow |
| **Find Widget** | Bottom-rounded (8px), drop shadow |
| **Notifications** | Rounded items, themed icons |
| **Buttons** | Rounded (6px), blue primary, dark secondary |
| **Input Fields** | Rounded (6px), dark bg, blue focus ring |
| **Peek View** | Rounded (8px), blue border |
| **Diff Editor** | Green insertions, red deletions with low alpha |
| **Terminal** | Full 16-color ANSI palette matching Tokyo Night |
| **Menus** | Dark bg, blue selection, rounded |
| **Settings Editor** | Themed dropdowns, checkboxes, inputs |
| **Welcome Page** | Dark tiles, blue progress bar |
| **Badges** | Blue bg with dark text |
| **Keybinding Labels** | Dark bg with subtle border (3D effect) |

### APC Configuration

The presets include these APC settings:

```jsonc
{
  // Linux: transparent Electron window (needs compositor)
  // macOS: "vibrancy": "under-window", "opacity": 0.95
  // Windows: "backgroundMaterial": "acrylic"
  "apc.electron": { "transparent": true, "backgroundColor": "#00000000" },

  "apc.font.family": "Inter",            // UI font (not editor)
  "apc.header": { "height": 32, "fontSize": 12 },
  "apc.statusBar": { "height": 24, "fontSize": 11 },
  "apc.sidebar.titlebar": { "height": 30, "fontSize": 12 },
  "apc.listRow": { "height": 22, "fontSize": 12 },
}
```

### CSS Injection (apc.stylesheet)

These CSS rules are injected inline via `apc.stylesheet` in settings:

| CSS Selector | Effect |
| --- | --- |
| `.quick-input-widget` | Rounded command palette (12px), drop shadow |
| `.editor-widget.suggest-widget` | Rounded autocomplete (8px), drop shadow |
| `.monaco-editor .monaco-hover` | Rounded hover tooltip (8px), drop shadow |
| `.context-view .monaco-menu` | Rounded context menus (8px), drop shadow |
| `.scrollbar > .slider` | Rounded scrollbar thumb (6px) |
| `.find-widget` | Bottom-rounded find bar (8px), drop shadow |
| `.monaco-button` | Rounded buttons (6px) |
| `.monaco-inputbox` | Rounded inputs (6px) |
| `.notification-list-item` | Rounded notifications (8px), margin spacing |
| `.part.editor .title .tab` | Rounded tab tops (6px), 1px spacing |
| `.peekview-widget` | Rounded peek view (8px) |
| `.part.sidebar` | Transparency (92%), floating panel (4px gap, 8px radius) |
| `.part.panel` | Transparency (92%), floating panel (4px gap, 8px radius) |
| `.part.editor` | Floating editor (4px gap, 8px radius) |
| `.part.titlebar` | Subtle transparency (95% opacity) |
| `.part.statusbar` | Rounded top corners (8px), side margins |
| `*:focus` | Focus outline removed (kills grey accessibility box) |
| `.monaco-list-row.focused` | Focus outline removed |
| `.tab.active` | Focus outline removed |
| `.scrollbar.vertical` | Thin scrollbar (6px) |
| `.scrollbar.horizontal` | Thin scrollbar (6px) |

> **Note:** All rules above — including panel gaps, focus border removal, and thin scrollbars — are **enabled by default** in the preset files.

A standalone reference file with all CSS rules is available at `presets/rice.css`.

---

## Terminal ANSI Palette

Full 16-color terminal palette matching Tokyo Night Storm:

| Color | Normal | Bright | Hex (Normal) | Hex (Bright) |
| --- | --- | --- | --- | --- |
| **Black** | bg-dark | comment | `#16161e` | `#565f89` |
| **Red** | red | red | `#f7768e` | `#f7768e` |
| **Green** | green | green | `#9ece6a` | `#9ece6a` |
| **Yellow** | yellow | yellow | `#e0af68` | `#e0af68` |
| **Blue** | blue | blue | `#7aa2f7` | `#7aa2f7` |
| **Magenta** | magenta | magenta | `#bb9af7` | `#bb9af7` |
| **Cyan** | cyan | cyan | `#7dcfff` | `#7dcfff` |
| **White** | fg-dark | fg | `#a9b1d6` | `#c0caf5` |

---

## Color Palette Reference

The rice uses these base colors from the Tokyo Night Storm palette:

| Name | Hex | Usage |
| --- | --- | --- |
| `bg-dark` | `#16161e` | Deepest backgrounds (inactive title bar) |
| `bg` | `#1a1b26` | Primary chrome bg (activity bar, status bar, widgets) |
| `bg-hl` | `#24283b` | Editor background, active tab |
| `bg-hl2` | `#292e42` | Hover states, line highlight |
| `fg` | `#c0caf5` | Primary text |
| `fg-dark` | `#a9b1d6` | Secondary text (sidebar, descriptions) |
| `comment` | `#565f89` | Muted text (inactive tabs, line numbers, status bar) |
| `dark3` | `#3b4261` | Borders, separators, guides |
| `dark5` | `#737aa2` | Active line numbers |
| `blue` | `#7aa2f7` | Primary accent (active borders, badges, buttons) |
| `blue0` | `#3d59a1` | Selection bg, focus outlines, button bg |
| `cyan` | `#7dcfff` | Renamed files, bracket color 3 |
| `teal` | `#73daca` | Untracked files |
| `magenta` | `#bb9af7` | Bracket color 2, submodules |
| `green` | `#9ece6a` | Added files, diff insertions, success decorations |
| `yellow` | `#e0af68` | Modified borders, find matches, debug mode, warnings |
| `red` | `#f7768e` | Deleted files, diff removals, errors |

---

## Customization Tips

### Tweaks you can safely change

- **Larger tabs:** Set `"workbench.editor.tabHeight": "default"` and `"apc.header.height": 35`
- **More transparency:** Lower sidebar opacity to `0.85` in `apc.stylesheet`
- **Less transparency:** Set sidebar/panel opacity to `1.0` or remove those CSS rules
- **Disable APC CSS:** Remove the `apc.stylesheet` block entirely — color tokens still apply
- **Panel gaps:** Uncomment the optional rules in `presets/rice.css`
- **Autocomplete speed:** Lower `"editor.quickSuggestionsDelay"` to `10`
- **Hover delay:** Raise `"editor.hover.delay"` to `500`
- **Different UI font:** Change `"apc.font.family"` to any installed font

### Adding your own CSS

For advanced customization beyond what `apc.stylesheet` provides, use `apc.imports` to load an external CSS file:

```jsonc
"apc.imports": ["${userHome}/.config/Code/User/my-rice.css"]
```

The file is watched for live changes — edit and reload to see results immediately.

### Verification workflow

1. Apply presets with setup script (`setup-vscode.sh` or `setup-vscode.ps1`)
2. Reload window: `Ctrl+Shift+P` → `Developer: Reload Window`
3. Check these UI elements:
   - Command palette (`Ctrl+Shift+P`) — should be rounded with shadow
   - Quick open (`Ctrl+P`) — same styling
   - Right-click context menu — rounded with shadow
   - Autocomplete in any file — rounded suggest widget
   - Hover over a symbol — rounded hover tooltip
   - Find (`Ctrl+F`) — bottom-rounded find bar
   - Sidebar and panel — subtle transparency (with compositor)
   - Scrollbars — thin and rounded
   - Terminal — matching color palette, no border flash
4. Tune 1–2 settings at a time, reload between changes

---

## Troubleshooting

### APC breaks after VS Code update

VS Code patches its internal files on update, removing APC's modifications.

**Fix:** `Ctrl+Shift+P` → `Enable Apc extension` → reload window

### Permissions error on Linux

APC needs write access to VS Code's installation directory.

```bash
sudo chown -R $(whoami) /opt/visual-studio-code/
# Or wherever your VS Code is installed
```

### Transparency not working

- **Linux X11:** Ensure Picom or equivalent compositor is running
- **Linux Wayland:** Should work natively with Hyprland/Sway/KWin
- **macOS:** Works out of the box with `vibrancy` setting
- **Windows:** Requires Windows 11 22H2+ for `backgroundMaterial: "acrylic"`
- **Fallback:** Remove the transparency CSS rules from `apc.stylesheet` — the solid colors from `workbench.colorCustomizations` will apply cleanly

### CSS changes not applying

1. Check that APC extension is enabled
2. Try: `Ctrl+Shift+P` → `Enable Apc extension`
3. Fully restart VS Code (not just reload)
4. Verify `apc.stylesheet` JSON syntax is valid

### VS Code won't start after bad config

If incorrect `apc.electron` settings prevent launch:

1. Open `~/.config/Code/User/settings.json` in another editor
2. Remove the entire `"apc.electron": { ... }` block
3. Restart VS Code
4. Re-add settings carefully

---

## Low-Resource Mode

Low-resource mode strips all APC customization and expensive visuals for battery-conscious or weaker hardware.

### What it removes

- All `apc.*` settings (no CSS injection, no transparency)
- Bracket colorization, semantic highlighting, sticky scroll
- GPU acceleration, persistent terminal sessions
- Smooth scrolling, cursor animations

### What it keeps

- Color theme (Tokyo Night Storm)
- Icon theme (Material Icon Theme)
- Core formatting and keybindings
- Basic color customizations (quick input, dropdown)

### Toggle commands

Linux/macOS:

```bash
./vscode-customization/presets/toggle-low-resource.sh on
./vscode-customization/presets/toggle-low-resource.sh off
./vscode-customization/presets/toggle-low-resource.sh status
```

Windows:

```powershell
.\vscode-customization\presets\toggle-low-resource.ps1 -Mode on
.\vscode-customization\presets\toggle-low-resource.ps1 -Mode off
.\vscode-customization\presets\toggle-low-resource.ps1 -Mode status
```

### Monitor impact

- `Help > Open Process Explorer` — watch extension memory
- `Ctrl+Shift+P` → `Developer: Show Running Extensions` — extension load times
- Extension: `mutantdino.resourcemonitor` — CPU/RAM in status bar
