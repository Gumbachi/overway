
import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Io

import qs.modules.datetime
import qs.modules.systemcontrol
import qs.modules.volume
import qs.modules.mediaplayer
import qs.modules.tray
import qs.config


PanelWindow {
    id: overway
    visible: true
    implicitHeight: layout.implicitHeight + Style.margin.scrim
    implicitWidth: layout.implicitWidth + Style.margin.scrim
    exclusionMode: ExclusionMode.Auto
	WlrLayershell.layer: WlrLayer.Overlay
	WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
	color: "transparent"

    Rectangle {
        id: scrim
        color: Style.color.scrim
	    radius: Style.rounding.soft
	    anchors.fill: parent
    }

    ColumnLayout {
        id: layout
        spacing: 10
        anchors.centerIn: scrim


        RowLayout {
            Datetime {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            MediaPlayer { Layout.fillHeight: true }
        }

        RowLayout {
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
