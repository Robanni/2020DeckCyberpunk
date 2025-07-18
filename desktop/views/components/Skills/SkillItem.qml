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


    required property int index     
    required property int skillId   
    required property string name
    required property string category
    required property string description
    required property int level

    signal removeRequested(int skillId)
    signal edited(int skillId, string name, string category, string description, int level)

    // Локальные свойства для редактирования
    property string editedName: name
    property string editedCategory: category
    property string editedDescription: description
    property int editedLevel: level

    // Синхронизация при изменении внешних свойств
    onNameChanged: editedName = name
    onCategoryChanged: editedCategory = category
    onDescriptionChanged: editedDescription = description
    onLevelChanged: editedLevel = level

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        anchors.margins: Theme.spacingMedium
        spacing: Theme.spacingSmall

        RowLayout {
            spacing: Theme.spacingSmall
            Layout.fillWidth: true

            TextField {
                id: nameField
                text: root.editedName
                placeholderText: "Название"
                Layout.fillWidth: true
                Layout.preferredHeight: 32
                font.pixelSize: Theme.fontSizeNormal
                
                background: Rectangle {
                    color: Theme.background
                    radius: 4
                    border.color: Theme.border
                }
                
                onEditingFinished: {
                    if (root.editedName !== text) {
                        root.editedName = text
                        root.edited(root.skillId, root.editedName, root.editedCategory, 
                                   root.editedDescription, root.editedLevel)
                    }
                }
            }

            TextField {
                id: categoryField
                text: root.editedCategory
                placeholderText: "Категория"
                Layout.preferredWidth: 120
                Layout.preferredHeight: 32
                font.pixelSize: Theme.fontSizeNormal
                
                background: Rectangle {
                    color: Theme.background
                    radius: 4
                    border.color: Theme.border
                }
                
                onEditingFinished: {
                    if (root.editedCategory !== text) {
                        root.editedCategory = text
                        root.edited(root.skillId, root.editedName, root.editedCategory, 
                                   root.editedDescription, root.editedLevel)
                    }
                }
            }

            SpinBox {
                id: levelSpinBox
                from: 0
                to: 15
                value: root.editedLevel
                Layout.preferredWidth: 80
                Layout.preferredHeight: 32
                
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
                
                onValueModified: {
                    if (root.editedLevel !== value) {
                        root.editedLevel = value
                        root.edited(root.skillId, root.editedName, root.editedCategory, 
                                  root.editedDescription, root.editedLevel)
                    }
                }
            }

            Button {
                id: deleteButton
                text: "✕"
                Layout.preferredWidth: 32
                Layout.preferredHeight: 32
                font.pixelSize: Theme.fontSizeNormal
                
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
                
                onClicked: root.removeRequested(root.skillId)
            }
        }

        TextArea {
            id: descriptionArea
            text: root.editedDescription
            placeholderText: "Описание навыка..."
            wrapMode: TextArea.Wrap
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            font.pixelSize: Theme.fontSizeNormal
            verticalAlignment: Text.AlignVCenter
            
            background: Rectangle {
                color: Theme.background
                border.color: Theme.border
                radius: 4
            }
            
            onEditingFinished: {
                if (root.editedDescription !== text) {
                    root.editedDescription = text
                    root.edited(root.skillId, root.editedName, root.editedCategory, 
                               root.editedDescription, root.editedLevel)
                }
            }
        }
    }
}