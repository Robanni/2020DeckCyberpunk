import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../../shared"

RowLayout {
    property alias text: abilityField.text

    CyberLabel {
        text: "Классовый навык:"
    }

    CyberTextField {
        id: abilityField
        Layout.fillWidth: true
    }
}
