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

    ColumnLayout {
        id: layout

        Text {
            text: clock.time
            color: Style.color.text
            font.bold: true
            font.pointSize: 32
            Layout.alignment: Qt.AlignCenter
        }

        Text {
            text: clock.date
            color: Style.color.text
            font.bold: true
            font.pointSize: 24
            Layout.alignment: Qt.AlignCenter
        }

        DatetimeService { id: clock }
    }
}
