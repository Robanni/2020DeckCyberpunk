import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../../shared" 

Rectangle {
    id: root
    width: 120
    height: 130
    radius: Theme.borderRadius
    color: Theme.background
    border.color: Theme.border
    border.width: Theme.borderWidth

    property string label: ""
    property int value: 0

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Theme.spacingMedium
        spacing: Theme.spacingMedium

        Text {
            text: root.label
            font.bold: true
            font.pixelSize: Theme.fontSizeNormal
            color: Theme.foreground
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
            wrapMode: Text.WordWrap
        }

        Text {
            text: root.value.toString()
            font.pixelSize: Theme.fontSizeLarge
            font.bold: true
            color: Theme.accent
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: Theme.spacingSmall

            ToolButton {
                text: "-"
                font.bold: true
                implicitWidth: 24
                implicitHeight: 24
                onClicked: if (root.value > 0) root.value--
                background: Rectangle {
                    radius: 4
                    color: Theme.surface
                    border.color: Theme.border
                }
            }

            ToolButton {
                text: "+"
                font.bold: true
                implicitWidth: 24
                implicitHeight: 24
                onClicked: root.value++
                background: Rectangle {
                    radius: 4
                    color: Theme.surface
                    border.color: Theme.border
                }
            }
        }
    }
}
