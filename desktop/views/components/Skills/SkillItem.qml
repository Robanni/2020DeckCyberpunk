import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../../shared"

Rectangle {
    id: root

    width: parent.width
    implicitHeight: mainLayout.implicitHeight + 2 * Theme.spacingMedium
    color: Theme.surface
    border.color: Theme.border
    radius: Theme.borderRadius
    border.width: 1

    property int index
    property string name
    property string category
    property string description
    property int level

    signal removeRequested(int index)
    signal edited(int index, string name, string category, string description, int level)

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        anchors.margins: Theme.spacingMedium
        spacing: Theme.spacingSmall

        // Первая строка - основные поля
        RowLayout {
            spacing: Theme.spacingSmall
            Layout.fillWidth: true

            // Название (занимает оставшееся пространство)
            TextField {
                id: nameField
                text: root.name
                placeholderText: "Название"
                Layout.fillWidth: true
                Layout.preferredHeight: 32
                font.pixelSize: Theme.fontSizeNormal
                onEditingFinished: root.edited(root.index, text, root.category, root.description, root.level)
                background: Rectangle {
                    color: Theme.background
                    radius: 4
                    border.color: Theme.border
                }
            }

            // Категория (фиксированная ширина)
            TextField {
                id: categoryField
                text: root.category
                placeholderText: "Категория"
                Layout.preferredWidth: 120
                Layout.preferredHeight: 32
                font.pixelSize: Theme.fontSizeNormal
                onEditingFinished: root.edited(root.index, root.name, text, root.description, root.level)
                background: Rectangle {
                    color: Theme.background
                    radius: 4
                    border.color: Theme.border
                }
            }

            SpinBox {
                id: levelSpinBox
                Component.onCompleted: value = root.level
                from: 0
                to: 15
                Layout.preferredWidth: 80
                Layout.preferredHeight: 32
                onValueModified: {
                    root.edited(root.index, nameField.text, categoryField.text, descriptionArea.text, value);
                }

                contentItem: Text {
                    text: levelSpinBox.value
                    color: Theme.text
                    font: levelSpinBox.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    color: Theme.background
                    radius: 4
                    border.color: Theme.border
                }
            }

            // Кнопка удаления
            Button {
                id: deleteButton
                text: "✕"
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
                font.pixelSize: Theme.fontSizeNormal
                onClicked: root.removeRequested(root.index)

                background: Rectangle {
                    color: Theme.danger
                    radius: 4
                }

                contentItem: Text {
                    text: deleteButton.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font: deleteButton.font
                }
            }
        }

        TextArea {
            id: descriptionArea
            text: root.description
            placeholderText: "Описание навыка..."
            wrapMode: TextArea.Wrap
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            font.pixelSize: Theme.fontSizeNormal
            verticalAlignment: Text.AlignVCenter
            onTextChanged: {
                if (activeFocus) {
                    root.description = text;
                }
            }

            onEditingFinished: root.edited(root.index, root.name, root.category, text, root.level)

            background: Rectangle {
                color: Theme.background
                border.color: Theme.border
                radius: 4
            }
        }
    }
}
