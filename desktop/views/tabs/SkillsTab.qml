pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../shared"
import "../components/Skills"

Item {
    id: root
    Layout.fillWidth: true
    Layout.fillHeight: true

    property var skillsModel: characterBridge.skillsModel
    signal addSkillRequested
    signal removeRequested(int skillId)
    signal skillChanged(int index, string name, string category, string description, int level)

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
            spacing: Theme.spacingLarge
            anchors.centerIn: parent

            // Карточка со списком навыков
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: listView.contentHeight + 80
                color: Theme.surface
                border.color: Theme.border
                border.width: 1
                radius: Theme.borderRadius

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: Theme.spacingMedium
                    spacing: Theme.spacingMedium

                    Label {
                        text: "📚 Навыки"
                        font.pixelSize: Theme.fontSizeLarge
                        font.bold: true
                        color: Theme.accent
                        Layout.alignment: Qt.AlignHCenter
                    }

                    ListView {
                        id: listView
                        model: root.skillsModel
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        spacing: Theme.spacingSmall
                        clip: true

                        delegate: SkillItem {
                            onRemoveRequested: function (index) {
                                root.removeRequested(index);
                            }
                            onEdited: function (skillId, name, category, description, level) {
                                root.skillChanged(skillId, name, category, description, level);
                            }
                        }
                    }

                    Button {
                        text: "➕ Добавить навык"
                        Layout.alignment: Qt.AlignRight
                        onClicked: root.addSkillRequested()
                    }
                }
            }
        }

    }
    // Диалог для добавления нового навыка
    Dialog {
        id: addSkillDialog
        visible: false
        width: addSkillDialogLayout.preferredWidth
        height: addSkillDialogLayout.preferredHeight
        modal: true
        title: "Добавить новый навык"

        ColumnLayout {
            id: addSkillDialogLayout
            spacing: Theme.spacingMedium
            anchors.fill: parent

            TextField {
                id: nameField
                placeholderText: "Название навыка"
                Layout.fillWidth: true
            }

            TextField {
                id: categoryField
                placeholderText: "Категория"
                Layout.fillWidth: true
            }

            TextArea {
                id: descriptionField
                placeholderText: "Описание"
                Layout.fillWidth: true
            }

            Slider {
                id: levelSlider
                from: 1
                to: 10
                value: 1
                stepSize: 1
                Layout.fillWidth: true
                Label {
                    text: levelSlider.value
                    horizontalAlignment: Text.AlignCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Button {
                text: "Добавить"
                onClicked: {
                    const newSkill = {
                        name: nameField.text,
                        category: categoryField.text,
                        description: descriptionField.text,
                        level: Math.floor(levelSlider.value)
                    };
                    root.skillsModel.addSkill(newSkill.name, newSkill.category, newSkill.description, newSkill.level);
                    addSkillDialog.visible = false;
                }
            }

            Button {
                text: "Отмена"
                onClicked: addSkillDialog.visible = false
            }
        }
    }

    // Обработка сигнала добавления навыка
    onAddSkillRequested: {
        addSkillDialog.visible = true;
    }
    onRemoveRequested: function (skillId) {
        console.log(`Remove skill ${skillId}:`);
        root.skillsModel.removeSkill(skillId);
    }

    onSkillChanged: function (skillId, title, category, description, level) {
        console.log(`Skill updated [ID: ${skillId}] Name: "${title}", Category: "${category}", Level: ${level}, Description: "${description}"`);
        root.skillsModel.updateSkill(skillId, title, category, description, level);
    }
}
