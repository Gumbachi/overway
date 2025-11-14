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

    Loader {

        readonly property Component nothingPlaying: NothingPlaying {}
        readonly property Component player: Player {
            player: root.players[root.currentPlayerIndex]
            playerCount: root.players.length
            onCycleClicked: {
                if (root.currentPlayerIndex >= root.players.length - 1) {
                    root.currentPlayerIndex = 0
                } else {
                    root.currentPlayerIndex += 1
                }
                console.log(root.currentPlayerIndex)
            }
        }

        sourceComponent: root.players.length === 0 ? nothingPlaying: player

    }


}
