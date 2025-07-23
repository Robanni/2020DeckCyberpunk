import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import "../shared"

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true

    // 🌌 Cyberpunk сетка
    CyberGridBackground {
        gridSize: 30
        lineOpacity: 0.15
        lineWidth: 1
    }

    // 💠 Контейнер с прозрачным фоном и свечением
    Rectangle {
        anchors.centerIn: parent
        width: 400
        height: 250
        radius: 12
        color: "#1a1a2ecc" // Полупрозрачный фон
        border.color: Theme.accent
        border.width: 2

        layer.enabled: true
        layer.effect: DropShadow {
            color: "#e94560"
            radius: 16
            samples: 32
            spread: 0.1
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 0
        }

        ColumnLayout {
            anchors.centerIn: parent
            spacing: Theme.spacingLarge

            Label {
                text: "👨‍💻 Разработчик: Robanni"
                font.pixelSize: 20
                color: Theme.accent
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }

            Button {
                text: "📺 YouTube: @ResurrectedRobanni"
                Layout.preferredWidth: 300
                Layout.alignment: Qt.AlignHCenter
                onClicked: Qt.openUrlExternally("https://www.youtube.com/@ResurrectedRobanni")
            }

            Button {
                text: "💬 Telegram: @RobanniDev"
                Layout.preferredWidth: 300
                Layout.alignment: Qt.AlignHCenter
                onClicked: Qt.openUrlExternally("https://t.me/RobanniDev")
            }
            Button {
                text: "⚙️ GitHub проекта"
                Layout.preferredWidth: 300
                Layout.alignment: Qt.AlignHCenter
                onClicked: Qt.openUrlExternally("https://github.com/Robanni/2020DeckCyberpunk")
            }
        }
    }
}
