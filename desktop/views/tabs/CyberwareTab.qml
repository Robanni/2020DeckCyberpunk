pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../shared"
import "../components/cyberware"

Item {
    id: root
    Layout.fillWidth: true
    Layout.fillHeight: true

    property var cyberwareModel: characterBridge.cyberwareModel

    signal addCyberwareRequested
    signal removeRequested(int index)
    signal cyberwareChanged(int index, string name, string description, int humanityCost)

    CyberGridBackground {
        gridSize: 20
        lineOpacity: 0.3
        lineWidth: 1
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Theme.spacingMedium
        spacing: Theme.spacingLarge

        // Панель информации о человечности
        Rectangle {
            Layout.fillWidth: true
            height: 60
            color: Theme.surface
            border.color: Theme.border
            radius: Theme.borderRadius
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: Theme.spacingMedium
                
                Label {
                    text: "🧠 Текущая человечность:"
                    font.pixelSize: Theme.fontSizeLarge
                    color: Theme.text
                }
                
                Label {
                    text: cyberwareModel.currentHumanity
                    font.pixelSize: Theme.fontSizeLarge
                    font.bold: true
                    color: Theme.accent
                }
                
                Item { Layout.fillWidth: true } // Spacer
            }
        }

        // Список киберимплантов
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            
            ColumnLayout {
                width: parent.width
                spacing: Theme.spacingMedium
                
                Repeater {
                    model: cyberwareModel
                    CyberwareItem {
                        onRemoveRequested: root.removeRequested(index)
                        onEdited: root.cyberwareChanged(index, name, description, humanityCost)
                    }
                }
            }
        }

        // Кнопка добавления
        Button {
            text: "➕ Добавить киберимплант"
            Layout.alignment: Qt.AlignRight
            onClicked: addCyberwareDialog.open()
        }
    }

    // Диалог добавления
    Dialog {
        id: addCyberwareDialog
        title: "Добавить киберимплант"
        modal: true
        width: 400
        
        ColumnLayout {
            anchors.fill: parent
            spacing: Theme.spacingMedium
            
            TextField {
                id: nameField
                placeholderText: "Название импланта"
                Layout.fillWidth: true
            }
            
            TextArea {
                id: descriptionField
                placeholderText: "Описание импланта"
                Layout.fillWidth: true
                Layout.preferredHeight: 80
            }
            
            SpinBox {
                id: humanityCostField
                from: 0
                to: 100
                value: 0
                editable: true
                Layout.fillWidth: true
            }
            
            RowLayout {
                Layout.alignment: Qt.AlignRight
                
                Button {
                    text: "Отмена"
                    onClicked: addCyberwareDialog.close()
                }
                
                Button {
                    text: "Добавить"
                    onClicked: {
                        root.cyberwareModel.addCyberware(
                            nameField.text,
                            descriptionField.text,
                            humanityCostField.value
                        )
                        addCyberwareDialog.close()
                    }
                }
            }
        }
    }

    // Обработчики сигналов
    onRemoveRequested: function(index) {
        cyberwareModel.removeCyberware(index)
    }
    
    onCyberwareChanged: function(index, name, description, humanityCost) {
        console.log(`Update cyberware [${index}]:`, name, description, humanityCost)
        cyberwareModel.updateCyberware(index, name, description, humanityCost);
    }
}