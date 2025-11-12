import QtQuick
import QtQuick.Layouts

import Quickshell.Io

import qs.config
import qs.components

Container {

    SystemControlService { id: service }

    component Button: Rectangle {
        required property string icon
        required property Process process

        implicitWidth: 65; implicitHeight: implicitWidth
        radius: Style.rounding.circle
        border.width: Style.size.buttonBorder
        border.color: Style.color.inactive
        color: "transparent"

        Text {
            text: parent.icon
            anchors.centerIn: parent
            font.pixelSize: 36
            font.family: "BlexMono Nerd Font"
            color: Style.color.text
        }

        MouseArea {
            anchors.fill: parent
            onClicked: parent.process.running = true
            hoverEnabled: true
            onEntered: parent.border.color = Style.color.accent
            onExited: parent.border.color = Style.color.inactive
        }
    }

    component Separator: Rectangle {
        Layout.preferredWidth: Style.size.buttonBorder
        Layout.preferredHeight: parent.implicitHeight * 0.8 // Fill 70% of height
        color: Style.color.inactive
        radius: 20
        Layout.rightMargin: 4
        Layout.leftMargin: 4
    }

    RowLayout {
        spacing: 8

        Button {
            icon: service.isIdleRunning ? "󰈉" : "󰈈"
            process: service.toggleIdle
        }

        Button {
            icon: service.isNightlightRunning ? "󰖔" : ""
            process: service.toggleNightlight
        }

        Separator {}

        Button { icon: ""; process: service.lock }
        Button { icon: ""; process: service.restart }
        Button { icon: ""; process: service.shutdown }

    }
}
