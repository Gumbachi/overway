// pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Controls

import qs.config
import qs.components


Container {
    Rectangle {
        implicitHeight: 40
        implicitWidth: 40
        color: "red"

        MouseArea {
            anchors.fill: parent
            onClicked: console.log("Button Clicked")
        }
    }
}
