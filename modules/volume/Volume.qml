import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell.Services.Pipewire

import qs.config
import qs.components

Container {

    id: root

    component VolumeButton: Rectangle {
        id: button
        required property PwNode node
        required property var thresholds

        property real lastVolume: 0.50

        implicitWidth: 40; implicitHeight: implicitWidth
        radius: Style.rounding.circle
        border.width: Style.size.buttonBorder
        border.color: Style.color.inactive
        color: "transparent"

        // Determine icon from thresholds param
        function getIcon(): string {
            for (const [key, value] of Object.entries(thresholds)) {
                if (node === null) return thresholds[0]
                if (parseFloat(node.audio.volume) <= key) return value
            }
            const values = Object.values(thresholds)
            return values[values.length -1] // Get last value item
        }

        function toggleMute(): void {
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

        Text {
            text: button.getIcon()
            anchors.centerIn: parent
            font.pixelSize: 22
            color: Style.color.text
        }

        MouseArea {
            anchors.fill: parent
            onClicked: button.toggleMute()
            hoverEnabled: true
            onEntered: parent.border.color = Style.color.accent
            onExited: parent.border.color = Style.color.inactive
        }
    }

    component VolumeSlider: Slider {
        id: control

    	required property PwNode node
        value: {
            if (node === null) return 0
            return node.audio.volume
        }
        onValueChanged: node.audio.volume = value
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
            border.width: Style.size.buttonBorder

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

    ColumnLayout {
    	PwObjectTracker { objects: [ source.node, sink.node ] }

        RowLayout {
            id: source
            property PwNode node: Pipewire.defaultAudioSource
            VolumeButton {
                node: source.node
                thresholds: { 0: "󰍭", 1: "󰍬" }
            }
            VolumeSlider { node: source.node }
        }

        RowLayout {
            id: sink
            property PwNode node: Pipewire.defaultAudioSink
            VolumeButton {
                node: sink.node
                thresholds: { 0: "󰝟", .33: "󰕿", .67: "󰖀", 0.99: "󰕾" }
            }
            VolumeSlider { node: sink.node }
        }

    }

}
