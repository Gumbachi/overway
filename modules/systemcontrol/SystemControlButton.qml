import QtQuick

import Quickshell.Io


Rectangle {
    id: root

    required property string icon
    required property Process process

    implicitWidth: 65
    implicitHeight: 65

    radius: 360
    border.width: 2
    border.color: "#75715E"
    color: "transparent"

    Text {
        text: root.icon
        anchors.centerIn: parent
        font.pixelSize: 36
        color: "white"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.process.running = true
        hoverEnabled: true

        onEntered: root.border.color = "#66D9EF"
        onExited: root.border.color = "#75715E"
    }

}
