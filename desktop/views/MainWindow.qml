import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import "tabs"

ApplicationWindow {
    visible: true
    width: 1024
    height: 768
    title: "2020DECK — Панель игрока"
    Material.theme: Material.Dark
    Material.accent: Material.Purple

    // Image {
    //     source: "qrc:/images/cyberpunk_bg.jpg"
    //     anchors.fill: parent
    //     opacity: 0.15
    //     fillMode: Image.PreserveAspectCrop
    // }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Стилизованная панель вкладок
        TabBar {
            id: tabBar
            Layout.fillWidth: true
            currentIndex: 0
            Material.background: "#1a1a2e"
            Material.foreground: "#e94560"

            Repeater {
                model: ["🎭 Персонаж", "🛡️ Броня", "🔧 Навыки", "⚙️ Кибернетика", "🔫 Оборудование", "📝 Жизненный Путь", "📋 Прочее"]
                
                TabButton {
                    text: modelData
                    padding: 12
                    font.bold: true
                    font.pixelSize: 14
                }
            }
        }


        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#16213e"
            border.color: "#e94560"
            border.width: 1
            radius: 4

            StackLayout {
                id: stackLayout
                anchors.fill: parent
                anchors.margins: 10
                currentIndex: tabBar.currentIndex

                CharacterTab {}
                ArmorTab {}
                SkillsTab {}
                CyberwareTab {}
                EquipmentTab {}
                LifepathTab {}
                OtherInfoTab {}
            }
        }
    }
}