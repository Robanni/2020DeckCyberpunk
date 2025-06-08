import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

GridLayout {
    id: root
    columns: 2
    columnSpacing: 20
    rowSpacing: 15
    property var infoBridge:characterBridge.info


    Label {
        text: "ОСНОВНАЯ ИНФОРМАЦИЯ"
        font.bold: true
        font.pixelSize: 16
        color: "#e94560"
        Layout.columnSpan: 2
        Layout.bottomMargin: 10
    }

    NameField {
        text: root.infoBridge ? root.infoBridge.name : ""
        onTextChanged: if (root.infoBridge) root.infoBridge.name = text
        Layout.fillWidth: true
    }

    HandleField {
        text: root.infoBridge ? root.infoBridge.handle : ""
        onTextChanged: if (root.infoBridge) root.infoBridge.handle = text
        Layout.fillWidth: true
    }

    RoleSelector {
        role: root.infoBridge ? root.infoBridge.role : ""
        onRoleChanged: if (root.infoBridge) root.infoBridge.role = role
        Layout.columnSpan: 2
        Layout.fillWidth: true
    }

    SpecialAbilityField {
        text: root.infoBridge ? root.infoBridge.specialAbility : ""
        onTextChanged: if (root.infoBridge) root.infoBridge.specialAbility = text
        Layout.columnSpan: 2
        Layout.fillWidth: true
    }
}