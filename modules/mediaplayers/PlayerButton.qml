
import QtQuick

import qs.config

Rectangle {
    required property string icon
    property string iconColor: Style.color.text
    property bool hoverEnabled: true
    function onClick() {}

    implicitWidth: 28; implicitHeight: implicitWidth
    radius: Style.rounding.circle
    border.width: Style.size.buttonBorder
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
        onClicked: parent.onClick()
        hoverEnabled: parent.hoverEnabled
        onEntered: parent.border.color = Style.color.accent
        onExited: {
            if (parent.hoverEnabled)
                parent.border.color = Style.color.inactive
        }
    }
}
