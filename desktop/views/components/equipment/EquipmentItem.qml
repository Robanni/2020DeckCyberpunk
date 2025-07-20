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
    required property double weight
    required property double price
    required property int amount
    
    signal removeRequested(int index)
    signal edited(int index, string name, string description, double weight, double price, int amount)
    
    // Локальные свойства для буферизации изменений
    property string editingName: name
    property string editingDescription: description
    property double editingWeight: weight
    property double editingPrice: price
    property int editingAmount: amount
    
    // Обновляем буфер при изменении внешних свойств
    onNameChanged: editingName = name
    onDescriptionChanged: editingDescription = description
    onWeightChanged: editingWeight = weight
    onPriceChanged: editingPrice = price
    onAmountChanged: editingAmount = amount

    ColumnLayout {
        id: contentLayout
        anchors.fill: parent
        anchors.margins: Theme.spacingMedium
        spacing: Theme.spacingMedium

        // Первая строка - название и кнопки
        RowLayout {
            Layout.fillWidth: true
            spacing: Theme.spacingMedium

            // Название снаряжения
            TextField {
                id: nameField
                text: root.editingName
                placeholderText: "Название снаряжения"
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
                        root.edited(root.index, text, root.editingDescription, 
                                    root.editingWeight, root.editingPrice, root.editingAmount)
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

        // Описание
        TextArea {
            id: descriptionArea
            text: root.editingDescription
            placeholderText: "Описание снаряжения..."
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
                if (root.editingDescription !== text) {
                    root.editingDescription = text
                    root.edited(root.index, root.editingName, text, 
                                root.editingWeight, root.editingPrice, root.editingAmount)
                }
            }
        }
        
        // Характеристики
        GridLayout {
            Layout.fillWidth: true
            columns: 3
            columnSpacing: Theme.spacingMedium
            rowSpacing: Theme.spacingSmall
            
            Label { 
                text: "Вес:" 
                color: Theme.textSecondary
                Layout.preferredWidth: 60
            }
            
            SpinBox {
                id: weightSpinBox
                value: root.editingWeight * 10
                from: 0
                to: 10000
                stepSize: 1
                editable: true
                Layout.fillWidth: true
                
                property real realValue: value / 10.0
                
                validator: DoubleValidator {
                    bottom: weightSpinBox.from
                    top: weightSpinBox.to
                }
                
                textFromValue: function(value, locale) {
                    return Number(value / 10.0).toLocaleString(locale, 'f', 1)
                }
                
                valueFromText: function(text, locale) {
                    return Number.fromLocaleString(locale, text) * 10
                }
                
                onValueModified: {
                    if (root.editingWeight !== realValue) {
                        root.editingWeight = realValue
                        root.edited(root.index, root.editingName, root.editingDescription, 
                                    realValue, root.editingPrice, root.editingAmount)
                    }
                }
            }
            
            Label { 
                text: "кг" 
                color: Theme.textSecondary
            }
            
            Label { 
                text: "Цена:" 
                color: Theme.textSecondary
                Layout.preferredWidth: 60
            }
            
            SpinBox {
                id: priceSpinBox
                value: root.editingPrice
                from: 0
                to: 1000000
                stepSize: 1
                editable: true
                Layout.fillWidth: true
                
                onValueModified: {
                    if (root.editingPrice !== value) {
                        root.editingPrice = value
                        root.edited(root.index, root.editingName, root.editingDescription, 
                                    root.editingWeight, value, root.editingAmount)
                    }
                }
            }
            
            Label { 
                text: "ед." 
                color: Theme.textSecondary
            }
            
            Label { 
                text: "Кол-во:" 
                color: Theme.textSecondary
                Layout.preferredWidth: 60
            }
            
            SpinBox {
                id: amountSpinBox
                value: root.editingAmount
                from: 1
                to: 100
                stepSize: 1
                editable: true
                Layout.fillWidth: true
                
                onValueModified: {
                    if (root.editingAmount !== value) {
                        root.editingAmount = value
                        root.edited(root.index, root.editingName, root.editingDescription, 
                                    root.editingWeight, root.editingPrice, value)
                    }
                }
            }
            
            Item { } 
        }
    }
}