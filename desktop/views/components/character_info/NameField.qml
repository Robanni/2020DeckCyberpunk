import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../../shared"

RowLayout {
    spacing: 10
    property alias text: nameField.text

    CyberLabel {
        text: "Имя:"
        Layout.preferredWidth: 100
    }

    CyberTextField {
        id: nameField
        Layout.fillWidth: true
    }
}
