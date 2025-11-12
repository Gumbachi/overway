
import QtQuick
import QtQuick.Controls

import Quickshell.Services.Mpris

import qs.config

Slider {
    required property MprisPlayer player
    id: slider

    enabled: player.volumeSupported
    value: player.volume
    onMoved: player.volume = value
    live: true
    wheelEnabled: true

    from: 0; to: 1; stepSize: .01

    background: Rectangle {
        implicitHeight: 4
        anchors.verticalCenter: parent.verticalCenter
        radius: Style.rounding.soft
        color: Style.color.inactive

        // Active Background
        Rectangle {
            width: slider.visualPosition * parent.width
            height: parent.height
            color: Style.color.accent
            radius: Style.rounding.soft
        }
    }

    handle: Rectangle {
        visible: slider.player.volumeSupported
        enabled: slider.player.volumeSupported

        x: slider.visualPosition * (slider.availableWidth - width)
        y: slider.availableHeight / 2 - height / 2
        implicitWidth: 28; implicitHeight: implicitWidth
        radius: parent.height
        color: Style.color.background
        border.color: slider.hovered ? Style.color.accent : Style.color.inactive
        border.width: Style.size.buttonBorder

        Text {
            // anchors.centerIn: parent
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: Math.round(slider.value * 100)
            font.pixelSize: 12
            font.bold: true
            color: Style.color.text
        }
    }
}
