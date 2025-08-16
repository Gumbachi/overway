
import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import qs.modules.datetime as Datetime
import qs.modules.systemcontrol as SystemControl

PanelWindow {
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth
    exclusionMode: ExclusionMode.Auto
	WlrLayershell.layer: WlrLayer.Overlay
	WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

    contentItem {        
        focus: true
        Keys.onPressed: event => {
            if (event.key == Qt.Key_Escape) Qt.quit()
        }
    }

    ColumnLayout {
        id: layout
        spacing: 8
        anchors.fill: parent

        Datetime.Widget {}

        SystemControl.Widget {}

    }

}
