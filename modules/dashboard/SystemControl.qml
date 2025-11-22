import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components as Overway

Overway.Container {

    SystemControlService { id: service }

    component SystemControlButton: Overway.Button {
        implicitWidth: Style.size.systemControlButton
        implicitHeight: implicitWidth

        fontSize: 36
        fontFamily: "BlexMono Nerd Font"
    }

    RowLayout {
        spacing: 8

        SystemControlButton {
            text: service.isIdleRunning ? "󰈉" : "󰈈"
            onClicked: service.toggleIdle.running = true
        }

        SystemControlButton {
            text: service.isNightlightRunning ? "󰖔" : ""
            onClicked: service.toggleNightlight.running = true
        }

        Overway.Separator {
            sizeRatio: 0.5
            Layout.margins: 4
        }

        SystemControlButton {
            text: ""
            onClicked: service.lock.running = true
        }

        SystemControlButton {
            text: ""
            onClicked: service.restart.running = true
        }

        SystemControlButton {
            text: ""
            onClicked: service.shutdown.running = true
        }

    }
}
