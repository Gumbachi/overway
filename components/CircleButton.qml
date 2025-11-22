
import QtQuick

import qs.config

Rectangle {
    id: root
    property string text: ""
    property string textColor: Style.color.text
    property bool hoverEnabled: true
    property string fontFamily: "JetbrainsMono Nerd Font"
    property int fontSize: 18

    signal clicked()

    implicitWidth: Style.size.mediaPlayerButton
    implicitHeight: implicitWidth
    radius: Style.rounding.full
    border.width: Style.borders.button
    border.color: Style.color.inactive
    color: "transparent"

    Text {
        anchors.centerIn: root
        text: root.text
        font.family: root.fontFamily
        font.pixelSize: root.fontSize
        color: root.textColor
    }

    MouseArea {
        anchors.fill: root
        onClicked: { root.clicked() }
        hoverEnabled: root.hoverEnabled
        onEntered: root.border.color = Style.color.accent
        onExited: {
            if (root.hoverEnabled)
                root.border.color = Style.color.inactive
        }
    }
}
