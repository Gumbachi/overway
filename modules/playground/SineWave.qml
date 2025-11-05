// pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes

import qs.config
import qs.components

Shape {
    id: root
    property int amplitude: 50
    property int wavelength: 100
    property int halfWavelength: wavelength / 2

    property int offsetX
    property int offsetXNegative

    // anchors.centerIn: parent
    // anchors.fill: parent

    // SequentialAnimation on amplitude {
    //     loops: Animation.Infinite
    //     NumberAnimation { from: 0; to: 50; duration: 500 }
    //     NumberAnimation { from: 50; to: 0; duration: 500 }
    // }

    SequentialAnimation on offsetX {
        loops: Animation.Infinite
        NumberAnimation { from: 0; to: 100; duration: 1500 }
    }


    SequentialAnimation on offsetXNegative {
        loops: Animation.Infinite
        NumberAnimation { from: 0; to: -100; duration: 1500 }
    }

    ShapePath {
        strokeWidth: 4
        strokeColor: Style.color.accent
        strokeStyle: ShapePath.SolidLine
        fillColor: "transparent"
        // startX: root.offsetX

        // PathLine { relativeX: 100; relativeY: 50 }
        // PathLine { relativeX: 100; y: 100 }

        // PathMove { x: root.offsetXNegative; y: 0 }
        PathQuad {
            relativeX: 100
            relativeControlX: 50
            controlY: root.amplitude / 2
        }
        // PathMove { relativeX: root.offsetXNegative; y: 0 }
        PathQuad {
            relativeX: 100;
            relativeControlX: 50
            controlY: -root.amplitude / 2
        }
    }
}

// Container {
//     id: root
//     // Layout.fillWidth: true
//     // implicitHeight: 200


//     // Path {
//     //     startX: root.x
//     //     startY: root.y
//     //     PathLine { x: 200; y: 100}
//     // }

//     // RowLayout {
//     //     Rectangle {
//     //         color: "green"
//     //         Layout.preferredWidth: 20
//     //         Layout.preferredHeight: 20
//     //     }
//     // }

// }
