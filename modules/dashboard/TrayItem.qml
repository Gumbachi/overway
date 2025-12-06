
import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.DBusMenu

import qs.config

Item {
    id: root
    // required property QsMenuHandle menu
    required property SystemTrayItem modelData

    Rectangle {
        property alias entry: root.modelData

        id: button
        radius: Style.rounding.full
        border.width: Style.borders.button
        border.color: Style.color.inactive
        color: "transparent"

        anchors.fill: parent

        Image {
            width: 24; height: width
            anchors.centerIn: parent
            source: button.entry.icon
            fillMode: Image.PreserveAspectFit
        }

        MouseArea {
            property alias entry: root.modelData
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: event => {
                console.log(entry.title)
                if (event.button === Qt.LeftButton) {
                    entry.activate()
                    // trayItem.display(root.parentWindow, trayButton.x + 100 , trayButton.y)
                } else {
                    entry.secondaryActivate()
                }
            }
            hoverEnabled: true
            onEntered: parent.border.color = Style.color.accent
            onExited: parent.border.color = Style.color.inactive
        }
    }

    // QsMenuAnchor {
    //     anchor.item: button
    //     menu: root.modelData.menu
    // }
}
