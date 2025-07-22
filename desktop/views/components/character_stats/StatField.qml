import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15

RowLayout {
    id: root

    property string label: ""
    property int value: 1
    property int maxValue: 20
    signal spinValueChanged(int newValue)

    property int internalValue: value

    spacing: 15
    Layout.fillWidth: true
    implicitHeight: 40

    onValueChanged: {
        if (internalValue !== value) {
            internalValue = value
        }
    }

    Label {
        text: root.label
        color: "#e94560"
        font.bold: true
        font.pixelSize: 14
        verticalAlignment: Text.AlignVCenter
        Layout.preferredWidth: 150
        Layout.fillHeight: true
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter
        implicitHeight: 8
        radius: height / 2
        color: "#0f3460"

        Rectangle {
            width: parent.width * (internalValue / root.maxValue)
            height: parent.height
            radius: parent.radius
            color: "#e94560"
            Behavior on width { NumberAnimation { duration: 150 } }
        }
    }

    SpinBox {
        id: spinBox
        from: 1
        to: root.maxValue
        stepSize: 1
        editable: true
        value: internalValue

        Material.accent: "#e94560"
        Material.foreground: "white"
        Material.background: "#16213e"

        contentItem: TextInput {
            id: textInput
            text: spinBox.value.toString()
            color: "white"
            font.bold: true
            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter
            inputMethodHints: Qt.ImhDigitsOnly

            onEditingFinished: {
                var newValue = parseInt(text);
                if (!isNaN(newValue)) {
                    newValue = Math.min(Math.max(newValue, spinBox.from), spinBox.to);
                    if (newValue !== spinBox.value) {
                        spinBox.value = newValue;
                    }
                } else {
                    text = spinBox.value.toString();
                }
            }
        }

        onValueChanged: {
            if (internalValue !== value) {
                internalValue = value;
                if (root.value !== value) {
                    root.value = value;
                    root.spinValueChanged(value);
                }
            }
        }

        up.indicator: Rectangle {
            x: spinBox.width - width
            height: spinBox.height
            width: 30
            color: Material.accentColor
            radius: 4
            Text {
                text: "+"
                color: "white"
                font.bold: true
                anchors.centerIn: parent
            }
        }

        down.indicator: Rectangle {
            height: spinBox.height
            width: 30
            color: Material.accentColor
            radius: 4
            Text {
                text: "-"
                color: "white"
                font.bold: true
                anchors.centerIn: parent
            }
        }
    }
}
