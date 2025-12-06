pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

Singleton {
    FileView {

        readonly property string homePath: Quickshell.env("HOME")
        readonly property string configPath: Quickshell.env("OVERWAY_CONFIG") || `${homePath}/.config/overway`

        path: `${configPath}/config.json`
        watchChanges: true

        onFileChanged: reload()

        onLoaded: {
            try {
                console.log("Config loaded.")
                JSON.parse(text())
            } catch (e) {
                console.error("Failed to load config.")
            }
        }

        onLoadFailed: err => {
            console.error(`Failed to read config: ${err}`)
            console.log("Attempting to write default.")
            writeAdapter()
        }
        onSaveFailed: err => console.error(`Failed to save config: ${err}`)

        JsonAdapter {
            property bool use24hour: true
        }
    }
}
