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
    required property string age
    required property string event

    signal removeRequested(int index)
    signal edited(int index, string age, string event)

    property string editingAge: age
    property string editingEvent: event

    onAgeChanged: editingAge = age
    onEventChanged: editingEvent = event

    ColumnLayout {
        id: contentLayout
        anchors.fill: parent
        anchors.margins: Theme.spacingMedium
        spacing: Theme.spacingMedium

        RowLayout {
            Layout.fillWidth: true
            spacing: Theme.spacingMedium

            TextField {
                text: root.editingAge
                placeholderText: "Возраст"
                font.pixelSize: Theme.fontSizeNormal
                Layout.preferredWidth: 100
                Layout.preferredHeight: 36
                background: Rectangle {
                    color: Theme.background
                    radius: 4
                    border.color: Theme.border
                }
                onEditingFinished: {
                    if (root.editingAge !== text) {
                        root.editingAge = text
                        root.edited(index, text, root.editingEvent)
                    }
                }
            }

            TextField {
                text: root.editingEvent
                placeholderText: "Событие"
                font.pixelSize: Theme.fontSizeNormal
                Layout.fillWidth: true
                Layout.preferredHeight: 36
                background: Rectangle {
                    color: Theme.background
                    radius: 4
                    border.color: Theme.border
                }
                onEditingFinished: {
                    if (root.editingEvent !== text) {
                        root.editingEvent = text
                        root.edited(index, root.editingAge, text)
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
                    font.pixelSize: Theme.fontSizeMedium
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: root.removeRequested(index)
            }
        }
    }
}

