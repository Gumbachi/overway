
import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.SystemTray

Item {
    id: root
    required property QsMenuHandle menu

    // implicitHeight: 200
    // implicitWidth: 200

    QsMenuOpener {
        menu: root.menu
    }
}
