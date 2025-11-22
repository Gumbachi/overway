import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell.Services.Pipewire

import qs.config
import qs.components

Container {

    id: root

    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource
	PwObjectTracker { objects: [ root.sink, root.source ] }

    component VolumeButton: CircleButton {
        id: button
        required property PwNode node
        required property var thresholds

        property real lastVolume: 0.50

        fontSize: 24

        implicitWidth: Style.size.volumeControlButton
        implicitHeight: implicitWidth
        radius: Style.rounding.full

        // Fetch proper icon for volume level
        text: {
            for (const [key, value] of Object.entries(thresholds)) {
                if (node === null) return thresholds[0]
                if (parseFloat(node.audio.volume) <= key) return value
            }
            const values = Object.values(thresholds)
            return values[values.length -1] // Get last value item
        }

        // Toggle device volume
        onClicked: {
            if (node.audio.muted || node.audio.volume == 0) {
                console.log(`Unmuting ${node.nickname}`)
                node.audio.muted = false
                node.audio.volume = lastVolume
            } else {
                console.log(`Muting ${node.nickname}`)
                lastVolume = node.audio.volume
                node.audio.muted = true
                node.audio.volume = 0
            }
        }
    }

    component VolumeSlider: Slider {
        id: control

    	required property PwNode node
        value: {
            if (node === null) return 0
            return node.audio.volume
        }
        onMoved: node.audio.volume = value
        Layout.minimumWidth: 250
        Layout.fillWidth: true


        from: 0; to: 1; stepSize: .01

        background: Rectangle {
            implicitHeight: 6
            anchors.verticalCenter: parent.verticalCenter
            height: implicitHeight
            radius: Style.rounding.soft
            color: Style.color.inactive

            // Active Background
            Rectangle {
                width: control.visualPosition * parent.width
                height: parent.height
                color: Style.color.accent
                radius: Style.rounding.soft
            }
        }

        handle: Rectangle {
            id: handle
            x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
            y: control.topPadding + control.availableHeight / 2 - height / 2
            implicitWidth: 32; implicitHeight: implicitWidth
            radius: parent.height
            color: Style.color.background
            border.color: control.hovered ? Style.color.accent : Style.color.inactive
            border.width: Style.borders.button

            Text {
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: Math.round(control.value * 100)
                font.pixelSize: 12
                font.bold: true
                color: Style.color.text
            }
        }
    }

    GridLayout {
    	rows: 2; columns: 2
    	columnSpacing: 8

        VolumeButton {
            node: root.source
            thresholds: { 0: "󰍭", 1: "󰍬" }
        }
        VolumeSlider {
            node: root.source
        }


        VolumeButton {
            node: root.sink
            thresholds: { 0: "󰝟", .33: "󰕿", .67: "󰖀", 0.99: "󰕾" }
        }
        VolumeSlider {
            node: root.sink
        }

    }
}
