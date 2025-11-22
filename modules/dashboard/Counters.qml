import QtQuick
import QtQuick.Layouts

import qs.components

Container {
    id: root

    ColumnLayout {
        spacing: 16

        Repeater {
            model: 4

            Counter {
                required property int index
                name: `Counter ${index + 1}`
                value: 0
            }

        }
    }

}
