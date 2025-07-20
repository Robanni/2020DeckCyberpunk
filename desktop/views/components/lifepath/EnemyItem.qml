import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../../shared"

Rectangle {
    id: root
    width: parent.width
    implicitHeight: contentLayout.implicitHeight + 2 * Theme.spacingMedium
    color: Theme.surface
    border.color: Theme.border
    radius: Theme.borderRadius
    border.width: 1

    required property int index
    required property string name
    required property string info

    signal removeRequested(int index)
    signal edited(int index, string name, string info)

    property string editingName: name
    property string editingInfo: info

    onNameChanged: editingName = name
    onInfoChanged: editingInfo = info

    ColumnLayout {
        id: contentLayout
        anchors.fill: parent
        anchors.margins: Theme.spacingMedium
        spacing: Theme.spacingMedium

        RowLayout {
            Layout.fillWidth: true
            spacing: Theme.spacingMedium

            TextField {
                text: root.editingName
                placeholderText: "Имя врага"
                font.pixelSize: Theme.fontSizeMedium
                Layout.fillWidth: true
                Layout.preferredHeight: 36
                background: Rectangle {
                    color: Theme.background
                    radius: 4
                    border.color: Theme.border
                }
                onEditingFinished: {
                    if (text !== root.name) {
                        root.editingName = text
                        root.edited(root.index, text, root.editingInfo)
                    }
                }
            }

            Button {
                text: "✕"
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                background: Rectangle {
                    color: Theme.danger
                    radius: 4
                }
                contentItem: Text {
                    text: "\u2715"
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: root.removeRequested(root.index)
            }
        }

        TextField {
            text: root.editingInfo
            placeholderText: "Информация"
            font.pixelSize: Theme.fontSizeNormal
            Layout.fillWidth: true
            Layout.preferredHeight: 36
            background: Rectangle {
                color: Theme.background
                radius: 4
                border.color: Theme.border
            }
            onEditingFinished: {
                if (text !== root.info) {
                    root.editingInfo = text
                    root.edited(root.index, root.editingName, text)
                }
            }
        }
    }
}
