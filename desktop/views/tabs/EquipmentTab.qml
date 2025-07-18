pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../shared"
import "../components/equipment"

Item {
    id: root
    Layout.fillWidth: true
    Layout.fillHeight: true

    property var equipmentModel: characterBridge.equipmentModel

    signal addEquipmentRequested
    signal removeRequested(int index)
    signal equipmentChanged(int index, string name, string description, double weight, double price, int amount)

    CyberGridBackground {
        gridSize: 20
        lineOpacity: 0.3
        lineWidth: 1
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Theme.spacingMedium
        spacing: Theme.spacingLarge

        // Панель информации о снаряжении
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
                    text: "📦 Общее снаряжение:"
                    font.pixelSize: Theme.fontSizeLarge
                    color: Theme.text
                }
                
                Label {
                    text: equipmentModel.rowCount()
                    font.pixelSize: Theme.fontSizeLarge
                    font.bold: true
                    color: Theme.accent
                }
                
                Item { Layout.fillWidth: true } // Spacer
            }
        }

        // Список снаряжения
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            
            ColumnLayout {
                width: parent.width
                spacing: Theme.spacingMedium
                
                Repeater {
                    model: equipmentModel
                    EquipmentItem {
                        onRemoveRequested: root.removeRequested(index)
                        onEdited: root.equipmentChanged(index, name, description, weight, price, amount)
                    }
                }
            }
        }

        // Кнопка добавления
        Button {
            text: "➕ Добавить снаряжение"
            Layout.alignment: Qt.AlignRight
            onClicked: addEquipmentDialog.open()
        }
    }

    // Диалог добавления
    Dialog {
        id: addEquipmentDialog
        title: "Добавить снаряжение"
        modal: true
        width: 400
        
        ColumnLayout {
            anchors.fill: parent
            spacing: Theme.spacingMedium
            
            TextField {
                id: nameField
                placeholderText: "Название снаряжения"
                Layout.fillWidth: true
            }
            
            TextArea {
                id: descriptionField
                placeholderText: "Описание снаряжения"
                Layout.fillWidth: true
                Layout.preferredHeight: 80
            }
            
            RowLayout {
                Layout.fillWidth: true
                spacing: Theme.spacingMedium
                
                Label { 
                    text: "Вес:" 
                    Layout.preferredWidth: 60
                }
                
                SpinBox {
                    id: weightField
                    from: 0
                    to: 1000
                    value: 0.0
                    stepSize: 1
                    editable: true
                    Layout.fillWidth: true
                    
                    property real realValue: value / 10.0
                    
                    validator: DoubleValidator {
                        bottom: weightField.from
                        top: weightField.to
                    }
                    
                    textFromValue: function(value, locale) {
                        return Number(value / 10.0).toLocaleString(locale, 'f', 1)
                    }
                    
                    valueFromText: function(text, locale) {
                        return Number.fromLocaleString(locale, text) * 10
                    }
                }
            }
            
            RowLayout {
                Layout.fillWidth: true
                spacing: Theme.spacingMedium
                
                Label { 
                    text: "Цена:" 
                    Layout.preferredWidth: 60
                }
                
                SpinBox {
                    id: priceField
                    from: 0
                    to: 1000000
                    value: 0.0
                    stepSize: 1
                    editable: true
                    Layout.fillWidth: true
                    
                    property real realValue: value
                    
                    validator: IntValidator {
                        bottom: priceField.from
                        top: priceField.to
                    }
                }
            }
            
            RowLayout {
                Layout.fillWidth: true
                spacing: Theme.spacingMedium
                
                Label { 
                    text: "Кол-во:" 
                    Layout.preferredWidth: 60
                }
                
                SpinBox {
                    id: amountField
                    from: 1
                    to: 100
                    value: 1
                    stepSize: 1
                    editable: true
                    Layout.fillWidth: true
                }
            }
            
            RowLayout {
                Layout.alignment: Qt.AlignRight
                
                Button {
                    text: "Отмена"
                    onClicked: addEquipmentDialog.close()
                }
                
                Button {
                    text: "Добавить"
                    onClicked: {
                        root.equipmentModel.addEquipment(
                            nameField.text,
                            descriptionField.text,
                            weightField.realValue,
                            priceField.realValue,
                            amountField.value
                        )
                        addEquipmentDialog.close()
                    }
                }
            }
        }
    }

    // Обработчики сигналов
    onRemoveRequested: function(index) {
        equipmentModel.removeEquipment(index)
    }
    
    onEquipmentChanged: function(index, name, description, weight, price, amount) {
        equipmentModel.updateEquipment(index, name, description, weight, price, amount);
    }
}