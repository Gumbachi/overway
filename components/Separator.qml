
import QtQuick

import qs.config

Rectangle {
    property int orientation: Qt.Vertical
    property real sizeRatio: 0.75
    readonly property bool vertical: orientation === Qt.Vertical

    color: Style.color.inactive
    radius: 20

    implicitWidth: vertical ? Style.borders.button : parent.width * sizeRatio
    implicitHeight: vertical ? parent.height * sizeRatio : Style.borders.button
}
