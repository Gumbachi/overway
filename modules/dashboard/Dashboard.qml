
import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import qs.modules.datetime
import qs.modules.systemcontrol

PanelWindow {
    id: overway
    visible: true
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth
    exclusionMode: ExclusionMode.Auto
	WlrLayershell.layer: WlrLayer.Overlay
	WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

	// Allow hiding with ESC
    contentItem {
        focus: true
        Keys.onPressed: event => {
            if (event.key == Qt.Key_Escape) overway.visible = false
        }
    }

    ColumnLayout {
        id: layout
        spacing: 8
        anchors.fill: parent

        Datetime {}

        SystemControl {}
    }

    // Toggle overlay on/off externally
    IpcHandler {
        target: "overway"
        function toggle(): void { overway.visible = !overway.visible }
    }

}
