
import QtQuick
import QtQuick.Controls

import Quickshell.Services.Mpris

import qs.config

Slider {
    id: slider
    required property MprisPlayer player

    enabled: player.volumeSupported
    value: player.volume
    onMoved: player.volume = value
    live: true
    wheelEnabled: true

    from: 0; to: 1; stepSize: .01
    orientation: Qt.Vertical

    background: Rectangle {
        implicitWidth: 6
        width: implicitWidth
        anchors.horizontalCenter: parent.horizontalCenter
        radius: Style.rounding.soft
        color: Style.color.inactive

        // Active Background
        Rectangle {
            height: (1 - slider.visualPosition) * parent.height
            width: parent.width
            color: Style.color.accent
            radius: Style.rounding.soft
            anchors.bottom: parent.bottom
        }
    }

    handle: Rectangle {
        property alias player: slider.player

        visible: player.volumeSupported
        enabled: player.volumeSupported

        x: slider.availableWidth / 2 - this.width / 2
        y: slider.visualPosition * (slider.availableHeight - this.height)
        implicitWidth: 24; implicitHeight: implicitWidth
        radius: parent.height
        color: Style.color.background
        border.color: slider.hovered ? Style.color.accent : Style.color.inactive
        border.width: Style.size.buttonBorder

        Text {
            // anchors.fill: parent
            // horizontalAlignment: Text.AlignHCenter
            // verticalAlignment: Text.AlignVCenter
            // anchors.fill: parent
            anchors.centerIn: parent
            text: slider.pressed ? Math.round(slider.value * 100) : "󰕾"
            font.pixelSize: slider.pressed ? 10 : 14
            font.bold: true
            color: Style.color.text
        }
    }
}
