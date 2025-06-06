import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    property alias text: nameField.text

    Row {
        spacing: 10
        Label { text: "Имя:" }
        TextField {
            id: nameField
            width: 200
        }
    }
}
