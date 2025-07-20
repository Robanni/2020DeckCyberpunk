import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

TextField {
    id: field

    // === Public props ===
    property color floatingLabelBackground: "transparent"
    property color floatingLabelColor: "#888888"
    property string label: ""
    property real labelFontSize: Theme.fontSizeSmall
    property int labelMarginLeft: 20
    property int labelMarginTop: -8

    // === Style ===
    placeholderText: ""  // отключаем встроенный placeholder

    background: Rectangle {
        color: Theme.background
        radius: 4
        border.color: Theme.border
    }

    // === Всплывающий лейбл ===
    Item {
        id: floatingLabelItem
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: labelMarginLeft
        anchors.topMargin: labelMarginTop
        width: parent.width - 2 * labelMarginLeft
        height: 20
        z: 1

        visible: true
        opacity: field.activeFocus || field.text.length > 0 ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 150 }
        }

        Behavior on y {
            NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
        }

        y: (field.activeFocus || field.text.length > 0) ? 0 : field.height / 2 - 10
        x: (field.activeFocus || field.text.length > 0) ? labelMarginLeft : 12

        Rectangle {
            anchors.fill: parent
            radius: 4
            color: field.floatingLabelBackground
        }

        Text {
            anchors.centerIn: parent
            text: field.label
            color: field.floatingLabelColor
            font.pixelSize: field.labelFontSize
        }
    }

    // === Встроенный текст-плейсхолдер, если хотим показать при пустом поле ===
    // Можно отключить, если не нужен второй текст:

    Text {
        visible: !field.activeFocus && field.text.length === 0
        text: field.label
        color: "#999999"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 12
        z: 0
    }

}
