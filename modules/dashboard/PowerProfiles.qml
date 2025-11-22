
import QtQuick
import QtQuick.Layouts

import Quickshell.Services.UPower

import qs.config
import qs.components as Overway

Overway.Container {


    component PowerProfileButton: Overway.Button {
        required property string label

        implicitWidth: Style.size.trayButton
        implicitHeight: implicitWidth

        fontSize: 24
        fontFamily: "BlexMono Nerd Font"
    }

    RowLayout {

        PowerProfileButton {
            text: "󰌪"
            label: "Power-Saving"
            border.color: PowerProfiles.profile === PowerProfile.PowerSaver ? Style.color.accent : Style.color.inactive
            hoverEnabled: PowerProfiles.profile !== PowerProfile.PowerSaver
            onClicked: {
                PowerProfiles.profile = PowerProfile.PowerSaver
                console.log("Power Profile set to PowerSaver")
            }
        }
        PowerProfileButton {
            text: "󰇼"
            label: "Balanced"
            border.color: PowerProfiles.profile === PowerProfile.Balanced ? Style.color.accent : Style.color.inactive
            hoverEnabled: PowerProfiles.profile !== PowerProfile.Balanced
            onClicked: {
                PowerProfiles.profile = PowerProfile.Balanced
                console.log("Power Profile set to Balanced")
            }
        }
        PowerProfileButton {
            text: "󰓅"
            label: "Performance"
            border.color: PowerProfiles.profile === PowerProfile.Performance ? Style.color.accent : Style.color.inactive
            hoverEnabled: PowerProfiles.profile !== PowerProfile.Performance
            onClicked: {
                PowerProfiles.profile = PowerProfile.Performance
                console.log("Power Profile set to Performance")
            }
        }

    }
}
