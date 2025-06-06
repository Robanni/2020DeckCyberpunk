import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    property alias text: handleField.text


    Row {
        spacing: 10
        Label { text: "Кличка:" }
        TextField {
            id: handleField
            width: 200
        }
    }
}
