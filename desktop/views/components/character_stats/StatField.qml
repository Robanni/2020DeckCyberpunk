import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15

RowLayout {
    id:root
    property string label
    property int value
    property int maxValue:20
    signal spinValueChanged(int newValue)

    spacing: 15
    Layout.fillWidth: true
    Layout.preferredHeight: 40

    // Метка характеристики
    Label {
        text: label
        color: "#e94560"
        font.bold: true
        font.pixelSize: 14
        Layout.preferredWidth: 150
    }

    // Индикатор уровня
    Rectangle {
        Layout.fillWidth: true
        height: 8
        radius: 4
        color: "#0f3460"

        Rectangle {
            width: parent.width * (parent.parent.value / root.maxValue)
            height: parent.height
            radius: 4
            color: "#e94560"
        }
    }

    // Числовое значение
    SpinBox {
        value: parent.value
        from: 1
        to: root.maxValue
        editable: true
        Material.accent: Material.Purple
        Material.foreground: "white"

        onValueChanged: {
            parent.value = value
            parent.spinValueChanged(value)
        }

        contentItem: Text {
            text: parent.value
            color: "white"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}