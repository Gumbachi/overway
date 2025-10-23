pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias color: adapter.color
    property alias rounding: adapter.rounding
    property alias margin: adapter.margin
    property alias size: adapter.size

    readonly property string homePath: Quickshell.env("HOME")
    readonly property string configPath: Quickshell.env("OVERWAY_CONFIG") || `${homePath}/.config/overway`

    FileView {
        path: `${root.configPath}/style.json`
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            try {
                JSON.parse(text())
                console.log("style.json loaded.")
            } catch (e) {
                console.error("Failed to load style.json")
                writeAdapter()
            }
        }
        onLoadFailed: err => console.error(`Failed to read style.json: ${err}`)
        onSaveFailed: err => console.error(`Failed to save style.json: ${err}`)
        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: adapter

            property Color color: Color {}
            property Rounding rounding: Rounding {}
            property Margin margin: Margin {}
            property Size size: Size {}

        }
    }

    component Color: JsonObject {
        property string text: "#F9F8F5"
        property string accent: "#66D9EF"
        property string background: "#272822"
        property string inactive: "#75715E"
        property string scrim: "#55CCCCCC" // #AARRGGBB
        property string scrim2: "#FFF"
    }

    component Rounding: JsonObject {
        property int hard: 4
        property int soft: 10
        property int circle: 360
    }

    component Margin: JsonObject {
        property int container: 10
        property int scrim: 50
    }

    component Size: JsonObject {
        property int containerBorder: 4
        property int buttonBorder: 2
    }
}
