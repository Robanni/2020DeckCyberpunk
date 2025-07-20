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
    required property string relationshipNotes

    signal removeRequested(int index)
    signal edited(int index, string name, string info, string relationshipNotes)

    property string editingName: name
    property string editingInfo: info
    property string editingRelationshipNotes: relationshipNotes

    onNameChanged: editingName = name
    onInfoChanged: editingInfo = info
    onRelationshipNotesChanged: editingRelationshipNotes = relationshipNotes

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
                placeholderText: "Имя"
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
                        root.edited(root.index, text, root.editingInfo, root.editingRelationshipNotes)
                    }
                }
            }

            Button {
                text: "✕"
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                font.pixelSize: Theme.fontSizeMedium
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
                    root.edited(root.index, root.editingName, text, root.editingRelationshipNotes)
                }
            }
        }

        TextArea {
            text: root.editingRelationshipNotes
            placeholderText: "Заметки"
            wrapMode: TextArea.Wrap
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            font.pixelSize: Theme.fontSizeNormal
            verticalAlignment: Text.AlignVCenter
            selectByMouse: true
            background: Rectangle {
                color: Theme.background
                border.color: Theme.border
                radius: 4
            }
            onEditingFinished: {
                if (text !== root.relationshipNotes) {
                    root.editingRelationshipNotes = text
                    root.edited(root.index, root.editingName, root.editingInfo, text)
                }
            }
        }
    }
}

