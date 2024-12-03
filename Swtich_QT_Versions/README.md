# Switching Qt Versions on Arch Linux

This guide explains how to identify your Qt installations and create a script to dynamically switch between Qt versions without modifying your `~/.bashrc`.

---

## **Step 1: Identify Installed Qt Libraries**

1. Use `pacman` to list the installed files for the Qt6 base package:
   ```bash
   pacman -Ql qt6-base | grep bin
   pacman -Ql qt5-base | grep bin
   
   ```

   This lists binaries like `qmake` and their locations.

2. Locate all available Qt directories:
   ```bash
   find /usr -type d -name "qt5" -o -name "qt6"
   ```

   Alternatively, use `sudo` to bypass permission errors:
   ```bash
   sudo find /usr -type d -name "qt5" -o -name "qt6"
   ```

   Example output:
   ```
   /usr/lib/qt6
   /usr/share/qt6
   /usr/include/qt6
   /usr/bin (for Qt5 binaries)
   ```

---

## **Step 2: Verify the Current Qt Version**

Check which Qt version is currently in use by running:
```bash
qmake --version
```

The output will show the active version of Qt, for example:
```
QMake version 3.x
Using Qt version 6.x in /usr/lib/qt6
```

---

## **Step 3: Create the Script**

1. Create a new script file:
   ```bash
   nano switch-qt.sh
   ```

2. Add the following content to the script:

   ```bash
   #!/bin/bash

   if [ "$#" -ne 1 ]; then
       echo "Usage: source ./switch-qt.sh <qt-version>"
       echo "Available versions: qt5 qt6"
       return 1
   fi

   case $1 in
       qt5)
           export PATH="/usr/bin:$PATH"
           export QT_PLUGIN_PATH="/usr/lib/qt5/plugins"
           export QML2_IMPORT_PATH="/usr/lib/qt5/qml"
           export LD_LIBRARY_PATH="/usr/lib/qt5:$LD_LIBRARY_PATH"
           echo "Switched to Qt5"
           ;;
       qt6)
           export PATH="/usr/lib/qt6/bin:$PATH"
           export QT_PLUGIN_PATH="/usr/lib/qt6/plugins"
           export QML2_IMPORT_PATH="/usr/lib/qt6/qml"
           export LD_LIBRARY_PATH="/usr/lib/qt6:$LD_LIBRARY_PATH"
           echo "Switched to Qt6"
           ;;
       *)
           echo "Invalid version. Use qt5 or qt6."
           return 1
           ;;
   esac
   ```

3. Save and exit (`Ctrl+O`, `Enter`, `Ctrl+X`).

4. Make the script executable:
   ```bash
   chmod +x switch-qt.sh
   ```

---


---

## **Step 4: Source the Script**

1. To temporarily switch to a specific Qt version, source the script and pass the desired version:
   ```bash
   source ./switch-qt.sh qt6
   ```

2. Verify the change:
   ```bash
   qmake --version
   ```

   Example output for Qt6:
   ```
   QMake version 3.x
   Using Qt version 6.x in /usr/lib/qt6
   ```

3. Switch back to Qt5:
   ```bash
   source ./switch-qt.sh qt5
   ```

---

## **Step 5: Automate the Process**

1. Add an alias to simplify usage during terminal sessions. Open your shell configuration file (e.g., `~/.bashrc` or `~/.zshrc`):
   ```bash
   nano ~/.bashrc
   ```

2. Add this alias:
   ```bash
   alias switchqt='source /path/to/switch-qt.sh'
   ```

3. Reload the configuration:
   ```bash
   source ~/.bashrc
   ```

4. Now, you can switch versions easily:
   ```bash
   switchqt qt6
   switchqt qt5
   ```

---

## **Notes**

- This script modifies environment variables temporarily for the session. For a permanent setup, consider updating your shell configuration or using a profile-specific script.
- Ensure you use the correct paths for your Qt installations, as shown in Step 1.

---