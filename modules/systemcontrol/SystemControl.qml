import QtQuick
import QtQuick.Layouts

import qs.components

RowLayout {
    id: root
    spacing: 8
    Layout.alignment: Qt.AlignCenter

    property int buttonSize: 75
    property int borderWidth: 4
    property string borderColor: "red"

    SystemControlService { id: actions }

    CircleButton {
        Layout.preferredHeight: root.buttonSize
        Layout.preferredWidth: root.buttonSize
        onClicked: {
            icon = "󰈉"
            actions.killIdle
        }
        icon: "󰈈"
        borderColor: root.borderColor
        borderWidth: root.borderWidth
    }

    CircleButton {
        Layout.preferredHeight: root.buttonSize
        Layout.preferredWidth: root.buttonSize
        onClicked: actions.killIdle
        icon: "󰽥"
        borderColor: root.borderColor
        borderWidth: root.borderWidth
    }

    Rectangle {
        Layout.preferredWidth: 2
        Layout.preferredHeight: root.buttonSize - 20
        color: "gray"
    }

    CircleButton {
        Layout.preferredHeight: root.buttonSize
        Layout.preferredWidth: root.buttonSize
        onClicked: actions.lock
        icon: ""
        borderColor: root.borderColor
        borderWidth: root.borderWidth
    }

    CircleButton {
        Layout.preferredHeight: root.buttonSize
        Layout.preferredWidth: root.buttonSize
        onClicked: actions.restart
        icon: ""
        borderColor: root.borderColor
        borderWidth: root.borderWidth
    }

    CircleButton {
        Layout.preferredHeight: root.buttonSize
        Layout.preferredWidth: root.buttonSize
        onClicked: actions.shutdown
        icon: ""
        borderColor: root.borderColor
        borderWidth: root.borderWidth
    }

}
