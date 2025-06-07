import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components/characterstatus_health"
import "../components/characterstatus_health/HealthLogic.js" as HealthLogic

Item {
    id: main
    Layout.fillWidth: true
    Layout.fillHeight: true

    property int blockCount: 10
    property int boxesPerBlock: 4

    property var blocksStatus: initStatus(blockCount, boxesPerBlock)

    function initStatus(blocks, boxes) {
        var result = []
        for (var i = 0; i < blocks; ++i) {
            var row = []
            for (var j = 0; j < boxes; ++j) {
                row.push(false)
            }
            result.push(row)
        }
        return result
    }

    function handleBoxClick(blockIndex, boxIndex) {
        blocksStatus = HealthLogic.updateStatus(blocksStatus, blockIndex, boxIndex)
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
                    delegate: HealthBlock {
                        scale:1.5
                        blockId: index
                        label: "Блок " + (index + 1)
                        status: main.blocksStatus[index]
                        boxClicked: main.handleBoxClick
                    }
                }
            }
        }
    }
}
}