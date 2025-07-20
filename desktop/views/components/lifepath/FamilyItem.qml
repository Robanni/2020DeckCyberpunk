import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../../shared"

Rectangle {
    id: root
    width: parent.width
    implicitHeight: contentLayout.implicitHeight + 2 * Theme.spacingMedium
    color: Theme.surface
    border.color: Theme.border
    radius: Theme.borderRadius
    border.width: 1

    required property int index
    required property string name
    required property string relationship
    required property string relationshipNotes
    required property int age

    signal removeRequested(int index)
    signal edited(int index, string name, string relationship, string notes, int age)

    // Локальные свойства для буферизации изменений
    property string editingName: name
    property string editingRelationship: relationship
    property string editingNotes: relationshipNotes
    property int editingAge: age

    // Обновляем буфер при изменении внешних свойств
    onNameChanged: editingName = name
    onRelationshipChanged: editingRelationship = relationship
    onRelationshipNotesChanged: editingNotes = relationshipNotes
    onAgeChanged: editingAge = age

    ColumnLayout {
        id: contentLayout
        anchors.fill: parent
        anchors.margins: Theme.spacingMedium
        spacing: Theme.spacingMedium

        // Первая строка - имя и кнопка удаления
        RowLayout {
            Layout.fillWidth: true
            spacing: Theme.spacingMedium

            // Поле ввода имени
            TextField {
                id: nameField
                text: root.editingName
                placeholderText: "Имя"
                font.pixelSize: Theme.fontSizeMedium
                Layout.fillWidth: true
                Layout.preferredHeight: 36

                background: Rectangle {
                    color: Theme.background
                    radius: 4
                    border.color: Theme.border
                }

                onEditingFinished: {
                    if (root.editingName !== text) {
                        root.editingName = text;
                        root.edited(root.index, text, root.editingRelationship, root.editingNotes, root.editingAge);
                    }
                }
            }

            // Кнопка удаления
            Button {
                id: deleteButton
                text: "✕"
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                font.pixelSize: Theme.fontSizeMedium

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

                onClicked: root.removeRequested(root.index)
            }
        }

        // Поле родства
        TextField {
            id: relationshipField
            text: root.editingRelationship
            placeholderText: "Родство (мать, отец и т.д.)"
            font.pixelSize: Theme.fontSizeNormal
            Layout.fillWidth: true
            Layout.preferredHeight: 36

            background: Rectangle {
                color: Theme.background
                radius: 4
                border.color: Theme.border
            }

            onEditingFinished: {
                if (root.editingRelationship !== text) {
                    root.editingRelationship = text;
                    root.edited(root.index, root.editingName, text, root.editingNotes, root.editingAge);
                }
            }
        }

        // Заметки о родстве
        TextArea {
            id: notesArea
            text: root.editingNotes
            placeholderText: "Заметки о родстве..."
            wrapMode: TextArea.Wrap
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            font.pixelSize: Theme.fontSizeNormal
            verticalAlignment: Text.AlignVCenter
            selectByMouse: true

            background: Rectangle {
                color: Theme.background
                border.color: Theme.border
                radius: 4
            }

            onEditingFinished: {
                if (root.editingNotes !== text) {
                    root.editingNotes = text;
                    root.edited(root.index, root.editingName, root.editingRelationship, text, root.editingAge);
                }
            }
        }

        // Строка с возрастом
        RowLayout {
            Layout.fillWidth: true
            spacing: Theme.spacingMedium

            Label {
                text: "Возраст:"
                color: Theme.textSecondary
                Layout.preferredWidth: 60
            }

            SpinBox {
                id: ageSpinBox
                value: root.editingAge
                from: 0
                to: 150
                stepSize: 1
                editable: true
                Layout.fillWidth: true

                onValueModified: {
                    if (root.editingAge !== value) {
                        root.editingAge = value;
                        root.edited(root.index, root.editingName, root.editingRelationship, root.editingNotes, value);
                    }
                }
            }

            Label {
                text: "лет"
                color: Theme.textSecondary
            }
        }
    }
}
