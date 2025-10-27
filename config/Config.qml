pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property string homePath: Quickshell.env("HOME")
    readonly property string configPath: Quickshell.env("OVERWAY_CONFIG") || `${homePath}/.config/overway`

    FileView {
        path: `${root.configPath}/config.json`
        blockLoading: false
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
        onLoadFailed: err => console.error(`Failed to read config: ${err}`)
        onSaveFailed: err => console.error(`Failed to save config: ${err}`)
        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: adapter

        }
    }
}
