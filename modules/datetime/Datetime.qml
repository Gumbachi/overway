import QtQuick
import QtQuick.Layouts

import Quickshell.Widgets


WrapperRectangle {
    Layout.alignment: Qt.AlignHCenter
    margin: 8
    radius: 10
    border.width: 4
    color: "#272822"

    ColumnLayout {
        id: layout

        Text {
            text: clock.time
            color: "white"
            font.bold: true
            font.pointSize: 32
            Layout.alignment: Qt.AlignCenter
        }

        Text {
            text: clock.date
            color: "white"
            font.bold: true
            font.pointSize: 24
            Layout.alignment: Qt.AlignCenter
        }

        DatetimeService { id: clock }
    }
}
