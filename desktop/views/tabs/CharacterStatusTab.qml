import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components/characterstatus_health"
import "../components/characterstatus_health/HealthLogic.js" as HealthLogic

Item {
    id: main
    Layout.fillWidth: true
    Layout.fillHeight: true

    ScrollView {
        anchors.fill: parent
        clip: true
        ScrollBar.vertical.policy: ScrollBar.AsNeeded

        ColumnLayout {
            anchors.fill: parent
            spacing: 20

            HealthForm {
                id: healthForm
                Layout.fillWidth: true
                Layout.preferredHeight: healthForm.implicitHeight
            }
        }
    }
}
