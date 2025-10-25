import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell.Services.Mpris

import qs.config
import qs.components

Container {

    id: root
    property MprisPlayer player: Mpris.players[0]

    component PlayerButton: Rectangle {
        id: button
        required property string icon
        required property MprisPlayer player

        implicitWidth: 28; implicitHeight: implicitWidth
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
            onClicked: console.log("clicked mp button")
            hoverEnabled: true
            onEntered: parent.border.color = Style.color.accent
            onExited: parent.border.color = Style.color.inactive
        }
    }

    component PlayerSlider: Slider {
        id: control
    	required property MprisPlayer player

        value: player.positionSupported ? player.position : 0
        onValueChanged: player.position = value

        from: 0; to: player.length; stepSize: 1

        FrameAnimation {
            // only emit the signal when the position is actually changing.
            running: control.player.playbackState == MprisPlaybackState.Playing
            // emit the positionChanged signal every frame.
            onTriggered: {
                console.log("emitting value")
                control.player.positionChanged()
            }
        }

        background: Rectangle {
            implicitWidth: 250;
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

            visible: control.player.positionSupported
            enabled: control.player.positionSupported

            id: handle
            x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
            y: control.topPadding + control.availableHeight / 2 - height / 2
            implicitWidth: 20; implicitHeight: implicitWidth
            radius: parent.height
            color: Style.color.background
            border.color: control.hovered ? Style.color.accent : Style.color.inactive
            border.width: Style.size.buttonBorder
        }
    }


    RowLayout {
        Layout.fillHeight: true
        Rectangle {
            id: switcher
            implicitWidth: 4; implicitHeight: 8
            color: "blue"
        }

        Rectangle {
            implicitHeight: parent.height
            implicitWidth: parent.height
            color : "green"
        }

        ColumnLayout {
            id: titleAndSlider
            Layout.alignment: Qt.AlignTop
            Layout.fillHeight: true
            spacing: 20

            ColumnLayout {
                spacing: 0
                Text {
                    Layout.alignment: Qt.AlignLeft
                    text: "This is the song title"
                    font.bold: true
                    color: Style.color.text
                }
                Text {
                    Layout.alignment: Qt.AlignLeft
                    text: "This is the artist"
                    color: Style.color.text
                }
            }

            ColumnLayout {
                spacing: 0
                PlayerSlider {
                    implicitWidth: titleAndSlider.width
                    Layout.alignment: Qt.AlignBottom
                    player: root.player
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 60
                    Text {
                        Layout.alignment: Qt.AlignLeft
                        text: "13:26"
                        color: Style.color.text
                    }
                    RowLayout {
                        PlayerButton {
                            icon: "󰑟"
                            player: root.player
                        }
                        PlayerButton {
                            icon: "󰐊"
                            player: root.player
                        }
                        PlayerButton {
                            icon: "󰈑"
                            player: root.player
                        }
                    }
                    Text {
                        Layout.alignment: Qt.AlignLeft
                        text: "54:12"
                        color: Style.color.text
                    }
                }

            }
        }
    }
}
