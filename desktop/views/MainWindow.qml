import QtQuick 2.15
import QtQuick.Controls 2.15
import "tabs"

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "2020DECK — Панель игрока"

    Column {
        TabBar {
            id: tabBar
            currentIndex: 0

            TabButton {
                text: "🎭 Персонаж"
            }

            TabButton {
                text: "🛡️ Броня"
            }

            TabButton {
                text: "🔧 Навыки"
            }

            TabButton {
                text: "⚙️ Кибернетика"
            }

            TabButton {
                text: "🔫 Оборудование"
            }

            TabButton {
                text: "📝 Жизненный Путь"
            }

            TabButton {
                text: "📋 Прочее"
            }
        }

        StackView {
            id: stackView
            anchors.top: tabBar.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            

            initialItem: null
        }

        Connections {
            target: tabBar

            function onCurrentIndexChanged() {
                stackView.clear();
                switch (tabBar.currentIndex) {
                case 0:
                    stackView.push("tabs/CharacterTab.qml");
                    break;
                case 1:
                    stackView.push("tabs/ArmorTab.qml");
                    break;
                case 2:
                    stackView.push("tabs/SkillsTab.qml");
                    break;
                case 3:
                    stackView.push("tabs/CyberwareTab.qml");
                    break;
                case 4:
                    stackView.push("tabs/EquipmentTab.qml");
                    break;
                case 5:
                    stackView.push("tabs/LifepathTab.qml");
                    break;
                case 6:
                    stackView.push("tabs/OtherInfoTab.qml");
                    break;
                }
            }
        }
    }
    Component.onCompleted: {
        stackView.push(Qt.resolvedUrl("tabs/CharacterTab.qml"));
    }
}
