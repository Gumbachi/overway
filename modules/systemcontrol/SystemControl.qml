import QtQuick
import QtQuick.Layouts

import Quickshell.Widgets

RowLayout {
    id: root
    spacing: 8
    Layout.alignment: Qt.AlignCenter

    SystemControlService { id: service }

    SystemControlButton {
        icon: service.isIdleRunning ? "󰈉" : "󰈈"
        process: service.toggleIdle
    }

    SystemControlButton {
        icon: service.isNightlightRunning ? "󰖔" : ""
        process: service.toggleNightlight
    }

    // Separator
    Rectangle {
        Layout.preferredWidth: 4
        Layout.preferredHeight: 45
        color: "black"
        radius: 15
    }

    SystemControlButton {
        icon: ""
        process: service.lock
    }

    SystemControlButton {
        icon: ""
        process: service.restart
    }

    SystemControlButton {
        icon: ""
        process: service.shutdown
    }

}
