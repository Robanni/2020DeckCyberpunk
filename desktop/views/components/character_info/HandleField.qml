import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../shared"

RowLayout {
    spacing: 10
    property alias text: handleField.text
    
    CyberLabel {
        text: "Кличка:"
        Layout.preferredWidth: 120
    }
    
    CyberTextField {
        id: handleField
        Layout.fillWidth: true
    }
}