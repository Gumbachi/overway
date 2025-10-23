
import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Io
import qs.modules.datetime
import qs.modules.systemcontrol

PanelWindow {
    id: overway
    visible: true
    implicitHeight: layout.implicitHeight + 100// add 100 as margin
    implicitWidth: layout.implicitWidth + 100
    exclusionMode: ExclusionMode.Auto
	WlrLayershell.layer: WlrLayer.Overlay
	WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
	color: "transparent"

	property int containerMargin: 12
	property int containerRadius: 10
	property int containerBorderWidth: 4
	property string containerColor: "#272822"


    Rectangle {
        id: scrim
        color: "#55CCCCCC"
	    radius: 10
	    anchors.fill: parent
    }

    ColumnLayout {
        id: layout
        spacing: 8
        anchors.centerIn: scrim

        Datetime {}

        WrapperRectangle {
            Layout.alignment: Qt.AlignHCenter
            margin: overway.containerMargin
            radius: overway.containerRadius
            border.width: overway.containerBorderWidth
            color: overway.containerColor
            SystemControl {}
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
