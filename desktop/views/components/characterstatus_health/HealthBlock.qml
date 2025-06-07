import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../shared"

Item {
    id: root
    property int blockId: -1
    property string label: "Уровень"
    property var status: []
    property var boxClicked: function(blockId, boxIndex) {} 
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 15
        
        CyberLabel{
            text: root.label
            font.bold: true
            font.pointSize: 14
            Layout.alignment: Qt.AlignHCenter
        }

        GridLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: implicitHeight
            columns: status.length
            rowSpacing: 5
            columnSpacing: 5
            
            Repeater {
                model: status.length
                delegate: Rectangle {
                    id: box
                    property bool active: status[index]
                    
                    Layout.fillWidth: true
                    Layout.preferredHeight: width
                    color: active ? "red" : "white"
                    border { color: "black"; width: 1 }
                    
                    Behavior on color { ColorAnimation { duration: 150 } }
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            root.boxClicked(root.blockId, index)
                        }
                    }
                }
            }
        }
    }
}