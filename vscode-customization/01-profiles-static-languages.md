# VS Code Profiles for Static Languages (C++, Java, etc.)

Yes, profiles are language-agnostic and ideal for static languages.

## C++ Profile (recommended)

- `ms-vscode.cpptools`
- `llvm-vs-code-extensions.vscode-clangd`
- `ms-vscode.cmake-tools`
- `twxs.cmake`
- `vadimcn.vscode-lldb` (or `ms-vscode.cpptools-extension-pack`)

### Suggested settings

- Use `clang-format` or C/C++ formatter on save
- Enable semantic highlighting + inlay hints
- Configure build/debug tasks with CMake or Make

## Java Profile (recommended)

- `vscjava.vscode-java-pack`
- `redhat.java`
- `vscjava.vscode-maven`
- `vscjava.vscode-gradle`
- `vscjava.vscode-java-debug`

### Suggested settings

- Enable Java import/update build config on open
- Use project JDK settings per workspace
- Keep Java-only extensions in Java profile to reduce RAM in web projects

## Profile strategy

- Keep **Base Profile** minimal (Git, UI, keybindings)
- Add language-specific extensions in dedicated profiles:
  - `Web`
  - `C++`
  - `Java`
  - `DevOps`
- Switch quickly with: `Ctrl+Shift+P` → `Profiles: Switch Profile`

> **Note:** Keep **APC Customize UI++** (`drcika.apc-extension`) in the Base Profile since it modifies VS Code's Electron shell at the UI level, not per-language. Similarly, keep icon themes and color customizations at the Base Profile level.
