pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components

Loader {
    id: root
    required property string name
    required property int value

    readonly property Component counter: GridLayout {
        rows: 2
        columns: 3
        // uniformCellWidths: true

        Text {
            text: root.name
            Layout.columnSpan: 3
            color: Style.color.text
            font.bold: true
            Layout.minimumWidth: 150
        }

        CircleButton {
            text: "-"
            onClicked: root.value -= 1
        }

        Text {
            text: root.value
            color: Style.color.text
            font.pixelSize: Style.fontSize.displayMedium
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }

        CircleButton {
            text: "+"
            onClicked: root.value += 1
        }


    }

    readonly property Component settings: Item {}

    sourceComponent: counter

}
