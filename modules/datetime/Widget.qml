import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    Service { id: clock }

    spacing: 2
    Layout.alignment: Qt.AlignCenter
    
    Text {
        text: clock.time
        font.bold: true
        font.pointSize: 32
        Layout.alignment: Qt.AlignCenter
    }

    Text {
        text: clock.date
        font.bold: true
        font.pointSize: 24
        Layout.alignment: Qt.AlignCenter
    }
}

