import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "."
import "HealthLogic.js" as HealthLogic

Item {
    id: root
    property var statusBridge: characterBridge.status
    property var blocksStatus: []

    implicitHeight: grid.implicitHeight

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

    function initStatus() {
        let result = [];
        let curDamage = root.statusBridge ? (root.statusBridge.current_damage || 0) : 0;

        for (let i = 0; i < root.blockCount; ++i) {
            let row = [];
            for (let j = 0; j < root.boxesPerBlock; ++j) {
                row.push(curDamage-- > 0);
            }
            result.push(row);
        }
        root.blocksStatus = result;
        console.log("Initialized blocksStatus:", JSON.stringify(result)); // Для отладки
    }

    Component.onCompleted: initStatus()

    Rectangle {
        anchors.fill: parent
        color: "#1a1a2e"
        border {
            color: "#e94560"
            width: 1
        }
        radius: 4

        GridLayout {
            id: grid
            anchors.fill: parent
            anchors.margins: 10
            columns: 5
            rowSpacing: 10
            columnSpacing: 10

            Repeater {
                model: root.blockCount
                delegate: Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredHeight: healthBlock.implicitHeight + 25
                    color: "transparent"
                    border {
                        color: "yellow"
                        width: 1
                    }
                    radius: 4

                    HealthBlock {
                        id: healthBlock
                        anchors.fill: parent
                        anchors.margins: 2
                        blockId: index
                        labelStatus: root.painStatus[index].first
                        labelStun: root.painStatus[index].second
                        status: root.blocksStatus[index]
                        boxClicked: function (blockId, boxIndex) {
                            root.blocksStatus = HealthLogic.updateStatus(root.blocksStatus, blockId, boxIndex);
                        }
                    }
                }
            }
        }
    }
}
