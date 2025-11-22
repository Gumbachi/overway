pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {

    property alias counters: state.counters

    FileView {
        readonly property string homePath: Quickshell.env("HOME")
        readonly property string configPath: Quickshell.env("OVERWAY_CONFIG") || `${homePath}/.config/overway`

        path: `${configPath}/state.json`
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            try {
                JSON.parse(text())
            } catch (e) {
                console.error("Failed to load state.json")
            }
        }
        onLoadFailed: err => writeAdapter()
        onSaveFailed: err => console.error(`Failed to save state.json: ${err}`)
        onAdapterUpdated: writeAdapter() // Update the file when properties change

        JsonAdapter {
            id: state
            property list<JsonObject> counters: []
        }
    }


}
