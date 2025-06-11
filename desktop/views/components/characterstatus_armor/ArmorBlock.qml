import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    width: 120
    height: 100
    color: "#0f3460"
    radius: 6
    border.color: "#e94560"
    border.width: 2

    property string label: ""
    property int value: 0

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 6

        Text {
            text: root.label
            font.bold: true
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: root.value.toString()
            font.pixelSize: 26
            font.bold: true
            color: "#e94560"
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
