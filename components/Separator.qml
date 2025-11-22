
import QtQuick
import QtQuick.Controls

import qs.config

Control {
    id: root
    property int orientation: Qt.Vertical
    property real sizeRatio: 0.75
    readonly property bool vertical: orientation === Qt.Vertical

    implicitWidth: root.vertical ? Style.borders.button : parent.width * sizeRatio
    implicitHeight: root.vertical ? parent.height * sizeRatio : Style.borders.button

    // horizontalPadding: vertical ? padding : 0
    // verticalPadding: vertical ? 0 : padding
    // padding: 24

    Rectangle {
        anchors.fill: parent
        color: Style.color.inactive
        radius: 20
    }
}
