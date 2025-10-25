
import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Io

import qs.modules.datetime
import qs.modules.systemcontrol
import qs.modules.volume
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
        spacing: 8
        anchors.centerIn: scrim


        Datetime { Layout.fillWidth: true }

        RowLayout {
            Volume {}
            SystemControl { implicitHeight: parent.height }
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
