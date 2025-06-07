import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components/character_info"
import "../components/character_stats"
import "../components/shared"


Item {
    Layout.fillWidth: true
    Layout.fillHeight: true

    CyberGridBackground {
        gridSize: 20
        lineOpacity: 0.3
        lineWidth: 1
    }

    ScrollView {
        anchors.fill: parent
        clip: true
        ScrollBar.vertical.policy: ScrollBar.AsNeeded 

        ColumnLayout {
            width: parent.width - 20
            spacing: 20
            anchors.centerIn: parent

            // Карточка с основной информацией
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                color: "#1a1a2e"
                border.color: "#e94560"
                border.width: 1
                radius: 4

                InfoForm {
                    anchors.fill: parent
                    anchors.margins: 15
                    infoBridge: characterBridge.info
                }
            }

            // Карточка с характеристиками
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: statsContent.implicitHeight + 50
                color: "#1a1a2e"
                border.color: "#0f3460"
                border.width: 1
                radius: 4

                StatsForm {
                    id: statsContent
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                        margins: 15
                    }
                    statsBridge: characterBridge.stats
                }
            }
        }
    }
}
