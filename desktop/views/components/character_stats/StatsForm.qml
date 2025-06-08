import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "."

ColumnLayout {
    id: statsForm
    spacing: 12
    Layout.fillWidth: true
    property var statsBridge:characterBridge.stats

    StatField {
        label: "Телосложение"
        value: statsForm.statsBridge.BODY
        onValueChanged: statsForm.statsBridge.BODY = value
        Layout.fillWidth: true
    }

    StatField {
        label: "Рефлексы"
        value: statsForm.statsBridge.REF
        onValueChanged: statsForm.statsBridge.REF = value
        Layout.fillWidth: true
    }

    StatField {
        label: "Интеллект"
        value: statsForm.statsBridge.INT
        onValueChanged: statsForm.statsBridge.INT = value
        Layout.fillWidth: true
    }

    StatField {
        label: "Техника"
        value: statsForm.statsBridge.TECH
        onValueChanged: statsForm.statsBridge.TECH = value
        Layout.fillWidth: true
    }

    StatField {
        label: "Хладнокровие"
        value: statsForm.statsBridge.COOL
        onValueChanged: statsForm.statsBridge.COOL = value
        Layout.fillWidth: true
    }

    StatField {
        label: "Харизма"
        value: statsForm.statsBridge.cool
        onValueChanged: statsForm.statsBridge.cool = value
        Layout.fillWidth: true
    }

    StatField {
        label: "Привлекательность"
        value: statsForm.statsBridge.ATTR
        onValueChanged: statsForm.statsBridge.ATTR = value
        Layout.fillWidth: true
    }

    StatField {
        label: "Удача"
        value: statsForm.statsBridge.LUCK
        onValueChanged: statsForm.statsBridge.LUCK = value
        Layout.fillWidth: true
    }
    StatField {
        label: "Передвижение"
        value: statsForm.statsBridge.MA
        onValueChanged: statsForm.statsBridge.MA = value
        Layout.fillWidth: true
    }
    StatField {
        label: "Эмпатия"
        value: statsForm.statsBridge.EMP
        onValueChanged: statsForm.statsBridge.EMP = value
        Layout.fillWidth: true
    }
}
