import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../shared"


Item {
    id: root
    property int blockId: -1
    property string labelStatus: "Уровень"
    property string labelStun: "Уровень"
    property var status: []
    property var boxClicked: function(blockId, boxIndex) {}
    
    implicitWidth: Math.max(statusLabel.implicitWidth, stunLabel.implicitWidth, boxesGrid.implicitWidth) + 20
    implicitHeight: statusLabel.implicitHeight + boxesGrid.implicitHeight + stunLabel.implicitHeight + 20
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 5
        
        CyberLabel {
            id: statusLabel
            text: root.labelStatus
            font.bold: true
            font.pointSize: 14
            Layout.alignment: Qt.AlignHCenter
        }

        GridLayout {
            id: boxesGrid
            Layout.alignment: Qt.AlignHCenter
            columns: status.length
            rowSpacing: 5
            columnSpacing: 5
            
            Repeater {
                model: status.length
                delegate: Rectangle {
                    id: box
                    property bool active: status[index]
                    Layout.preferredWidth: 30
                    Layout.preferredHeight: 30
                    color: active ? "red" : "white"
                    border { color: "black"; width: 1 }
                    
                    Behavior on color { ColorAnimation { duration: 150 } }
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.boxClicked(root.blockId, index)
                    }
                }
            }
        }
        
        CyberLabel {
            id: stunLabel
            text: root.labelStun
            font.bold: true
            font.pointSize: 8
            Layout.alignment: Qt.AlignHCenter
        }
    }
}