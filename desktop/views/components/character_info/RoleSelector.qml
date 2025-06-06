import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id:root
    property string role: ""  

    readonly property var roles: ["Solo", "Netrunner", "Fixer", "Techie", "Rockerboy", "Medtech"]

    Row {
        spacing: 10
        Label { text: "Роль:" }
        ComboBox {
            id: combo
            width: 200
            model: root.roles

            Component.onCompleted: {
                const idx = root.roles.indexOf(root.role)
                if (idx !== -1) combo.currentIndex = idx
            }

            onCurrentIndexChanged: {
                role = root.roles[currentIndex]
            }
        }
    }
}
