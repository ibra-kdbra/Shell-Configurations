#!/bin/bash
#ibra-kdbra Arch
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
