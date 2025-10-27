import QtQuick
import QtQuick.Layouts

import Quickshell.Services.SystemTray

import qs.config
import qs.components

Container {
    RowLayout {
        Repeater {
            model: SystemTray.items.values
            Rectangle {
                required property int index
                required property SystemTrayItem modelData

                id: trayItem

                Layout.preferredWidth: 40;
                Layout.preferredHeight: Layout.preferredWidth


                radius: Style.rounding.circle
                border.width: Style.size.buttonBorder
                border.color: Style.color.inactive
                color: "transparent"
                Layout.alignment: Qt.AlignCenter

                Image {
                    width: 24; height: width
                    anchors.centerIn: parent
                    source: trayItem.modelData.icon
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: event => {
                        console.log(trayItem.width)
                        if (event.button === Qt.LeftButton)
                            trayItem.modelData.activate()
                        else
                            trayItem.modelData.secondaryActivate()
                    }
                    hoverEnabled: true
                    onEntered: parent.border.color = Style.color.accent
                    onExited: parent.border.color = Style.color.inactive
                }
            }
        }

        // Filler item to get items to be left aligned in the rowlayout
        Item { Layout.fillWidth: true }
    }
}
