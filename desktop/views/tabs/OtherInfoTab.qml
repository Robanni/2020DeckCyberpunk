import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../shared"

Item {
    id: root
    property var otherBridge: characterBridge.other

    ScrollView {
        anchors.fill: parent
        contentWidth: parent.width - 2 * Theme.spacingMedium
        clip: true

        ColumnLayout {
            width: parent.width - 2 * Theme.spacingMedium
            spacing: Theme.spacingMedium
            anchors.margins: Theme.spacingMedium

            Label {
                text: "СТИЛЬ"
                font.bold: true
                font.pixelSize: 16
                color: Theme.accent
            }

            TextArea {
                id: styleTextArea
                onEditingFinished: otherBridge.style = text
                wrapMode: TextArea.Wrap
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                font.pixelSize: Theme.fontSizeNormal
                background: Rectangle {
                    color: Theme.background
                    border.color: Theme.border
                    radius: 4
                }
                leftPadding: 8
                rightPadding: 8
                topPadding: 8
                bottomPadding: 8
            }

            Label {
                text: "ЗАМЕТКИ"
                font.bold: true
                font.pixelSize: 16
                color: Theme.accent
            }

            TextArea {
                id: notesTextArea
                onTextChanged: otherBridge.notes = text
                wrapMode: TextArea.Wrap
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                font.pixelSize: Theme.fontSizeNormal
                background: Rectangle {
                    color: Theme.background
                    border.color: Theme.border
                    radius: 4
                }

                leftPadding: 8
                rightPadding: 8
                topPadding: 8
                bottomPadding: 8
            }
        }
    }

    function updateFieldsFromBridge() {
        styleTextArea.text = otherBridge.style;
        notesTextArea.text = otherBridge.notes;
    }

    Connections {
        target: otherBridge
        function onStyleChanged() {
            root.updateFieldsFromBridge();
        }
        function onNotesChanged() {
            root.updateFieldsFromBridge();
        }
    }

    Component.onCompleted: updateFieldsFromBridge()
}
