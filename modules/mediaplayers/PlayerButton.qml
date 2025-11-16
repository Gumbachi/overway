
import QtQuick

import qs.config

Rectangle {
    id: root
    required property string icon
    property string iconColor: Style.color.text
    property bool hoverEnabled: true

    signal clicked()

    implicitWidth: Style.size.mediaPlayerButton; implicitHeight: implicitWidth
    radius: Style.rounding.full
    border.width: Style.borders.button
    border.color: Style.color.inactive
    color: "transparent"

    Text {
        text: parent.icon
        font.family: "JetbrainsMono Nerd Font"
        anchors.centerIn: parent
        font.pixelSize: 18
        color: parent.iconColor
    }

    MouseArea {
        anchors.fill: parent
        onClicked: { root.clicked() }
        hoverEnabled: parent.hoverEnabled
        onEntered: parent.border.color = Style.color.accent
        onExited: {
            if (parent.hoverEnabled)
                parent.border.color = Style.color.inactive
        }
    }
}
