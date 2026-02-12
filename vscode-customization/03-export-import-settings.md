# Export / Import VS Code Setup (Profiles, Settings, Keybindings)

## Zero-Edit Setup (copy-paste for others)

Use the ready preset files in:

- `vscode-customization/presets/settings.linux.jsonc`
- `vscode-customization/presets/settings.windows.jsonc`
- `vscode-customization/presets/settings.macos.jsonc`
- `vscode-customization/presets/settings.low-resource.linux.jsonc`
- `vscode-customization/presets/settings.low-resource.windows.jsonc`
- `vscode-customization/presets/settings.low-resource.macos.jsonc`
- `vscode-customization/presets/keybindings.core.jsonc`
- `vscode-customization/presets/extensions.core.txt`
- `vscode-customization/presets/rice.css` (standalone CSS reference for APC injection)

**New:** Presets now include the full UI rice (APC Customize UI++, ~170 color tokens, CSS injection). See [04-ui-ux-customization.md](./04-ui-ux-customization.md) for setup prerequisites and troubleshooting.

Or just run the setup scripts:

- `vscode-customization/presets/setup-vscode.sh` (Linux/macOS)
- `vscode-customization/presets/setup-vscode.ps1` (Windows)
- `vscode-customization/presets/restore-vscode.sh` (Linux/macOS rollback)
- `vscode-customization/presets/restore-vscode.ps1` (Windows rollback)
- `vscode-customization/presets/toggle-low-resource.sh` (Linux/macOS mode toggle)
- `vscode-customization/presets/toggle-low-resource.ps1` (Windows mode toggle)

## Low-resource mode toggle (new)

Use this when battery life is more important than editor richness (lower GPU usage, lower terminal overhead, fewer heavy decorations).

### Toggle on Linux/macOS

```bash
./vscode-customization/presets/toggle-low-resource.sh on
./vscode-customization/presets/toggle-low-resource.sh status
./vscode-customization/presets/toggle-low-resource.sh off
```

### Toggle on Windows PowerShell

```powershell
.\vscode-customization\presets\toggle-low-resource.ps1 -Mode on
.\vscode-customization\presets\toggle-low-resource.ps1 -Mode status
.\vscode-customization\presets\toggle-low-resource.ps1 -Mode off
```

Notes:

- Toggle scripts keep snapshots under `.../Code/User/vscode-customization-mode/backups/`.
- Turning mode **off** restores the previous settings snapshot if available.
- Also available via workspace tasks in `.vscode/tasks.json`.

### Fastest way (recommended)

From repo root:

#### Linux/macOS

```bash
./vscode-customization/presets/setup-vscode.sh
```

#### Windows PowerShell

```powershell
.\vscode-customization\presets\setup-vscode.ps1
```

Optional (skip extension install):

```powershell
.\vscode-customization\presets\setup-vscode.ps1 -SkipExtensions
```

### Built-in backup + rollback

Both setup scripts now create timestamped backups automatically before overwrite:

- Linux/macOS backup root: `~/.config/Code/User/vscode-customization-backups/` (Linux)
- macOS backup root: `~/Library/Application Support/Code/User/vscode-customization-backups/`
- Windows backup root: `%APPDATA%\Code\User\vscode-customization-backups\`

Rollback commands:

#### Linux/macOS rollback

```bash
./vscode-customization/presets/restore-vscode.sh
```

#### Windows rollback

```powershell
.\vscode-customization\presets\restore-vscode.ps1
```

### Apply in 2 minutes (Linux)

Run from repo root:

```bash
mkdir -p ~/.config/Code/User
cp vscode-customization/presets/settings.linux.jsonc ~/.config/Code/User/settings.json
cp vscode-customization/presets/keybindings.core.jsonc ~/.config/Code/User/keybindings.json
cat vscode-customization/presets/extensions.core.txt | xargs -L 1 code --install-extension
```

### Apply in 2 minutes (Windows PowerShell)

Run from repo root:

```powershell
New-Item -ItemType Directory -Force "$env:APPDATA\Code\User" | Out-Null
Copy-Item "vscode-customization/presets/settings.windows.jsonc" "$env:APPDATA\Code\User\settings.json" -Force
Copy-Item "vscode-customization/presets/keybindings.core.jsonc" "$env:APPDATA\Code\User\keybindings.json" -Force
Get-Content "vscode-customization/presets/extensions.core.txt" | ForEach-Object { code --install-extension $_ }
```

### Apply in 2 minutes (macOS)

Run from repo root:

```bash
mkdir -p "$HOME/Library/Application Support/Code/User"
cp vscode-customization/presets/settings.macos.jsonc "$HOME/Library/Application Support/Code/User/settings.json"
cp vscode-customization/presets/keybindings.core.jsonc "$HOME/Library/Application Support/Code/User/keybindings.json"
cat vscode-customization/presets/extensions.core.txt | xargs -L 1 code --install-extension
```

### Final step for all OS

- Reload VS Code: `Ctrl+Shift+P` → `Developer: Reload Window`
- **APC (Linux/macOS):** Run `sudo chown -R $(whoami) "$(which code | xargs dirname)/../"` then `Ctrl+Shift+P` → `Enable Apc extension`
- **APC (after VS Code updates):** Re-enable via `Ctrl+Shift+P` → `Enable Apc extension` — VS Code updates overwrite APC's patches
- Optional: turn on Settings Sync after import

## Best method (cross-OS): Settings Sync

1. Open Command Palette: `Ctrl+Shift+P`
2. Run: `Settings Sync: Turn On`
3. Sign in with GitHub or Microsoft
4. Choose what to sync:
   - Settings
   - Keybindings
   - Extensions
   - Snippets
   - UI state

Works across Linux, Debian, Windows, macOS.

## If users are not on the same Linux build

That is completely fine. VS Code config is mostly portable across distros.

Use this order:

1. Import Profile (or enable Settings Sync)
2. Install missing extensions
3. Fix OS-specific settings only (terminal shell path, browser path, toolchain paths)

Most settings will work unchanged on Arch, Debian, Ubuntu, Fedora, etc.

## Cross-OS compatibility checklist

When moving config between Linux and Windows/macOS, review these keys first:

- `terminal.integrated.defaultProfile.linux`
- `terminal.integrated.profiles.linux`
- Any absolute paths like `/usr/bin/...` or `C:\\...`
- External tool paths (Java, CMake, compiler, debugger)
- Browser paths in extension settings

Keep these portable:

- Theme, font, editor behavior, keybindings, snippets
- Language settings (`[typescript]`, `[python]`, etc.)
- Lint/format settings

Usually not portable without edits:

- Shell executable paths
- System-specific runtime flags
- OS package manager commands

## Recommended team approach (Linux + Windows)

Use this split to avoid breakage:

- Put universal settings in user/profile settings
- Put project standards in `.vscode/settings.json`
- Avoid hardcoded machine paths in workspace files
- Keep OS-specific shell settings in personal user settings only

## Quick fixes after import

### Linux users (any distro)

- If `zsh` path fails, switch to available shell:
  - `terminal.integrated.defaultProfile.linux`: `bash` or `fish`
- Reinstall distro-specific tools (e.g., `clangd`, `cmake`, `java`, `gdb`)

### Windows users

- Set terminal profile to `PowerShell` or `Git Bash`
- Replace Linux paths (`/usr/bin/...`) with Windows paths when needed
- Ensure `code` command is available in PATH (Command Palette → `Shell Command: Install 'code' command in PATH` when supported)

### macOS users

- Use `zsh` default shell profile
- Repoint any Linux-specific paths to macOS equivalents

## Profile portability tip

Export multiple profiles for different environments:

- `Core-Portable` (theme, editor, keybindings, snippets)
- `Linux-Dev` (Linux shell/tool paths)
- `Windows-Dev` (PowerShell/Git Bash/tool paths)

This prevents one profile from breaking on another OS.

## Profile export/import

1. `Ctrl+Shift+P` → `Profiles: Export Profile...`
2. Save profile file (JSON)
3. On another machine: `Profiles: Import Profile...`

Good for sharing exact setup per role (Web/C++/Java/DevOps).

## Manual backup (portable)

Backup these folders/files:

### Linux

- `~/.config/Code/User/settings.json`
- `~/.config/Code/User/keybindings.json`
- `~/.config/Code/User/snippets/`

### Windows

- `%APPDATA%\Code\User\settings.json`
- `%APPDATA%\Code\User\keybindings.json`
- `%APPDATA%\Code\User\snippets\`

### macOS

- `~/Library/Application Support/Code/User/settings.json`
- `~/Library/Application Support/Code/User/keybindings.json`
- `~/Library/Application Support/Code/User/snippets/`

## Extension list export/import

### Export

```bash
code --list-extensions > extensions.txt
```

### Import (Linux/macOS)

```bash
cat extensions.txt | xargs -L 1 code --install-extension
```

### Import (Windows PowerShell)

```powershell
Get-Content .\extensions.txt | ForEach-Object { code --install-extension $_ }
```
