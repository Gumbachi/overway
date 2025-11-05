import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components

Container {
    id: root

    DatetimeService { id: clock }

    ColumnLayout {
        // anchors.fill: parent
        spacing: -15
        anchors.centerIn: parent

        // Item { Layout.fillHeight: true }

        Text {
            text: clock.time
            color: Style.color.text
            font.bold: true
            font.pointSize: 36
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }

        Text {
            text: clock.date
            color: Style.color.text
            font.bold: true
            font.pointSize: 24
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }
    }
}
