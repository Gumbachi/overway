
import QtQuick

import Quickshell
import Quickshell.Wayland

PanelWindow {

    implicitHeight: window.implicitHeight
    implicitWidth: window.implicitWidth

	WlrLayershell.layer: WlrLayer.Background
	WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
	exclusiveZone: 40

    anchors {
        // top: true
        // bottom: true
        left: true
       // right: true
    }

    Rectangle {
        id: window
        radius: 10.0
        anchors.fill: parent
        color: "red"
        opacity: 0.5
    }

}
