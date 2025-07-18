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
    required property string description
    required property int humanityCost
    
    signal removeRequested(int index)
    signal edited(int index, string name, string description, int humanityCost)
    
    // Локальные свойства для буферизации изменений
    property string editingName: name
    property string editingDescription: description
    property int editingHumanityCost: humanityCost
    
    // Обновляем буфер при изменении внешних свойств
    onNameChanged: editingName = name
    onDescriptionChanged: editingDescription = description
    onHumanityCostChanged: editingHumanityCost = humanityCost

    ColumnLayout {
        id: contentLayout
        anchors.fill: parent
        anchors.margins: Theme.spacingMedium
        spacing: Theme.spacingMedium

        // Первая строка - название и кнопки
        RowLayout {
            Layout.fillWidth: true
            spacing: Theme.spacingMedium

            // Название киберимпланта
            TextField {
                id: nameField
                text: root.editingName
                placeholderText: "Название киберимпланта"
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
                        root.editingName = text
                        root.edited(index, text, root.editingDescription, root.editingHumanityCost)
                    }
                }
            }

            // Стоимость человечности
            RowLayout {
                spacing: Theme.spacingSmall
                Layout.alignment: Qt.AlignRight
                
                Label {
                    text: "💀 Стоимость:"
                    color: Theme.textSecondary
                    font.pixelSize: Theme.fontSizeSmall
                }
                
                SpinBox {
                    id: costSpinBox
                    value: root.editingHumanityCost
                    from: 0
                    to: 100
                    stepSize: 1
                    editable: true
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 36
                    
                    contentItem: Text {
                        text: costSpinBox.value
                        color: Theme.text
                        font: costSpinBox.font
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    background: Rectangle {
                        color: Theme.background
                        radius: 4
                        border.color: Theme.border
                    }
                    
                    onValueModified: {
                        if (root.editingHumanityCost !== value) {
                            root.editingHumanityCost = value
                            root.edited(index, root.editingName, root.editingDescription, value)
                        }
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
                
                onClicked: root.removeRequested(index)
            }
        }

        // Описание
        TextArea {
            id: descriptionArea
            text: root.editingDescription
            placeholderText: "Описание киберимпланта..."
            wrapMode: TextArea.Wrap
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            font.pixelSize: Theme.fontSizeNormal
            verticalAlignment: Text.AlignVCenter
            selectByMouse: true
            
            background: Rectangle {
                color: Theme.background
                border.color: Theme.border
                radius: 4
            }
            
            onEditingFinished: {
                if (root.editingDescription !== text) {
                    root.editingDescription = text
                    root.edited(index, root.editingName, text, root.editingHumanityCost)
                }
            }
        }
    }
    
}