import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: root
    
    color: "white"
    font.pixelSize: 14
    padding: 10
    selectByMouse: true
    selectedTextColor: "black"
    selectionColor: "#e94560"
    
    background: Rectangle {
        color: "#0f3460"
        border.color: root.activeFocus ? "#e94560" : "#4a4a6e"
        border.width: 2
        radius: 4
        
        Behavior on border.color {
            ColorAnimation { duration: 200 }
        }
    }
    
    Behavior on opacity {
        NumberAnimation { duration: 300 }
    }
}