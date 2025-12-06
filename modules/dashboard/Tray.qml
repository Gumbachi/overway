pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.SystemTray
// import Quickshell.Services.DBusMenu

import qs.config
import qs.components

Container {
    id: root
    required property QsWindow parentWindow

    RowLayout {
        Repeater {
            model: SystemTray.items.values
            TrayItem {
                Layout.preferredWidth: Style.size.trayButton
                Layout.preferredHeight: Layout.preferredWidth
                Layout.alignment: Qt.AlignCenter
            }
        }

        // Filler item to get items to be left aligned in the rowlayout
        Item { Layout.fillWidth: true }
    }
}
