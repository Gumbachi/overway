pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {

    property alias color: style.color
    property alias rounding: style.rounding
    property alias spacing: style.spacing
    property alias margin: style.margin
    property alias borders: style.borders
    property alias size: style.size
    property alias fontFamily: style.fontFamily
    property alias fontSize: style.fontSize

    FileView {
        readonly property string homePath: Quickshell.env("HOME")
        readonly property string configPath: Quickshell.env("OVERWAY_CONFIG") || `${homePath}/.config/overway`

        path: `${configPath}/style.json`
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            try {
                JSON.parse(text())
                console.log("style.json loaded.")
            } catch (e) {
                console.error("Failed to load style.json")
                // writeAdapter()
            }
        }
        onLoadFailed: err => console.error(`Failed to read style.json: ${err}`)
        onSaveFailed: err => console.error(`Failed to save style.json: ${err}`)

        JsonAdapter {
            id: style

            property Color color: Color {}
            property Rounding rounding: Rounding {}
            property Spacing spacing: Spacing {}
            property Margin margin: Margin {}
            property Borders borders: Borders {}
            property Size size: Size {}
            property FontFamily fontFamily: FontFamily {}
            property FontSize fontSize: FontSize {}

        }
    }

    component Color: JsonObject {
        property string text: "#F9F8F5"
        property string accent: "#66D9EF"
        property string background: "#272822"
        property string inactive: "#75715E"
        property string scrim: "#55CCCCCC" // #AARRGGBB
    }

    component Rounding: JsonObject {
        property int none: 0
        property int hard: 4
        property int soft: 8
        property int full: 360
    }

    component Spacing: JsonObject {
        property int small: 2
        property int medium: 4
        property int large: 8
        property int extraLarge: 16

        property int gaps: large
        property int mediaControls: small
    }

    component Margin: JsonObject {
        property int scrim: 48
        property int container: 8
    }

    component Borders: JsonObject {
        property int container: 4
        property int button: 1
    }

    component Size: JsonObject {
        property int systemControlButton: 64
        property int volumeControlButton: 40
        property int mediaPlayerButton: 28
        property int trayButton: 40
    }

    component FontSize: JsonObject {
        property int displayLarge: 36
        property int displayMedium: 24
        property int titleMedium: 18
        property int titleSmall: 14
    }

    component FontFamily: JsonObject {
        property string symbols: "BlexMono Nerd Font"
        property string standard: "Inter"
    }
}
