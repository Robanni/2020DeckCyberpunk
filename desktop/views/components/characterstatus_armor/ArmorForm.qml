import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "."

Item {
    id: root
    property var armorBridge: characterBridge.armor

    GridLayout {
        id: grid
        columns: 3
        rowSpacing: 10
        columnSpacing: 10

        anchors.centerIn: parent

        ArmorBlock {
            label: "Голова"
            value: root.armorBridge ? root.armorBridge.head : 0
        }

        ArmorBlock {
            label: "Торс"
            value: root.armorBridge ? root.armorBridge.body : 0
        }

        ArmorBlock {
            label: "Левая рука"
            value: root.armorBridge ? root.armorBridge.leftArm : 0
        }

        ArmorBlock {
            label: "Правая рука"
            value: root.armorBridge ? root.armorBridge.rightArm: 0
        }

        ArmorBlock {
            label: "Левая нога"
            value: root.armorBridge ? root.armorBridge.leftLeg : 0
        }

        ArmorBlock {
            label: "Правая нога"
            value: root.armorBridge ? root.armorBridge.rightLeg : 0
        }
    }
}
