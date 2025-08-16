
import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Widgets

Rectangle {
    id: root

    required property Process onClicked
    required property string icon

    property string borderColor: "red"
    property int borderWidth: 12
    
    radius: 360        
    border.width: root.borderWidth
    border.color: root.borderColor

    Text {
        text: root.icon
        anchors.centerIn: parent
        font.pixelSize: 36
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.onClicked.startDetached()
    }

    // IconImage {
    //     source: Quickshell.iconPath(root.icon)
    //     Layout.alignment: Qt.AlignCenter
    //     implicitSize: 36
    // }

}
