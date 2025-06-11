import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components/characterstatus_health"
import "../components/characterstatus_armor"
import "../shared"
import "../components/characterstatus_health/HealthLogic.js" as HealthLogic

Item {
    id: main
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

            HealthForm {
                id: healthForm
                Layout.fillWidth: true
                Layout.preferredHeight: healthForm.implicitHeight
            }

            ArmorForm {
                id: armorForm
                Layout.fillWidth: true
                Layout.preferredHeight: armorForm.implicitHeight
            }
        }
    }
}
