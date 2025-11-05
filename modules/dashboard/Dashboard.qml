
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
import qs.modules.playground
import qs.config


PanelWindow {
    id: overway
    visible: true
    implicitHeight: layout.implicitHeight + Style.dashboard.scrimMargin
    implicitWidth: layout.implicitWidth + Style.dashboard.scrimMargin
    exclusionMode: ExclusionMode.Ignore // Prevent overlay from reserving space
	WlrLayershell.layer: WlrLayer.Overlay
	WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
	color: "transparent"

    Rectangle {
        id: scrim
        color: Style.color.scrim
	    radius: Style.dashboard.scrimRounding
	    anchors.fill: parent
    }


    ColumnLayout {
        id: layout
        spacing: Style.dashboard.verticalGapSize
        anchors.centerIn: scrim

        // Playground { Layout.fillWidth: true }

        RowLayout {
            spacing: Style.dashboard.horizontalGapSize
            Datetime {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            MediaPlayers { Layout.fillHeight: true }
        }

        RowLayout {
            spacing: Style.dashboard.horizontalGapSize
            Volume {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.minimumWidth: 250
            }
            SystemControl { Layout.fillHeight: true }
        }

        Tray {
            Layout.fillWidth: true
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
