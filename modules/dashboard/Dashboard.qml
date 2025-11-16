
import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Io

import qs.modules.datetime
import qs.modules.systemcontrol
import qs.modules.volume
import qs.modules.mediaplayers
import qs.modules.tray
import qs.modules.powerprofiles
import qs.modules.playground
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


    ColumnLayout {
        id: layout
        spacing: Style.spacing.gaps
        anchors.centerIn: scrim

        // Playground { Layout.fillWidth: false }

        RowLayout {
            spacing: Style.spacing.gaps
            Datetime {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            MediaPlayers { Layout.fillHeight: true }
        }

        RowLayout {
            spacing: Style.spacing.gaps
            Volume {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.minimumWidth: 250
            }
            SystemControl { Layout.fillHeight: true }
        }

        RowLayout {
            spacing: Style.spacing.gaps
            Tray {
                parentWindow: overway
                Layout.fillWidth: true
                Layout.fillHeight: true
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
