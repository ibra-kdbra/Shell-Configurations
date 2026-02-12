# The Professional VS Code Engineering Blueprint

This plan combines aesthetic refinement with the performance-driven requirements of an **Arch Linux** user. It focuses on maximizing productivity, minimizing RAM bloat via **Profiles**, and optimizing the Chromium-based engine that powers VS Code.

---

## 1. System & Binary Optimization

Before touching the UI, optimize how the application interacts with your Linux kernel.

- **Native AUR Build:** Avoid Flatpaks/Snaps. Use `visual-studio-code-bin` from the AUR for lower overhead and better system integration.
- **Runtime Tuning:** Open the Command Palette (`Ctrl+Shift+P`) and search for **"Configure Runtime Arguments"**. Edit `argv.json` to throttle background processes:

```json
{
  "disable-hardware-acceleration": false,
  "max-renderer-process-count": 4,
  "enable-crashpad": false,
  "password-store": "gnome-libsecret"
}
```

- **Wayland Users (Hyprland/Sway):** Add these flags to your desktop entry or alias for native Wayland rendering:

```bash
code --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland
```

- **Process Monitoring:** Use the built-in **Process Explorer** (`Help > Open Process Explorer`) to identify which extensions are leaking memory in real-time.

- **Memory Management:** VS Code can be memory-hungry. Use these environment variables in your shell config:

```bash
export ELECTRON_TRASH=gio
export NODE_OPTIONS="--max-old-space-size=4096"
```

---

## 2. Resource-Conscious UI/UX

A professional setup is clean, high-contrast, and removes "visual noise" that consumes CPU cycles.

### Theme & Typography

- **The Theme:** **Tokyo Night Storm**. High contrast, muted yet readable palette, optimized for long-term focus. All preset files and the UI rice target this theme.
- **The Font:** **JetBrains Mono** or **Fira Code** (install via `pacman -S ttf-jetbrains-mono`).
- _Why:_ Ligatures (`=>` becoming `⇒`) reduce cognitive load by making operators distinct symbols.

- **Icon Set:** **Material Icon Theme**—it is the industry standard for identifying file types at a glance.

### Advanced Editor Color Customizations

VS Code allows deep customization of every UI element. Add these to your `settings.json` for a polished Tokyo Night experience:

```json
{
  "workbench.colorCustomizations": {
    // Selection & Highlights
    "editor.selectionBackground": "#3d59a166",
    "editor.selectionHighlightBackground": "#3d59a133",
    "editor.wordHighlightBackground": "#3949ab50",
    "editor.findMatchBackground": "#ffcb6b40",
    "editor.lineHighlightBackground": "#1e2030",

    // Bracket Colors (rainbow brackets built-in)
    "editorBracketHighlight.foreground1": "#7aa2f7",
    "editorBracketHighlight.foreground2": "#bb9af7",
    "editorBracketHighlight.foreground3": "#7dcfff",
    "editorBracketHighlight.foreground4": "#9ece6a",
    "editorBracketHighlight.foreground5": "#e0af68",
    "editorBracketHighlight.foreground6": "#f7768e",

    // Git Decorations in File Explorer
    "gitDecoration.addedResourceForeground": "#9ece6a",
    "gitDecoration.modifiedResourceForeground": "#7aa2f7",
    "gitDecoration.deletedResourceForeground": "#f7768e",
    "gitDecoration.untrackedResourceForeground": "#7dcfff",

    // Tab & Status Bar accents
    "tab.activeBorder": "#7aa2f7",
    "statusBarItem.remoteBackground": "#7aa2f7"
  }
}
```

### Semantic Syntax Highlighting

Enable semantic highlighting for smarter, context-aware colorization that goes beyond TextMate grammars:

```json
{
  "editor.semanticHighlighting.enabled": true,
  "editor.semanticTokenColorCustomizations": {
    "[Tokyo Night Storm]": {
      "enabled": true,
      "rules": {
        "function": { "foreground": "#7aa2f7", "fontStyle": "bold" },
        "parameter": { "foreground": "#e0af68", "fontStyle": "italic" },
        "variable.readonly": { "foreground": "#bb9af7" },
        "type": { "foreground": "#2ac3de" },
        "interface": { "foreground": "#2ac3de", "fontStyle": "italic" },
        "class": { "foreground": "#2ac3de", "fontStyle": "bold" }
      }
    }
  },
  "editor.tokenColorCustomizations": {
    "[Tokyo Night Storm]": {
      "textMateRules": [
        {
          "scope": ["comment"],
          "settings": { "fontStyle": "italic", "foreground": "#565f89" }
        },
        {
          "scope": ["keyword.control"],
          "settings": { "fontStyle": "italic" }
        },
        {
          "scope": ["entity.name.function"],
          "settings": { "fontStyle": "bold" }
        }
      ]
    }
  }
}
```

### Visual Hierarchy Tips

| Element              | Styling                     | Purpose                            |
| -------------------- | --------------------------- | ---------------------------------- |
| **Comments**         | Italic, dimmed              | Clearly non-code                   |
| **Functions**        | Bold                        | Easy to spot declarations          |
| **Parameters**       | Italic, warm color          | Distinguish from local vars        |
| **Constants**        | Bold                        | Immutable values stand out         |
| **Types/Interfaces** | Underline or distinct color | Type system visibility             |
| **Keywords**         | Italic                      | Language constructs feel "special" |

### Ergonomic Layout

- **Move Sidebar to Right:** `workbench.sideBar.location: "right"`. This prevents your code from "jumping" horizontally when you toggle the file explorer.
- **Disable Minimap:** It’s a separate render process that eats RAM. Use **Sticky Scroll** instead to keep track of your location in the code.
- **Enable Breadcrumbs:** Essential for navigating large codebases—shows file path and symbol hierarchy at the top of the editor.
- **Hide Command Center:** Remove title bar clutter by disabling `window.commandCenter`—you already use `Ctrl+Shift+P`.
- **Tab Indicators:** Enable `workbench.editor.highlightModifiedTabs` for instant visual feedback on unsaved files.
- **Inlay Hints:** Use `"editor.inlayHints.enabled": "onUnlessPressed"` to see type information from LSPs without cluttering your view.

### Deep Rice (APC Customize UI++)

For users who want to go beyond VS Code's built-in theming:

- **APC Customize UI++** (`drcika.apc-extension`): Injects custom CSS into VS Code's Electron shell. Enables rounded corners on command palette, suggest widgets, context menus, thin scrollbars, panel transparency, and compact headers.
- **UI Font:** **Inter** for all non-editor chrome (sidebar, tabs, status bar, menus). The editor font remains JetBrains Mono.
- **Transparency:** Subtle transparency on sidebar (92%), panel (92%), and title bar (95%). Requires a compositor on Linux (Picom, Hyprland, KWin).
- **Color Tokens:** ~170 `workbench.colorCustomizations` tokens covering every UI region from title bar to terminal ANSI palette.
- **CSS Injection:** Rounded corners (12px command palette, 8px widgets/menus, 6px buttons/inputs), drop shadows, thin scrollbars via `apc.stylesheet`.

> **Full reference:** See [04-ui-ux-customization.md](./04-ui-ux-customization.md) for the complete color token map, CSS selector reference, troubleshooting, and setup instructions.

## 3. Extension Management (The "Profile" Strategy)

Do not install extensions globally. This is the primary cause of high RAM usage.

### Creating Profiles

1. Open Command Palette → `Profiles: Create Profile`
2. Name it descriptively (e.g., "Web-Dev", "Backend-Rust")
3. Install only the extensions needed for that workflow
4. Switch via `Profiles: Switch Profile` or the gear icon in the bottom-left

### Recommended Profile Setup

#### Base Profile (Always Active)

Minimal extensions that apply everywhere:

| Extension          | Purpose                            | Performance Impact        |
| ------------------ | ---------------------------------- | ------------------------- |
| **EditorConfig**   | Consistent formatting across teams | Negligible                |
| **GitLens**        | Git blame, history, compare        | Medium (disable CodeLens) |
| **Error Lens**     | Inline diagnostics                 | Low                       |
| **GitHub Copilot** | AI pair programming                | Medium                    |

#### Web Profile (React/Vue/Node.js)

| Extension                     | Purpose                       |
| ----------------------------- | ----------------------------- |
| **ESLint**                    | JavaScript/TypeScript linting |
| **Prettier**                  | Code formatting               |
| **Tailwind CSS IntelliSense** | Class autocompletion          |
| **Auto Rename Tag**           | Sync HTML/JSX tag pairs       |
| **Thunder Client**            | Lightweight REST client       |
| **ES7+ React Snippets**       | React boilerplate shortcuts   |

#### Backend Profile (Rust/Go/Python)

| Extension            | Purpose                         |
| -------------------- | ------------------------------- |
| **rust-analyzer**    | Rust LSP (best-in-class)        |
| **Go**               | Official Go extension           |
| **Pylance**          | Python LSP with type checking   |
| **REST Client**      | HTTP request from `.http` files |
| **SQLTools**         | Database management             |
| **Even Better TOML** | Config file support             |

#### DevOps Profile (Docker/K8s/Terraform)

| Extension               | Purpose                      |
| ----------------------- | ---------------------------- |
| **Docker**              | Container management         |
| **Kubernetes**          | K8s cluster explorer         |
| **HashiCorp Terraform** | IaC syntax + validation      |
| **YAML**                | Red Hat YAML support         |
| **Remote - SSH**        | Edit files on remote servers |
| **ShellCheck**          | Bash script linting          |

### GitLens Optimization

Reduce GitLens memory footprint by disabling heavy features:

```json
{
  "gitlens.codeLens.enabled": false,
  "gitlens.currentLine.enabled": true,
  "gitlens.hovers.currentLine.over": "line",
  "gitlens.statusBar.enabled": true
}
```

---

## 4. The Master `settings.json`

Core editor configuration for a high-performance, professional feel. For the full UI rice (APC CSS injection, ~170 color tokens, panel gaps, transparency), use the preset files in `presets/` directly or see [04-ui-ux-customization.md](./04-ui-ux-customization.md).

```json
{
  // ═══════════════════════════════════════════════════════════════════
  // UI & AESTHETICS
  // ═══════════════════════════════════════════════════════════════════
  "workbench.colorTheme": "Tokyo Night Storm",
  "workbench.iconTheme": "material-icon-theme",
  "workbench.productIconTheme": "material-product-icons",
  "editor.fontFamily": "'JetBrains Mono', 'Fira Code', monospace",
  "editor.fontLigatures": true,
  "editor.fontSize": 13,
  "editor.lineHeight": 1.6,
  "editor.cursorBlinking": "expand",
  "editor.cursorSmoothCaretAnimation": "on",
  "editor.cursorStyle": "line",
  "editor.guides.bracketPairs": "active",
  "editor.guides.indentation": true,
  "editor.bracketPairColorization.enabled": true,
  "editor.renderLineHighlight": "all",

  // ═══════════════════════════════════════════════════════════════════
  // PERFORMANCE & RESOURCE MANAGEMENT
  // ═══════════════════════════════════════════════════════════════════
  "editor.minimap.enabled": false,
  "editor.renderWhitespace": "none",
  "editor.folding": true,
  "editor.foldingStrategy": "indentation",
  "workbench.list.smoothScrolling": true,
  "editor.smoothScrolling": true,
  "editor.stickyScroll.enabled": true,
  "editor.stickyScroll.maxLineCount": 5,
  "files.watcherExclude": {
    "**/.git/objects/**": true,
    "**/.git/subtree-cache/**": true,
    "**/node_modules/**": true,
    "**/target/**": true,
    "**/dist/**": true,
    "**/.venv/**": true,
    "**/coverage/**": true,
    "**/.next/**": true
  },
  "search.exclude": {
    "**/node_modules": true,
    "**/bower_components": true,
    "**/*.code-search": true,
    "**/dist": true,
    "**/coverage": true,
    "**/.git": true,
    "**/package-lock.json": true,
    "**/yarn.lock": true,
    "**/pnpm-lock.yaml": true
  },
  "files.maxMemoryForLargeFilesMB": 4096,
  "extensions.autoCheckUpdates": false,
  "extensions.autoUpdate": "onlyEnabledExtensions",
  "telemetry.telemetryLevel": "off",

  // ═══════════════════════════════════════════════════════════════════
  // EDITOR BEHAVIOR
  // ═══════════════════════════════════════════════════════════════════
  "editor.formatOnSave": true,
  "editor.formatOnPaste": false,
  "editor.linkedEditing": true,
  "editor.lineNumbers": "relative",
  "editor.cursorSurroundingLines": 8,
  "editor.wordWrap": "off",
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "editor.detectIndentation": true,
  "editor.trimAutoWhitespace": true,
  "editor.inlayHints.enabled": "onUnlessPressed",
  "editor.suggest.preview": true,
  "editor.suggest.showStatusBar": true,
  "editor.acceptSuggestionOnCommitCharacter": false,
  "editor.snippetSuggestions": "top",
  "editor.quickSuggestions": {
    "other": "on",
    "comments": "off",
    "strings": "off"
  },

  // ═══════════════════════════════════════════════════════════════════
  // WORKBENCH & LAYOUT
  // ═══════════════════════════════════════════════════════════════════
  "workbench.sideBar.location": "right",
  "workbench.activityBar.location": "default",
  "workbench.editor.highlightModifiedTabs": true,
  "workbench.editor.tabCloseButton": "right",
  "workbench.editor.enablePreview": false,
  "workbench.editor.showTabs": "multiple",
  "workbench.startupEditor": "none",
  "workbench.tips.enabled": false,
  "window.commandCenter": false,
  "window.titleBarStyle": "custom",
  "window.menuBarVisibility": "toggle",
  "breadcrumbs.enabled": true,
  "breadcrumbs.filePath": "on",
  "breadcrumbs.symbolPath": "on",

  // ═══════════════════════════════════════════════════════════════════
  // FILE MANAGEMENT
  // ═══════════════════════════════════════════════════════════════════
  "files.autoSave": "onFocusChange",
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "files.trimFinalNewlines": true,
  "files.associations": {
    "*.env.*": "dotenv",
    ".prettierrc": "json",
    ".eslintrc": "json"
  },
  "explorer.confirmDelete": false,
  "explorer.confirmDragAndDrop": false,
  "explorer.compactFolders": true,
  "explorer.fileNesting.enabled": true,
  "explorer.fileNesting.patterns": {
    "package.json": "package-lock.json, yarn.lock, pnpm-lock.yaml, .npmrc",
    "tsconfig.json": "tsconfig.*.json",
    ".eslintrc.js": ".eslintignore, .prettierrc, .prettierignore",
    "*.ts": "${capture}.test.ts, ${capture}.spec.ts",
    "*.tsx": "${capture}.test.tsx, ${capture}.spec.tsx"
  },

  // ═══════════════════════════════════════════════════════════════════
  // GIT INTEGRATION
  // ═══════════════════════════════════════════════════════════════════
  "git.autofetch": true,
  "git.confirmSync": false,
  "git.enableSmartCommit": true,
  "git.openRepositoryInParentFolders": "always",
  "scm.diffDecorations": "gutter",
  "diffEditor.ignoreTrimWhitespace": false,
  "diffEditor.renderSideBySide": true,

  // ═══════════════════════════════════════════════════════════════════
  // TERMINAL
  // ═══════════════════════════════════════════════════════════════════
  "terminal.integrated.defaultProfile.linux": "zsh",
  "terminal.integrated.fontFamily": "'JetBrains Mono', monospace",
  "terminal.integrated.fontSize": 13,
  "terminal.integrated.gpuAcceleration": "on",
  "terminal.integrated.copyOnSelection": true,
  "terminal.integrated.cursorBlinking": true,
  "terminal.integrated.scrollback": 10000,
  "terminal.integrated.enablePersistentSessions": true,
  "terminal.integrated.tabs.enabled": true,

  // ═══════════════════════════════════════════════════════════════════
  // DEBUGGING
  // ═══════════════════════════════════════════════════════════════════
  "debug.toolBarLocation": "docked",
  "debug.console.fontSize": 13,
  "debug.internalConsoleOptions": "openOnSessionStart",
  "debug.showBreakpointsInOverviewRuler": true,

  // ═══════════════════════════════════════════════════════════════════
  // GITHUB COPILOT
  // ═══════════════════════════════════════════════════════════════════
  "github.copilot.enable": {
    "*": true,
    "plaintext": false,
    "markdown": true,
    "yaml": true
  },
  "github.copilot.editor.enableAutoCompletions": true,

  // ═══════════════════════════════════════════════════════════════════
  // EXTENSION SPECIFICS
  // ═══════════════════════════════════════════════════════════════════
  "errorLens.followCursor": "allLines",
  "errorLens.messageMaxChars": 100,
  "errorLens.gutterIconsEnabled": true,
  "errorLens.enabledDiagnosticLevels": ["error", "warning"],

  "gitlens.codeLens.enabled": false,
  "gitlens.currentLine.enabled": true,
  "gitlens.hovers.currentLine.over": "line",
  "gitlens.statusBar.enabled": true,

  // ═══════════════════════════════════════════════════════════════════
  // LANGUAGE-SPECIFIC OVERRIDES
  // ═══════════════════════════════════════════════════════════════════
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[typescriptreact]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[json]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[jsonc]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[html]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[css]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[markdown]": {
    "editor.wordWrap": "on",
    "editor.quickSuggestions": {
      "other": "off",
      "comments": "off",
      "strings": "off"
    }
  },
  "[rust]": {
    "editor.defaultFormatter": "rust-lang.rust-analyzer",
    "editor.tabSize": 4
  },
  "[python]": {
    "editor.defaultFormatter": "ms-python.black-formatter",
    "editor.tabSize": 4
  },
  "[go]": {
    "editor.defaultFormatter": "golang.go",
    "editor.tabSize": 4
  }
}
```

---

## 5. Workflow Mastery

Professional software engineers rarely touch the mouse. Master these keyboard-driven patterns:

### Essential Navigation

| Keybinding         | Action                   | When to Use                            |
| ------------------ | ------------------------ | -------------------------------------- |
| `Ctrl + P`         | Quick Open               | Open any file by typing partial name   |
| `Ctrl + Shift + O` | Go to Symbol             | Jump to function/class in current file |
| `Ctrl + T`         | Go to Symbol (Workspace) | Find symbol across entire project      |
| `Ctrl + Shift + P` | Command Palette          | Run any VS Code command                |
| `Ctrl + G`         | Go to Line               | Jump to specific line number           |
| `Ctrl + Shift + .` | Focus Breadcrumbs        | Navigate via breadcrumb hierarchy      |

### Code Intelligence

| Keybinding          | Action              | When to Use                     |
| ------------------- | ------------------- | ------------------------------- |
| `F12`               | Go to Definition    | Jump to where symbol is defined |
| `Alt + F12`         | Peek Definition     | View definition in inline popup |
| `Shift + F12`       | Find All References | See where symbol is used        |
| `F2`                | Rename Symbol       | Refactor across entire project  |
| `Ctrl + .`          | Quick Fix           | Apply code actions & fixes      |
| `Ctrl + Space`      | Trigger Suggest     | Manual autocomplete trigger     |
| `Ctrl + K Ctrl + I` | Show Hover          | View type info & documentation  |

### Multi-Cursor & Selection

| Keybinding          | Action                      | When to Use                 |
| ------------------- | --------------------------- | --------------------------- |
| `Ctrl + D`          | Add Selection to Next Match | Multi-cursor on same word   |
| `Ctrl + Shift + L`  | Select All Occurrences      | Multi-cursor on ALL matches |
| `Alt + Click`       | Insert Cursor               | Add cursor anywhere         |
| `Ctrl + L`          | Select Line                 | Quick line selection        |
| `Alt + ↑/↓`         | Move Line                   | Move current line up/down   |
| `Shift + Alt + ↑/↓` | Copy Line                   | Duplicate line up/down      |

### View Management

| Keybinding         | Action               | When to Use                 |
| ------------------ | -------------------- | --------------------------- |
| `Ctrl + B`         | Toggle Sidebar       | Show/hide file explorer     |
| `Ctrl + J`         | Toggle Panel         | Show/hide terminal/problems |
| `` Ctrl + ` ``     | Toggle Terminal      | Quick terminal access       |
| `Ctrl + \`         | Split Editor         | Side-by-side editing        |
| `Ctrl + 1/2/3`     | Focus Editor Group   | Switch between splits       |
| `Ctrl + W`         | Close Editor         | Close current tab           |
| `Ctrl + K Z`       | Zen Mode             | Distraction-free coding     |
| `Ctrl + Shift + E` | Focus Explorer       | Jump to file tree           |
| `Ctrl + Shift + G` | Focus Source Control | Open Git panel              |

### GitHub Copilot

| Keybinding         | Action              | When to Use                    |
| ------------------ | ------------------- | ------------------------------ |
| `Tab`              | Accept Suggestion   | Apply Copilot's suggestion     |
| `Esc`              | Dismiss             | Reject current suggestion      |
| `Ctrl + Enter`     | Open Copilot Panel  | See multiple suggestions       |
| `Ctrl + I`         | Inline Chat         | Ask Copilot a question inline  |
| `Ctrl + Shift + I` | Open Chat Panel     | Full Copilot chat interface    |
| `Alt + ]`          | Next Suggestion     | Cycle through suggestions      |
| `Alt + [`          | Previous Suggestion | Go back to previous suggestion |

### Keybinding Customization System

Use this system to keep your shortcuts clean, scalable, and conflict-free.

#### Where to Edit

- `Ctrl + K Ctrl + S` → Keyboard Shortcuts UI (fast search + conflict visibility)
- Command Palette → `Preferences: Open Keyboard Shortcuts (JSON)` for precise control
- Linux user file path: `~/.config/Code/User/keybindings.json`

#### Scope Strategy

- **User scope:** Global baseline for every project
- **Profile scope:** Per workflow (Web / Backend / DevOps)
- **Workspace scope:** Team/project-only behavior in `.vscode/keybindings.json`

#### Conflict Resolution Workflow

1. Find the command in Keyboard Shortcuts UI
2. Check existing bindings and remove collisions
3. Use `-command.id` entries to unbind defaults cleanly
4. Add `when` clauses so a shortcut works only in the right context
5. Re-test in editor, terminal, and notebook contexts

#### Recommended Control-Layer Keymap

Use a `Ctrl + Alt + ...` layer for custom controls to avoid fighting defaults:

```jsonc
[
  { "key": "ctrl+alt+e", "command": "workbench.view.explorer" },
  { "key": "ctrl+alt+t", "command": "workbench.action.terminal.focus" },
  { "key": "ctrl+alt+m", "command": "workbench.actions.view.problems" },
  {
    "key": "ctrl+alt+s",
    "command": "workbench.action.toggleSidebarVisibility",
  },
  {
    "key": "ctrl+alt+r",
    "command": "editor.action.rename",
    "when": "editorHasRenameProvider && editorTextFocus && !editorReadonly",
  },
  {
    "key": "ctrl+alt+f12",
    "command": "editor.action.referenceSearch.trigger",
    "when": "editorHasReferenceProvider && editorTextFocus",
  },
  {
    "key": "ctrl+alt+v",
    "command": "workbench.files.action.showActiveFileInExplorer",
  },
  {
    "key": "ctrl+alt+enter",
    "command": "workbench.action.toggleMaximizeEditorGroup",
  },
  { "key": "ctrl+alt+\\", "command": "workbench.action.splitEditorRight" },
  { "key": "ctrl+alt+n", "command": "workbench.action.terminal.new" },
  {
    "key": "ctrl+alt+k",
    "command": "workbench.action.terminal.kill",
    "when": "terminalFocus",
  },
  {
    "key": "ctrl+alt+b",
    "command": "workbench.action.tasks.runTask",
    "args": "build",
  },
  {
    "key": "ctrl+alt+l",
    "command": "workbench.action.tasks.runTask",
    "args": "lint",
  },
  {
    "key": "ctrl+alt+y",
    "command": "workbench.action.tasks.runTask",
    "args": "typecheck",
  },
  { "key": "ctrl+alt+z", "command": "workbench.action.toggleZenMode" },
]
```

#### Daily Shortcut Set (High ROI)

| Keybinding         | Action             |
| ------------------ | ------------------ |
| `Ctrl + Alt + E`   | Focus Explorer     |
| `Ctrl + Alt + T`   | Focus Terminal     |
| `Ctrl + Alt + M`   | Focus Problems     |
| `Ctrl + Alt + R`   | Rename Symbol      |
| `Ctrl + Alt + F12` | Find References    |
| `Ctrl + Alt + B`   | Run Build Task     |
| `Ctrl + Alt + L`   | Run Lint Task      |
| `Ctrl + Alt + Y`   | Run Typecheck Task |
| `Ctrl + Alt + Z`   | Toggle Zen Mode    |
| `Ctrl + Alt + S`   | Toggle Sidebar     |

---

## 6. GitHub Copilot Integration

GitHub Copilot is a force multiplier for professional developers when configured correctly.

### Setup

1. Install the **GitHub Copilot** extension
2. Sign in with your GitHub account (requires Copilot subscription)
3. Also install **GitHub Copilot Chat** for conversational AI

### Best Practices

- **Write descriptive comments first:** Copilot predicts based on context. A comment like `// Fetch user data from API and handle pagination` yields better suggestions.
- **Use function signatures:** Type the function name and parameters, let Copilot fill the body.
- **Inline Chat (`Ctrl + I`):** Highlight code and ask "refactor this" or "add error handling".
- **Explain code:** Highlight unfamiliar code → `Ctrl + I` → "explain this code".

### Recommended Settings

```json
{
  "github.copilot.enable": {
    "*": true,
    "plaintext": false,
    "markdown": true,
    "yaml": true,
    "scminput": false
  },
  "github.copilot.editor.enableAutoCompletions": true,
  "chat.editor.fontSize": 13,
  "chat.editor.wordWrap": "on"
}
```

### When to Disable

Disable Copilot when working on:

- Proprietary/sensitive codebases (check your company policy)
- Learning exercises (you want to write the code yourself)
- Code review (focus on understanding, not generating)

---

## 7. Advanced Debugging

Master the debugger—`console.log` is not a debugging strategy.

### Launch Configuration

Create `.vscode/launch.json` for your projects:

```json
{
  "version": "0.2.0",
  "configurations": [
    // --- Node.js (Backend/Scripts) ---
    {
      "name": "Node: Current File",
      "type": "node",
      "request": "launch",
      "program": "${file}",
      "console": "integratedTerminal",
      "skipFiles": ["<node_internals>/**"]
    },
    // --- Vite/React Dev Server ---
    {
      "name": "Chrome: Vite",
      "type": "chrome",
      "request": "launch",
      "url": "http://localhost:5173",
      "webRoot": "${workspaceFolder}/src",
      "sourceMaps": true
    },
    // --- Jest Tests ---
    {
      "name": "Jest: Current File",
      "type": "node",
      "request": "launch",
      "program": "${workspaceFolder}/node_modules/.bin/jest",
      "args": ["${relativeFile}", "--config", "jest.config.js"],
      "console": "integratedTerminal",
      "internalConsoleOptions": "neverOpen"
    },
    // --- Python ---
    {
      "name": "Python: Current File",
      "type": "debugpy",
      "request": "launch",
      "program": "${file}",
      "console": "integratedTerminal"
    },
    // --- Attach to Process ---
    {
      "name": "Attach to Node Process",
      "type": "node",
      "request": "attach",
      "port": 9229,
      "restart": true,
      "skipFiles": ["<node_internals>/**"]
    }
  ],
  "compounds": [
    {
      "name": "Full Stack: Server + Client",
      "configurations": ["Node: Current File", "Chrome: Vite"],
      "stopAll": true
    }
  ]
}
```

### Debugging Workflow

1. **Set Breakpoints:** Click the gutter (left of line numbers) or press `F9`
2. **Conditional Breakpoints:** Right-click breakpoint → "Edit Breakpoint" → Add condition like `i > 100`
3. **Logpoints:** Right-click gutter → "Add Logpoint" → Log without modifying code
4. **Watch Expressions:** Add variables to Watch panel to monitor values
5. **Call Stack:** See the execution path that led to current breakpoint
6. **Debug Console:** Execute expressions in current scope (like browser devtools)

### Debug Keybindings

| Keybinding          | Action                   |
| ------------------- | ------------------------ |
| `F5`                | Start/Continue Debugging |
| `Shift + F5`        | Stop Debugging           |
| `Ctrl + Shift + F5` | Restart Debugging        |
| `F10`               | Step Over                |
| `F11`               | Step Into                |
| `Shift + F11`       | Step Out                 |
| `F9`                | Toggle Breakpoint        |

---

## 8. Project-Specific Workspace Settings

Teams should standardize their VS Code setup. Use `.vscode/` folder for project configuration.

### Workspace Settings (`.vscode/settings.json`)

Override user settings per-project:

```json
{
  // Override tab size for this project
  "editor.tabSize": 4,

  // Project-specific formatters
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },

  // Hide generated files from explorer
  "files.exclude": {
    "**/node_modules": true,
    "**/.git": true,
    "**/dist": true,
    "**/*.js.map": true
  },

  // TypeScript project settings
  "typescript.tsdk": "node_modules/typescript/lib",
  "typescript.enablePromptUseWorkspaceTsdk": true
}
```

### Recommended Extensions (`.vscode/extensions.json`)

Prompt team members to install required extensions:

```json
{
  "recommendations": [
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "bradlc.vscode-tailwindcss",
    "github.copilot",
    "eamodio.gitlens"
  ],
  "unwantedRecommendations": ["hookyqr.beautify"]
}
```

### Task Runner (`.vscode/tasks.json`)

Define build/test tasks accessible via `Ctrl + Shift + B`:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "dev",
      "type": "npm",
      "script": "dev",
      "problemMatcher": [],
      "isBackground": true,
      "presentation": {
        "reveal": "always",
        "panel": "dedicated"
      }
    },
    {
      "label": "build",
      "type": "npm",
      "script": "build",
      "group": {
        "kind": "build",
        "isDefault": true
      },
      "problemMatcher": ["$tsc"]
    },
    {
      "label": "test",
      "type": "npm",
      "script": "test",
      "group": "test",
      "problemMatcher": []
    },
    {
      "label": "lint",
      "type": "npm",
      "script": "lint",
      "problemMatcher": ["$eslint-stylish"]
    }
  ]
}
```

---

## 9. Terminal & Shell Integration

The integrated terminal is more powerful than most realize.

### Shell Configuration

Configure your preferred shell in settings:

```json
{
  "terminal.integrated.profiles.linux": {
    "zsh": {
      "path": "/usr/bin/zsh",
      "args": ["-l"]
    },
    "fish": {
      "path": "/usr/bin/fish"
    },
    "bash": {
      "path": "/usr/bin/bash"
    }
  },
  "terminal.integrated.defaultProfile.linux": "zsh",
  "terminal.integrated.env.linux": {
    "EDITOR": "code --wait"
  }
}
```

### Terminal Workflow

| Keybinding               | Action                |
| ------------------------ | --------------------- |
| `` Ctrl + ` ``           | Toggle Terminal Panel |
| `` Ctrl + Shift + ` ``   | Create New Terminal   |
| `Ctrl + Shift + 5`       | Split Terminal        |
| `Ctrl + PageUp/PageDown` | Switch Terminal Tabs  |
| `Ctrl + Shift + C`       | Copy (in terminal)    |
| `Ctrl + Shift + V`       | Paste (in terminal)   |
| `Ctrl + Shift + X`       | Kill Terminal         |

### Pro Tips

- **Named Terminals:** Right-click terminal tab → Rename for clarity ("API Server", "Tests", "Git")
- **Persistent Sessions:** Enable `terminal.integrated.enablePersistentSessions` to restore terminals on reload
- **Shell Integration:** Modern shells (zsh with oh-my-zsh, fish) provide command detection, enabling:
  - Click to run recent commands
  - Automatic sticky command detection
  - `Ctrl + Shift + G` → Show recent commands

### Recommended Shell Setup (zsh + oh-my-zsh)

```bash
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Add useful plugins to ~/.zshrc
plugins=(git zsh-autosuggestions zsh-syntax-highlighting docker kubectl)

# Install Powerlevel10k theme for a professional prompt
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

---

## 10. Quick Reference Card

Print this or pin it somewhere visible until the shortcuts become muscle memory.

```txt
╔══════════════════════════════════════════════════════════════════╗
║                    VS CODE POWER USER CHEAT SHEET                ║
╠══════════════════════════════════════════════════════════════════╣
║  NAVIGATION                                                       ║
║  Ctrl+P          → Quick Open file                               ║
║  Ctrl+Shift+O    → Go to symbol (current file)                   ║
║  Ctrl+T          → Go to symbol (workspace)                      ║
║  Ctrl+G          → Go to line                                    ║
║  F12             → Go to definition                              ║
║  Alt+F12         → Peek definition                               ║
║  Shift+F12       → Find all references                           ║
╠══════════════════════════════════════════════════════════════════╣
║  EDITING                                                          ║
║  Ctrl+D          → Select next occurrence                        ║
║  Ctrl+Shift+L    → Select all occurrences                        ║
║  Alt+↑/↓         → Move line up/down                             ║
║  Shift+Alt+↑/↓   → Copy line up/down                             ║
║  Ctrl+/          → Toggle comment                                ║
║  Ctrl+Shift+K    → Delete line                                   ║
║  F2              → Rename symbol                                 ║
║  Ctrl+.          → Quick fix                                     ║
╠══════════════════════════════════════════════════════════════════╣
║  VIEW                                                             ║
║  Ctrl+B          → Toggle sidebar                                ║
║  Ctrl+J          → Toggle panel                                  ║
║  Ctrl+`          → Toggle terminal                               ║
║  Ctrl+\          → Split editor                                  ║
║  Ctrl+K Z        → Zen mode                                      ║
╠══════════════════════════════════════════════════════════════════╣
║  COPILOT                                                          ║
║  Tab             → Accept suggestion                             ║
║  Ctrl+I          → Inline chat                                   ║
║  Ctrl+Shift+I    → Open chat panel                               ║
║  Alt+]/[         → Next/prev suggestion                          ║
╠══════════════════════════════════════════════════════════════════╣
║  DEBUG                                                            ║
║  F5              → Start/Continue                                ║
║  Shift+F5        → Stop                                          ║
║  F9              → Toggle breakpoint                             ║
║  F10             → Step over                                     ║
║  F11             → Step into                                     ║
╚══════════════════════════════════════════════════════════════════╝
```

---

## 11. FAQ, Cheat Sheet, and Portability

For cleaner maintenance, see:

- [01-profiles-static-languages.md](./01-profiles-static-languages.md)
- [02-useful-cheat-sheet.md](./02-useful-cheat-sheet.md)
- [03-export-import-settings.md](./03-export-import-settings.md)
- [04-ui-ux-customization.md](./04-ui-ux-customization.md)

These cover:

- Static language profile strategy (C++, Java, etc.)
- Daily high-value shortcut cheat sheet
- Export/import methods across Linux/Windows/macOS
- Comprehensive UI rice guide: APC setup, CSS injection reference, ~170 color tokens organized by region
- Terminal ANSI palette matching Tokyo Night Storm
- Per-platform transparency setup (Linux compositor, macOS vibrancy, Windows acrylic)
- Troubleshooting (APC permissions, VS Code updates, transparency, CSS debugging)
- Standalone CSS reference (`presets/rice.css`) for all APC selectors including aggressive ricing
- Low-resource mode toggle scripts + presets for weaker hardware/battery mode
- Resource monitoring with built-in VS Code Process Explorer + Resource Monitor extension
