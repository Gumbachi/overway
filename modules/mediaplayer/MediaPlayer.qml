pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell.Services.Mpris

import qs.config
import qs.components

Container {

    id: root
    property int currentPlayerIndex: 0
    readonly property list<MprisPlayer> players: Mpris.players.values


    Connections {
        target: Mpris.players

        // Set index to be in bounds when active player is removed
        function onObjectRemovedPost() {
            if (root.currentPlayerIndex > root.players.length - 1)
                root.currentPlayerIndex = root.players.length - 1
        }

        // Auto switch to new player when added
        function onObjectInsertedPost() {
            root.currentPlayerIndex = root.players.length - 1
        }
    }

    RowLayout {
        ColumnLayout {
            Repeater {
                model: root.players.length
                Rectangle {
                    required property int index
                    implicitWidth: 12; implicitHeight: implicitWidth
                    radius: Style.rounding.circle
                    color: index === root.currentPlayerIndex ? Style.color.accent : Style.color.inactive

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.currentPlayerIndex = parent.index
                    }
                }
            }
        }

        StackLayout {
            id: playerStack
            currentIndex: root.currentPlayerIndex
            Layout.fillWidth: true

            Repeater {
                model: root.players
                Player {
                    required property MprisPlayer modelData
                    player: modelData
                }
            }
        }
    }


    component Player: GridLayout {

        id: p

        required property MprisPlayer player

        columns: 4
        rows: 4
        Layout.fillHeight: true
        Layout.fillWidth: true
        uniformCellWidths: true

        function formatTime(durationInSeconds: int): string {
            const minutes = Math.floor(durationInSeconds / 60)
            const seconds = Math.floor(durationInSeconds % 60)
            const leadingZero = seconds < 10 ? "0" : ""
            return `${minutes}:${leadingZero}${seconds}`
        }

        Image {
            source: p.player.trackArtUrl
            fillMode: Image.PreserveAspectCrop
            Layout.fillHeight: true
            Layout.rowSpan: 4
            Layout.preferredWidth: this.height
            sourceSize.width: width
            sourceSize.height: height
        }
        // This causes quickshell to crash right now
        // ClippingWrapperRectangle {
        //     // radius: Style.rounding.hard
        // }


        Text {
            id: title
            Layout.alignment: Qt.AlignLeft
            Layout.fillWidth: true
            Layout.bottomMargin: -4
            Layout.columnSpan: 3
            text: p.player.trackTitle || "Unknown Title"
            font.bold: true
            font.pixelSize: 16
            color: Style.color.text
            elide: Text.ElideRight
        }

        Text {
            id: artist
            Layout.columnSpan: 3
            font.pixelSize: 14
            Layout.alignment: Qt.AlignLeft
            text: p.player.trackArtist || "Unknown Artist"
            color: Style.color.text
        }

        Slider {
            id: slider
            property alias player: p.player
            Layout.columnSpan: 3
            Layout.topMargin: 20

            value: player.positionSupported ? player.position : 0
            onMoved: player.position = visualPosition * player.length

            from: 0; to: player.length; stepSize: 1
            live: false // only update player on release
            Layout.fillWidth: true

            FrameAnimation {
                // only emit the signal when the position is actually changing.
                running: slider.player.playbackState == MprisPlaybackState.Playing
                // emit the positionChanged signal every frame.
                onTriggered: slider.player.positionChanged()
            }

            background: Rectangle {
                implicitHeight: 6
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

                id: handle
                x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                implicitWidth: 20; implicitHeight: implicitWidth
                radius: parent.height
                color: Style.color.background
                border.color: slider.hovered ? Style.color.accent : Style.color.inactive
                border.width: Style.size.buttonBorder
            }
        }


        Text {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            text: p.formatTime(p.player.position)
            color: Style.color.text
            font.bold: true
            font.pixelSize: 14
            Layout.topMargin: -5
            Layout.leftMargin: 5
            Layout.preferredWidth: 25
        }

        RowLayout {
            Layout.alignment: Qt.AlignCenter
            uniformCellSizes: true
            spacing: 2
            PlayerButton {
                icon: "󰒮"
                player: p.player
                function onClick() {
                    if (p.player.canGoPrevious) p.player.previous()
                }
            }
            PlayerButton {
                icon: p.player.playbackState === MprisPlaybackState.Paused ? "󰐊" : "󰏤"
                player: p.player
                function onClick() {
                    console.log(root.currentPlayerIndex)
                    const { Playing, Paused } = MprisPlaybackState
                    if (player.playbackState === Playing && player.canPause) {
                        player.pause()
                    } else if (player.playbackState === Paused && player.canPlay) {
                        player.play()
                    }
                }
            }
            PlayerButton {
                icon: "󰒭"
                player: p.player
                function onClick() {
                    if (p.player.canGoNext) p.player.next()
                }
            }
        }
        Text {
            Layout.alignment: Qt.AlignRight | Qt.AlignTop
            text: p.formatTime(p.player.length)
            font.bold: true
            font.pixelSize: 14
            Layout.topMargin: -5
            Layout.rightMargin: 5
            color: Style.color.text
        }
    }

    component PlayerButton: Rectangle {
        id: button
        required property string icon
        required property MprisPlayer player

        function onClick() {}

        implicitWidth: 24; implicitHeight: implicitWidth
        radius: Style.rounding.circle
        border.width: Style.size.buttonBorder
        border.color: Style.color.inactive
        color: "transparent"

        Text {
            text: parent.icon
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.centerIn: parent
            font.pixelSize: 16
            color: Style.color.text
        }

        MouseArea {
            anchors.fill: parent
            onClicked: button.onClick()
            hoverEnabled: true
            onEntered: parent.border.color = Style.color.accent
            onExited: parent.border.color = Style.color.inactive
        }
    }
}
