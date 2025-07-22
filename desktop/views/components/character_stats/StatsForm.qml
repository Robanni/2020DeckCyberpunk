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

        Layout.fillWidth: true
    }

    StatField {
        label: "Рефлексы"
        value: statsForm.statsBridge.REF

        Layout.fillWidth: true
    }

    StatField {
        label: "Интеллект"
        value: statsForm.statsBridge.INT

        Layout.fillWidth: true
    }

    StatField {
        label: "Техника"
        value: statsForm.statsBridge.TECH

        Layout.fillWidth: true
    }

    StatField {
        label: "Хладнокровие"
        value: statsForm.statsBridge.COOL

        Layout.fillWidth: true
    }

    StatField {
        label: "Привлекательность"
        value: statsForm.statsBridge.ATTR

        Layout.fillWidth: true
    }

    StatField {
        label: "Удача"
        value: statsForm.statsBridge.LUCK

        Layout.fillWidth: true
    }
    StatField {
        label: "Передвижение"
        value: statsForm.statsBridge.MA

        Layout.fillWidth: true
    }
    StatField {
        label: "Эмпатия"
        value: statsForm.statsBridge.EMP

        Layout.fillWidth: true
    }
}
