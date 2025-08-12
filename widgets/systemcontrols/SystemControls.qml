import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 2
    Layout.alignment: Qt.AlignCenter

    Rectangle {
        Layout.preferredHeight: 100
        Layout.preferredWidth: 100
        radius: 360        
        color: "red"

        MouseArea {
            anchors.fill: parent
            onClicked: SystemControlsProcess.shutdown.startDetached()
        }
    }
    
    Rectangle {
        Layout.preferredHeight: 100
        Layout.preferredWidth: 100
        radius: 360        
        color: "blue"
    }

    Rectangle {
        Layout.preferredHeight: 100
        Layout.preferredWidth: 100
        radius: 360        
        color: "yellow"
    }
}

