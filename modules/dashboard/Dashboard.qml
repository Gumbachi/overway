
import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Io

import qs.config


PanelWindow {

    id: overway
    visible: true
    implicitHeight: layout.implicitHeight + Style.margin.scrim
    implicitWidth: layout.implicitWidth + Style.margin.scrim
    exclusionMode: ExclusionMode.Ignore // Prevent overlay from reserving space
	WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
	color: "transparent"

    Rectangle {
        id: scrim
        color: Style.color.scrim
	    radius: Style.rounding.soft
	    anchors.fill: parent
    }

    GridLayout {
        id: layout
        rowSpacing: Style.spacing.gaps
        columnSpacing: Style.spacing.gaps
        anchors.centerIn: scrim

        columns: 1
        rows: 3

        // Counters {
        //     Layout.rowSpan: 3
        //     Layout.fillHeight: true
        // }

        RowLayout {
            spacing: Style.spacing.gaps
            Datetime {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            MediaPlayers {
                Layout.fillHeight: true
            }
        }

        RowLayout {
            spacing: Style.spacing.gaps
            Volume {
                Layout.fillWidth: true
            }
            SystemControl {
                Layout.fillHeight: true
            }
        }

        RowLayout {
            spacing: Style.spacing.gaps
            Tray {
                parentWindow: overway
                Layout.fillWidth: true
            }
            PowerProfiles {}
        }
    }

	// Allow hiding with ESC
    contentItem {
        focus: true
        Keys.onPressed: event => {
            if (event.key == Qt.Key_Escape) overway.visible = false
        }
    }


    // Toggle overlay on/off externally
    IpcHandler {
        target: "overway"
        function toggle(): void { overway.visible = !overway.visible }
    }

}
