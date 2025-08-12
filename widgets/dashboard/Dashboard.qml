import "../datetime"
import "../systemcontrols"

import Quickshell
import QtQuick
import Quickshell.Wayland
import QtQuick.Layouts

PanelWindow {
    implicitHeight: 400
    implicitWidth: 400

    exclusionMode: ExclusionMode.Ignore
	WlrLayershell.layer: WlrLayer.Overlay
	WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive


    contentItem {        
        focus: true
        Keys.onPressed: event => {
            if (event.key == Qt.Key_Escape) Qt.quit()
        }
    }

    ColumnLayout {
        spacing: 8
        anchors.fill: parent

        Datetime {}

        SystemControls {}

    }

}
