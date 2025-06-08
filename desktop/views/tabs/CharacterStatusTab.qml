import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components/characterstatus_health"
import "../components/characterstatus_health/HealthLogic.js" as HealthLogic

Item {
    id: main
    Layout.fillWidth: true
    Layout.fillHeight: true

    property var statusBridge: characterBridge.status
    property int blockCount: 10
    property int boxesPerBlock: 4
    property var painStatus: [
        {
            first: "Легкое",
            second: "Stun=0"
        },
        {
            first: "Серьёзное",
            second: "Stun=1"
        },
        {
            first: "Критическое",
            second: "Stun=2"
        },
        {
            first: "Смертельное 0",
            second: "Stun=3"
        },
        {
            first: "Смертельное 1",
            second: "Stun=4"
        },
        {
            first: "Смертельное 2",
            second: "Stun=5"
        },
        {
            first: "Смертельное 3",
            second: "Stun=6"
        },
        {
            first: "Смертельное 4",
            second: "Stun=7"
        },
        {
            first: "Смертельное 5",
            second: "Stun=8"
        },
        {
            first: "Смертельное 6",
            second: "Stun=9"
        }
    ]

    property var blocksStatus: initStatus(blockCount, boxesPerBlock)

    function initStatus(blocks, boxes) {
        var result = [];
        var curDamage = statusBridge.current_damage;
        for (var i = 0; i < blocks; ++i) {
            var row = [];
            for (var j = 0; j < boxes; ++j) {
                if (curDamage > 0) {
                    row.push(true);
                    curDamage--;
                } else {
                    row.push(false);
                }
            }
            result.push(row);
        }
        return result;
    }

    function handleBoxClick(blockIndex, boxIndex) {
        blocksStatus = HealthLogic.updateStatus(blocksStatus, blockIndex, boxIndex);
    }

    ScrollView {
        anchors.fill: parent
        clip: true
        ScrollBar.vertical.policy: ScrollBar.AsNeeded

        ColumnLayout {
            anchors.fill: parent
            spacing: 2

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: Math.ceil(blockCount / 2) * 60
                color: "#1a1a2e"
                border.color: "#e94560"
                border.width: 1
                radius: 4

                GridLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    columns: 5
                    rowSpacing: 10
                    columnSpacing: 10

                    Repeater {
                        model: blockCount
                        delegate: Rectangle {
                            color: "transparent"
                            border.color: "yellow"
                            border.width: 1
                            radius: 4
                            Layout.alignment: Qt.AlignTop
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            HealthBlock {
                                anchors.fill: parent
                                blockId: index
                                labelStatus: painStatus[index].first
                                labelStun: painStatus[index].second
                                status: main.blocksStatus[index]
                                boxClicked: main.handleBoxClick
                            }
                        }
                    }
                }
            }
        }
    }
}
