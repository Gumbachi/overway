
import QtQuick
import QtQuick.Controls

import Quickshell.Services.Mpris

import qs.config

Slider {
    id: slider

    property bool showHandle: true
    property bool showHandleNumber: true
    property int handleSize: Style.size.mediaPlayerButton

    property int troughSize: 4

    live: true
    wheelEnabled: true

    from: 0; to: 1; stepSize: .01

    background: Rectangle {
        height: slider.troughSize
        anchors.verticalCenter: parent.verticalCenter
        radius: Style.rounding.soft
        color: Style.color.inactive

        // Active Background
        Rectangle {

           // Extra width added to keep the end of the active background in the middle
           // of the slider handle (it looks better). Only if the handle is shown
            property real backgroundPadding: slider.showHandle ? ((0.5 - slider.visualPosition) * slider.handle.width) : 0

            width: slider.visualPosition * parent.width + backgroundPadding
            height: parent.height
            color: Style.color.accent
            radius: Style.rounding.soft
        }
    }

    handle: Rectangle {
        visible: slider.showHandle
        x: slider.visualPosition * (slider.availableWidth - width)
        y: slider.availableHeight / 2 - height / 2
        implicitWidth: slider.handleSize
        implicitHeight: implicitWidth
        radius: parent.height
        color: Style.color.background
        border.color: slider.hovered ? Style.color.accent : Style.color.inactive
        border.width: Style.borders.button

        Text {
            visible: slider.showHandleNumber
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: Math.round(slider.value * 100)
            font.pixelSize: 12
            font.family: Style.fontFamily.mono
            font.bold: true
            color: Style.color.text
        }
    }
}
