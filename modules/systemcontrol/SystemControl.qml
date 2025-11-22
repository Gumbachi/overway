import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components

Container {

    SystemControlService { id: service }

    component Button: CircleButton {
        implicitWidth: Style.size.systemControlButton
        implicitHeight: implicitWidth

        fontSize: 36
        fontFamily: "BlexMono Nerd Font"
    }

    RowLayout {
        spacing: 8

        Button {
            text: service.isIdleRunning ? "󰈉" : "󰈈"
            onClicked: service.toggleIdle.running = true
        }

        Button {
            text: service.isNightlightRunning ? "󰖔" : ""
            onClicked: service.toggleNightlight.running = true
        }

        Separator {
            sizeRatio: 0.5
            Layout.margins: 4
        }

        Button {
            text: ""
            onClicked: service.lock.running = true
        }

        Button {
            text: ""
            onClicked: service.restart.running = true
        }

        Button {
            text: ""
            onClicked: service.shutdown.running = true
        }

    }
}
