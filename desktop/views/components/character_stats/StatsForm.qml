import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "."

ColumnLayout {
    id: statsForm
    spacing: 12
    Layout.fillWidth: true
    property var statsBridge: characterBridge.stats

    function updateFieldsFromBridge() {
        bodyField.value = statsBridge.BODY
        refField.value = statsBridge.REF
        intField.value = statsBridge.INT
        techField.value = statsBridge.TECH
        coolField.value = statsBridge.COOL
        attrField.value = statsBridge.ATTR
        luckField.value = statsBridge.LUCK
        maField.value = statsBridge.MA
        empField.value = statsBridge.EMP
    }

Connections {
    target: statsBridge

    function onIntChanged() { statsForm.updateFieldsFromBridge() }
    function onRefChanged() { statsForm.updateFieldsFromBridge() }
    function onTechChanged() { statsForm.updateFieldsFromBridge() }
    function onCoolChanged() { statsForm.updateFieldsFromBridge() }
    function onAttrChanged() { statsForm.updateFieldsFromBridge() }
    function onLuckChanged() { statsForm.updateFieldsFromBridge() }
    function onMaChanged() { statsForm.updateFieldsFromBridge() }
    function onBodyChanged() { statsForm.updateFieldsFromBridge() }
    function onEmpChanged() { statsForm.updateFieldsFromBridge() }
}


    Component.onCompleted: statsForm.updateFieldsFromBridge()

    StatField {
        id: bodyField
        label: "Телосложение"
        value: statsBridge.BODY
        onSpinValueChanged: statsBridge.BODY = value
        Layout.fillWidth: true
    }

    StatField {
        id: refField
        label: "Рефлексы"
        value: statsBridge.REF
        onSpinValueChanged: statsBridge.REF = value
        Layout.fillWidth: true
    }

    StatField {
        id: intField
        label: "Интеллект"
        value: statsBridge.INT
        onSpinValueChanged: statsBridge.INT = value
        Layout.fillWidth: true
    }

    StatField {
        id: techField
        label: "Техника"
        value: statsBridge.TECH
        onSpinValueChanged: statsBridge.TECH = value
        Layout.fillWidth: true
    }

    StatField {
        id: coolField
        label: "Хладнокровие"
        value: statsBridge.COOL
        onSpinValueChanged: statsBridge.COOL = value
        Layout.fillWidth: true
    }

    StatField {
        id: attrField
        label: "Привлекательность"
        value: statsBridge.ATTR
        onSpinValueChanged: statsBridge.ATTR = value
        Layout.fillWidth: true
    }

    StatField {
        id: luckField
        label: "Удача"
        value: statsBridge.LUCK
        onSpinValueChanged: statsBridge.LUCK = value
        Layout.fillWidth: true
    }

    StatField {
        id: maField
        label: "Передвижение"
        value: statsBridge.MA
        onSpinValueChanged: statsBridge.MA = value
        Layout.fillWidth: true
    }

    StatField {
        id: empField
        label: "Эмпатия"
        value: statsBridge.EMP
        onSpinValueChanged: statsBridge.EMP = value
        Layout.fillWidth: true
    }
}
