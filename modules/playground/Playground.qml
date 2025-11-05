// pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Controls

import qs.config
import qs.components


Container {
    RowLayout {
        SineWave {}
        SineWave {}

        Item { Layout.fillWidth: true }
    }

}
