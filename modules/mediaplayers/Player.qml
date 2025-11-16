import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Quickshell.Widgets
import Quickshell.Services.Mpris

import qs.config

GridLayout {
    id: root
    required property MprisPlayer player

    signal cycleClicked()
    property int playerCount: 0


    columns: 4
    rows: 4

    function formatTime(durationInSeconds: int): string {
        const minutes = Math.floor(durationInSeconds / 60)
        const seconds = Math.floor(durationInSeconds % 60)
        const leadingZero = seconds < 10 ? "0" : ""
        return `${minutes}:${leadingZero}${seconds}`
    }

    // VolumeSlider {
    //     player: root.player
    //     Layout.rowSpan: 4
    //     Layout.fillHeight: true
    // }

    // This is causing quickshell to crash right now
    // Move image into this and put the three layout properties in here to change
    // ClippingWrapperRectangle {
    //     radius: 4
    // }

    Image {
        source: root.player.trackArtUrl
        fillMode: Image.PreserveAspectCrop
        sourceSize.width: width
        sourceSize.height: height
        Layout.fillHeight: true
        Layout.rowSpan: 4
        Layout.preferredWidth: height

        // React to scroll events for volume
        MouseArea {
            anchors.fill: parent
            onWheel: (wheel) => root.player.volume += (wheel.angleDelta.y / 12000)
        }
    }


    Text {
        id: title
        Layout.alignment: Qt.AlignTop
        Layout.fillWidth: true
        Layout.rightMargin: -32
        Layout.columnSpan: 2
        text: root.player.trackTitle || "Unknown Title"
        font.bold: true
        font.pixelSize: Style.fontSize.titleMedium
        color: Style.color.text
        elide: Text.ElideRight
    }


    PlayerButton {
        icon: "󰓢"
        visible: root.playerCount > 1
        implicitWidth: 24
        hoverEnabled: root.playerCount > 1
        iconColor: root.playerCount > 1 ? Style.color.text : Style.color.inactive
        Layout.alignment: Qt.AlignRight
        onClicked: { root.cycleClicked() }
    }

    Text {
        id: artist
        Layout.columnSpan: 3
        font.pixelSize: Style.fontSize.titleSmall
        Layout.topMargin: -4
        text: root.player.trackArtist || "Unknown Artist"
        color: Style.color.text
    }

    TrackSlider {
        player: root.player
        Layout.columnSpan: 3
        Layout.topMargin: 20
        Layout.minimumWidth: 350
        Layout.preferredWidth: 450
    }

    Text {
        id: durationLeft
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        text: root.formatTime(root.player.position)
        color: Style.color.text
        font.bold: true
        font.pixelSize: 14
        Layout.topMargin: -5
        Layout.leftMargin: 5
        Layout.preferredWidth: 25
    }

    RowLayout {
        Layout.alignment: Qt.AlignCenter
        spacing: 4

        PlayerButton {
            icon: "󰒮"
            enabled: root.player.canGoPrevious
            onClicked: root.player.previous()
        }

        PlayerButton {
            icon: root.player.playbackState === MprisPlaybackState.Paused ? "󰐊" : "󰏤"
            enabled: root.player.canTogglePlaying
            onClicked: {
                const state = root.player.playbackState
                if (state === MprisPlaybackState.Playing) {
                    root.player.pause()
                } else if (state === MprisPlaybackState.Paused) {
                    root.player.play()
                } else {
                    console.log("Player in Unknown State")
                }
            }
        }

        PlayerButton {
            icon: "󰒭"
            enabled: root.player.canGoNext
            onClicked: root.player.next()
        }

        Rectangle {
            visible: root.player.shuffleSupported || root.player.loopSupported
            implicitWidth: Style.borders.button
            Layout.preferredHeight: parent.height * 0.8
            Layout.leftMargin: 4
            Layout.rightMargin: 4
            color: Style.color.inactive
            radius: 20
        }

        PlayerButton {
            visible: root.player.loopSupported
            enabled: root.player.loopSupported
            icon: root.player.loopState === MprisLoopState.Track ? "󰑘" : "󰑖"
            iconColor: root.player.loopState === MprisLoopState.None ? Style.color.inactive : Style.color.text
            // Layout.rightMargin: 10
            hoverEnabled: root.player.loopState === MprisLoopState.None
            border.color: root.player.loopState === MprisLoopState.None ? Style.color.inactive : Style.color.accent
            onClicked: {
                switch (root.player.loopState) {
                    case MprisLoopState.None:
                        root.player.loopState = MprisLoopState.Playlist
                        break;
                    case MprisLoopState.Playlist:
                        root.player.loopState = MprisLoopState.Track
                        break;
                    default:
                        root.player.loopState = MprisLoopState.None
                }
            }
        }

        PlayerButton {
            visible: root.player.shuffleSupported
            enabled: root.player.shuffleSupported
            icon: "󰒝"
            iconColor: root.player.shuffle ? Style.color.text : Style.color.inactive
            // Layout.leftMargin: 10
            hoverEnabled: !root.player.shuffle
            border.color: root.player.shuffle ? Style.color.accent : Style.color.inactive
            onClicked: root.player.shuffle = !root.player.shuffle
        }


        Rectangle {
            visible: root.player.volumeSupported
            implicitWidth: Style.borders.button
            Layout.preferredHeight: parent.height * 0.8
            Layout.leftMargin: 4
            Layout.rightMargin: 4
            color: Style.color.inactive
            radius: 20
        }

        VolumeSlider {
            visible: root.player.volumeSupported
            player: root.player
            Layout.minimumWidth: 100
        }
    }

    Text {
        id: durationRight
        Layout.alignment: Qt.AlignRight | Qt.AlignTop
        text: root.formatTime(root.player.length)
        font.bold: true
        font.pixelSize: 14
        Layout.topMargin: -5
        Layout.rightMargin: 5
        color: Style.color.text
    }
}
