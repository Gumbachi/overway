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

    StackLayout {
        id: playerStack
        currentIndex: root.currentPlayerIndex

        Repeater {
            model: root.players
            Player {
                required property MprisPlayer modelData
                player: modelData
                playerCount: root.players.length

                function onCycleClicked() {
                    if (root.currentPlayerIndex >= root.players.length - 1) {
                        root.currentPlayerIndex = 0
                    } else {
                        root.currentPlayerIndex += 1
                    }
                    console.log(root.currentPlayerIndex)
                }
            }
        }
    }

}


// Old Switcher
        // RowLayout {
        //     Layout.alignment: Qt.AlignCenter
        //     Layout.rightMargin: 50
        //     Layout.leftMargin: 50
        //     Repeater {
        //         model: root.players.length
        //         Rectangle {
        //             required property int index
        //             Layout.fillWidth: true
        //             implicitHeight: 8
        //             radius: Style.rounding.hard
        //             color: index === root.currentPlayerIndex ? Style.color.accent : Style.color.inactive

        //             MouseArea {
        //                 anchors.fill: parent
        //                 onClicked: root.currentPlayerIndex = parent.index
        //             }
        //         }
        //     }
        // }
