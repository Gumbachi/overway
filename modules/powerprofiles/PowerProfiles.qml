
import QtQuick
import QtQuick.Layouts

import Quickshell.Services.UPower

import qs.components
import qs.config

Container {


    component PowerProfileButton: Rectangle {
        id: ppbutton
        required property string icon
        required property string label
        function onClick() { console.log("ppbutton clicked") }

        property bool hoverEnabled: true

        implicitWidth: 40
        implicitHeight: implicitWidth

        radius: Style.rounding.circle
        border.width: Style.size.buttonBorder
        border.color: Style.color.inactive
        color: "transparent"

        Text {
            text: ppbutton.icon
            anchors.centerIn: parent
            font.pixelSize: 24
            font.family: "JetbrainsMono Nerd Font"
            color: Style.color.text
        }

        MouseArea {
            anchors.fill: parent
            onClicked: parent.onClick()
            hoverEnabled: parent.hoverEnabled
            onEntered: parent.border.color = Style.color.accent
            onExited: {
                if (parent.hoverEnabled)
                    parent.border.color = Style.color.inactive
            }
        }

    }

    RowLayout {

        PowerProfileButton {
            icon: "󰌪"
            label: "Power-Saving"
            border.color: PowerProfiles.profile === PowerProfile.PowerSaver ? Style.color.accent : Style.color.inactive
            hoverEnabled: PowerProfiles.profile !== PowerProfile.PowerSaver
            function onClick() {
                PowerProfiles.profile = PowerProfile.PowerSaver
                console.log("Power Profile set to PowerSaver")
            }
        }
        PowerProfileButton {
            icon: "󰇼"
            label: "Balanced"
            border.color: PowerProfiles.profile === PowerProfile.Balanced ? Style.color.accent : Style.color.inactive
            hoverEnabled: PowerProfiles.profile !== PowerProfile.Balanced
            function onClick() {
                PowerProfiles.profile = PowerProfile.Balanced
                console.log("Power Profile set to Balanced")
            }
        }
        PowerProfileButton {
            icon: "󰓅"
            label: "Performance"
            border.color: PowerProfiles.profile === PowerProfile.Performance ? Style.color.accent : Style.color.inactive
            hoverEnabled: PowerProfiles.profile !== PowerProfile.Performance
            function onClick() {
                PowerProfiles.profile = PowerProfile.Performance
                console.log("Power Profile set to Performance")
            }
        }

    }
}
