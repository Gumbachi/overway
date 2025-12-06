import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Widgets

import qs.config
import qs.components


PanelWindow {

    id: launcher
    visible: false
    implicitHeight: layout.implicitHeight + Style.margin.scrim
    implicitWidth: layout.implicitWidth + Style.margin.scrim
    // exclusionMode: ExclusionMode.Ignore // Prevent overlay from reserving space
	WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    color: "transparent"

    Rectangle {
        id: frame
        color: Style.color.background
	    radius: Style.rounding.soft
	    anchors.fill: parent
	    border.width: Style.borders.container
	    border.color: Style.color.accent
    }

    GridLayout {
        id: layout
        rowSpacing: Style.spacing.gaps
        columnSpacing: Style.spacing.gaps
        anchors.fill: frame
        anchors.margins: Style.margin.container
        rows: 2
        columns: 3

        // Search Bar
        Rectangle {
            id: search
            implicitWidth: 400
            implicitHeight: 50
            color: "transparent"

            Layout.columnSpan: 3
            Layout.fillWidth: true
            Text {
                text: ">>"
                font.pixelSize: 36
                color: Style.color.text
            }
        }

        // App List
        ListView {
            implicitWidth: 400
            implicitHeight: 500
            model: DesktopEntries.applications
            delegate: RowLayout {
                id: entry
                required property DesktopEntry modelData
                IconImage {
                    source: Quickshell.iconPath(entry.modelData.icon)
                    implicitSize: 30
                    Component.onCompleted: console.log(`ICON: ${entry.modelData.icon}`)
                }
                Text {
                    text: entry.modelData.name
                    font.pixelSize: 24
                    color: Style.color.text
                    // Component.onCompleted: console.log(modelData.name)
                }
            }
        }
    }


	// Allow hiding with ESC
    contentItem {
        focus: true
        Keys.onPressed: event => {
            if (event.key == Qt.Key_Escape) launcher.visible = false
        }
    }

    // Toggle launcher on/off externally
    IpcHandler {
        target: "launcher"
        function toggle(): void { launcher.visible = !launcher.visible }
    }

}
