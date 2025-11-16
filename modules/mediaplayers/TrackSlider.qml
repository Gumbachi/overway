
import QtQuick
import QtQuick.Controls

import Quickshell.Services.Mpris

import qs.config


Slider {
    id: slider
    required property MprisPlayer player

    // Layout.columnSpan: 3
    // Layout.topMargin: 20
    // Layout.minimumWidth: 250
    // Layout.preferredWidth: 400

    from: 0; to: player.length; stepSize: 1
    value: player.positionSupported ? player.position : 0
    onMoved: player.position = value



    FrameAnimation {
        // only emit the signal when the position is actually changing.
        running: slider.player.playbackState == MprisPlaybackState.Playing
        // emit the positionChanged signal every frame.
        onTriggered: slider.player.positionChanged()
    }

    background: Rectangle {
        implicitHeight: 4
        anchors.verticalCenter: parent.verticalCenter
        height: implicitHeight
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

        visible: slider.player.positionSupported
        enabled: slider.player.positionSupported

        x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: 20; implicitHeight: implicitWidth
        radius: parent.height
        color: Style.color.background
        border.color: slider.hovered ? Style.color.accent : Style.color.inactive
        border.width: Style.size.buttonBorder
    }
}
