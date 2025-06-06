import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "."


ColumnLayout {
    id:root
    spacing: 12
    anchors.centerIn: parent
    
    property var infoBridge
    
    NameField {
        text: root.infoBridge ? root.infoBridge.name : ""
        onTextChanged: if (root.infoBridge) root.infoBridge.name = text
        Layout.fillWidth: true  
        Layout.preferredHeight: implicitHeight  
    }

    HandleField {
        text: root.infoBridge ? root.infoBridge.handle : ""
        onTextChanged: if (root.infoBridge) root.infoBridge.handle = text
        Layout.fillWidth: true
        Layout.preferredHeight: implicitHeight
    }

    RoleSelector {
        role: root.infoBridge ? root.infoBridge.role : ""
        onRoleChanged: if (root.infoBridge) root.infoBridge.role = role
        Layout.fillWidth: true
        Layout.preferredHeight: implicitHeight
    }

    SpecialAbilityField {
        text: root.infoBridge ? root.infoBridge.specialAbility : ""
        onTextChanged: if (root.infoBridge) root.infoBridge.specialAbility = text
        Layout.fillWidth: true
        Layout.preferredHeight: implicitHeight
    }
}