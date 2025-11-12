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
            Rectangle {
                required property int index
                required property SystemTrayItem modelData

                id: trayButton

                Layout.preferredWidth: 40;
                Layout.preferredHeight: Layout.preferredWidth


                radius: Style.rounding.circle
                border.width: Style.size.buttonBorder
                border.color: Style.color.inactive
                color: "transparent"
                Layout.alignment: Qt.AlignCenter

                Image {
                    width: 24; height: width
                    anchors.centerIn: parent
                    source: trayButton.modelData.icon
                    fillMode: Image.PreserveAspectFit
                }

                // TrayMenu {
                //     menu: trayButton.modelData.menu
                // }

                MouseArea {
                    property alias trayItem: trayButton.modelData
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: event => {
                        console.log(trayButton.width)
                        if (event.button === Qt.LeftButton) {
                            trayItem.display(root.parentWindow, trayButton.x + 100 , trayButton.y)
                        } else {
                            trayItem.secondaryActivate()
                        }
                    }
                    hoverEnabled: true
                    onEntered: parent.border.color = Style.color.accent
                    onExited: parent.border.color = Style.color.inactive
                }

            }
        }

        // Filler item to get items to be left aligned in the rowlayout
        Item { Layout.fillWidth: true }
    }
}
