import QtQuick
import QtQuick.Layouts

ColumnLayout {
    spacing: 2
    Layout.alignment: Qt.AlignCenter
    
    Text {
        text: TimeProcess.time
        font.bold: true
        font.pointSize: 32
        Layout.alignment: Qt.AlignCenter
    }

    Text {
        text: TimeProcess.date
        font.bold: true
        font.pointSize: 24
        Layout.alignment: Qt.AlignCenter
    }
}

