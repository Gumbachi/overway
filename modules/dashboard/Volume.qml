import QtQuick
import QtQuick.Layouts

import Quickshell.Services.Pipewire

import qs.config
import qs.components as Overway

Overway.Container {

    id: root

    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource
	PwObjectTracker { objects: [ root.sink, root.source ] }

    component VolumeButton: Overway.Button {
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

    component VolumeSlider: Overway.Slider {
    	required property PwNode node

        id: control
        value: node === null ? 0 : node.audio.volume
        onMoved: node.audio.volume = value
        Layout.minimumWidth: 250
        Layout.fillWidth: true

        troughSize: 6
        handleSize: 32

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
