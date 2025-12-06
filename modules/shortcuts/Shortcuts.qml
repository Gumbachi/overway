import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Io

import qs.config


PanelWindow {

    id: shortcuts
    visible: false
    implicitHeight: layout.implicitHeight + Style.margin.scrim
    implicitWidth: layout.implicitWidth + Style.margin.scrim
    // exclusionMode: ExclusionMode.Ignore // Prevent overlay from reserving space
	WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
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

        Rectangle {
            implicitWidth: 20
            implicitHeight: 20
        }

    }

	// Allow hiding with ESC
    contentItem {
        focus: true
        Keys.onPressed: event => {
            if (event.key == Qt.Key_Escape) shortcuts.visible = false
        }
    }

    // Toggle shortcuts on/off externally
    IpcHandler {
        target: "shortcuts"
        function toggle(): void { shortcuts.visible = !shortcuts.visible }
    }

}
