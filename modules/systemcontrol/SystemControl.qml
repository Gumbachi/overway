import QtQuick
import QtQuick.Layouts

import Quickshell.Widgets
import qs.config


WrapperRectangle {
    Layout.alignment: Qt.AlignHCenter
    margin: Style.margin.container
    radius: Style.rounding.soft
    border.width: Style.size.containerBorder
    border.color: Style.color.inactive
    color: Style.color.background

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
            Layout.preferredWidth: Style.size.buttonBorder
            Layout.preferredHeight: parent.implicitHeight * 0.7 // Fill 70% of height
            color: Style.color.inactive
            radius: 20
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
}
