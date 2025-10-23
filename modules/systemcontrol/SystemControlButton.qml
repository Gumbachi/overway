import QtQuick

import Quickshell.Io
import qs.config


Rectangle {
    id: root

    required property string icon
    required property Process process

    implicitWidth: 65
    implicitHeight: 65

    radius: Style.rounding.circle
    border.width: Style.size.buttonBorder
    border.color: Style.color.inactive
    color: "transparent"

    Text {
        text: root.icon
        anchors.centerIn: parent
        font.pixelSize: 36
        color: Style.color.text
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.process.running = true
        hoverEnabled: true

        onEntered: root.border.color = Style.color.accent
        onExited: root.border.color = Style.color.inactive
    }

}
