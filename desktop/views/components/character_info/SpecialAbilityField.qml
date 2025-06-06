import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    property alias text: abilityField.text

    Row {
        spacing: 10
        Label { text: "Классовый навык:" }
        TextField {
            id: abilityField
            width: 200
        }
    }
}
