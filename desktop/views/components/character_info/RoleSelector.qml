import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../shared"

RowLayout {
    property string role: ""
    readonly property var roles: ["Solo", "Netrunner", "Fixer", "Techie", "Rockerboy", "Medtech"]
    spacing: 15

    CyberLabel {
        text: "Роль:"
        Layout.preferredWidth: 120
    }

    ComboBox {
        id: combo
        Layout.fillWidth: true
        model: parent.roles
        currentIndex: parent.roles.indexOf(parent.role)
        
        // Стиль основного элемента
        contentItem: Text {
            text: combo.displayText
            color: "white"
            font.pixelSize: 14
            verticalAlignment: Text.AlignVCenter
            leftPadding: 10
        }

        // Фон и граница
        background: Rectangle {
            color: "#0f3460"
            border.color: combo.down ? "#ffffff" : "#e94560"
            border.width: 2
            radius: 4
            
            // Анимация изменения цвета границы
            Behavior on border.color {
                ColorAnimation { duration: 200 }
            }
        }

        // Стрелочка выпадающего списка
        indicator: Canvas {
            x: combo.width - width - 10
            y: combo.topPadding + (combo.availableHeight - height) / 2
            width: 12
            height: 8
            
            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();
                ctx.moveTo(0, 0);
                ctx.lineTo(width, 0);
                ctx.lineTo(width / 2, height);
                ctx.closePath();
                ctx.fillStyle = combo.down ? "#ffffff" : "#e94560";
                ctx.fill();
            }
            
            // Анимация стрелочки
            rotation: combo.popup.visible ? 180 : 0
            Behavior on rotation {
                NumberAnimation { duration: 200 }
            }
        }

        // Стиль выпадающего списка
        popup: Popup {
            y: combo.height + 5
            width: combo.width
            implicitHeight: Math.min(contentItem.implicitHeight, 400)
            padding: 2
            
            background: Rectangle {
                color: "#1a1a2e"
                border.color: "#e94560"
                border.width: 2
                radius: 4
            }

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: combo.popup.visible ? combo.delegateModel : null
                currentIndex: combo.highlightedIndex
                
                // Скроллбар
                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AsNeeded
                    background: Rectangle {
                        color: "#0f3460"
                        radius: 2
                    }
                    contentItem: Rectangle {
                        color: "#e94560"
                        radius: 2
                    }
                }

                // Анимация появления
                opacity: combo.popup.visible ? 1 : 0
                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }
            }
        }

        // Стиль элементов списка
        delegate: ItemDelegate {
            width: combo.width
            height: 36
            
            contentItem: Text {
                text: modelData
                color: highlighted ? "#ffffff" : "#e94560"
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10
            }
            
            background: Rectangle {
                color: highlighted ? "#e94560" : "transparent"
                radius: 2
                
                // Эффект при наведении
                Rectangle {
                    anchors.fill: parent
                    color: parent.parent.highlighted ? "transparent" : "#20e94560"
                    visible: parent.parent.hovered
                }
            }
        }

        onCurrentIndexChanged: {
            if (currentIndex >= 0) {
                parent.role = parent.roles[currentIndex];
            }
        }
    }

    // Анимация при изменении выбранной роли
    Behavior on role {
        PropertyAnimation {
            duration: 300
            easing.type: Easing.OutBack
        }
    }
}