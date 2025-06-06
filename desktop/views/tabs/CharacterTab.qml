import QtQuick 2.15
import QtQuick.Controls 2.15

import "../components/character_info"

Item {
    width: 400
    height: 400


    InfoForm {
        anchors.fill: parent
        infoBridge: characterBridge.info

    }
}
