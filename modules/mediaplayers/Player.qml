import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Quickshell.Widgets
import Quickshell.Services.Mpris

import qs.config

GridLayout {
    id: root
    required property MprisPlayer player

    property int playerCount: 0
    function onCycleClicked() { console.log("Cycle Clicked") }


    columns: 5
    rows: 4

    function formatTime(durationInSeconds: int): string {
        const minutes = Math.floor(durationInSeconds / 60)
        const seconds = Math.floor(durationInSeconds % 60)
        const leadingZero = seconds < 10 ? "0" : ""
        return `${minutes}:${leadingZero}${seconds}`
    }

    Slider {
        id: volumeSlider
        property alias player: root.player


        Layout.rowSpan: 4
        Layout.fillHeight: true

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
                height: (1 - volumeSlider.visualPosition) * parent.height
                width: parent.width
                color: Style.color.accent
                radius: Style.rounding.soft
                anchors.bottom: parent.bottom
            }
        }

        handle: Rectangle {
            property alias slider: volumeSlider
            property alias player: volumeSlider.player

            visible: player.volumeSupported
            enabled: player.volumeSupported

            x: slider.availableWidth / 2 - this.width / 2
            y: slider.visualPosition * (slider.availableHeight - height)
            implicitWidth: 24; implicitHeight: implicitWidth
            radius: parent.height
            color: Style.color.background
            border.color: slider.hovered ? Style.color.accent : Style.color.inactive
            border.width: Style.size.buttonBorder

            Text {
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: Math.round(volumeSlider.value * 100)
                font.pixelSize: 10
                font.bold: true
                color: Style.color.text
            }
        }
    }


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
        font.pixelSize: 16
        color: Style.color.text
        elide: Text.ElideRight
    }


    PlayerButton {
        icon: "󰓢"
        implicitWidth: 24
        hoverEnabled: root.playerCount > 1
        iconColor: root.playerCount > 1 ? Style.color.text : Style.color.inactive
        Layout.alignment: Qt.AlignRight
        function onClick() { root.onCycleClicked() }
    }

    Text {
        id: artist
        Layout.columnSpan: 3
        font.pixelSize: 14
        Layout.topMargin: -8
        text: root.player.trackArtist || "Unknown Artist"
        color: Style.color.text
    }

    Slider {
        id: trackSlider
        property alias player: root.player

        Layout.columnSpan: 3
        Layout.topMargin: 20

        value: player.positionSupported ? player.position : 0
        onMoved: player.position = value

        from: 0; to: player.length; stepSize: 1

        Layout.minimumWidth: 250
        Layout.preferredWidth: 400

        FrameAnimation {
            // only emit the signal when the position is actually changing.
            running: root.player.playbackState == MprisPlaybackState.Playing
            // emit the positionChanged signal every frame.
            onTriggered: root.player.positionChanged()
        }

        background: Rectangle {
            implicitHeight: 6
            anchors.verticalCenter: parent.verticalCenter
            height: implicitHeight
            radius: Style.rounding.soft
            color: Style.color.inactive

            // Active Background
            Rectangle {
                width: trackSlider.visualPosition * parent.width
                height: parent.height
                color: Style.color.accent
                radius: Style.rounding.soft
            }
        }

        handle: Rectangle {

            visible: root.player.positionSupported
            enabled: root.player.positionSupported

            x: trackSlider.leftPadding + trackSlider.visualPosition * (trackSlider.availableWidth - width)
            y: trackSlider.topPadding + trackSlider.availableHeight / 2 - height / 2
            implicitWidth: 20; implicitHeight: implicitWidth
            radius: parent.height
            color: Style.color.background
            border.color: trackSlider.hovered ? Style.color.accent : Style.color.inactive
            border.width: Style.size.buttonBorder
        }
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
            function onClick() { root.player.previous() }
        }

        PlayerButton {
            icon: root.player.playbackState === MprisPlaybackState.Paused ? "󰐊" : "󰏤"
            enabled: root.player.canTogglePlaying
            function onClick() {
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
            function onClick() { root.player.next() }
        }

        Rectangle {
            visible: root.player.shuffleSupported || root.player.loopSupported
            implicitWidth: Style.size.buttonBorder
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
            function onClick() {
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
            function onClick() {
                root.player.shuffle = !root.player.shuffle
            }
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
