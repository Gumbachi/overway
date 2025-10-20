import QtQuick

import Quickshell.Io


Rectangle {
    id: root

    required property string icon
    required property Process process

    implicitWidth: 65
    implicitHeight: 65

    radius: 360
    border.width: 4

    Text {
        text: root.icon
        anchors.centerIn: parent
        font.pixelSize: 36
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.process.running = true
    }

}
