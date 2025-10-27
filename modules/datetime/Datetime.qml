import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components

Container {
    id: root

    DatetimeService { id: clock }

    ColumnLayout {

        Item { Layout.fillHeight: true }

        Text {
            text: clock.time
            color: Style.color.text
            font.bold: true
            font.pointSize: 36
            Layout.alignment: Qt.AlignBottom | Qt.AlignCenter
        }

        Text {
            text: clock.date
            color: Style.color.text
            font.bold: true
            font.pointSize: 24
            Layout.alignment: Qt.AlignCenter
        }
    }
}
