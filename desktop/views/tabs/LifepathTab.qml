pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../shared"
import "../components/lifepath"

Item {
    id: root
    Layout.fillWidth: true
    Layout.fillHeight: true

    property var lifepathBridge: characterBridge.lifepath

    TabBar {
        id: tabBar
        width: parent.width
        Repeater {
            model: ["Семья", "Друзья", "Враги", "События"]
            TabButton {
                required property string modelData
                text: modelData
            }
        }
    }

    StackLayout {
        width: parent.width
        anchors.top: tabBar.bottom
        anchors.bottom: parent.bottom
        currentIndex: tabBar.currentIndex

        // Вкладка семьи
        ColumnLayout {
            spacing: Theme.spacingMedium

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 60
                color: Theme.surface
                border.color: Theme.border
                radius: Theme.borderRadius

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: Theme.spacingMedium

                    Label {
                        text: "👪 Семья:"
                        font.pixelSize: Theme.fontSizeLarge
                    }

                    Label {
                        text: root.lifepathBridge.familyModel ? root.lifepathBridge.familyModel.count : 0
                        font.pixelSize: Theme.fontSizeLarge
                        font.bold: true
                        color: Theme.accent
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Button {
                        text: "➕ Добавить"
                        onClicked: addFamilyDialog.open()
                    }
                }
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                Column {
                    width: parent.width
                    spacing: Theme.spacingMedium

                    Repeater {
                        model: root.lifepathBridge.familyModel
                        FamilyItem {
                            onRemoveRequested: root.lifepathBridge.familyModel.removeFamilyMember(index)
                            onEdited: root.lifepathBridge.familyModel.updateFamilyMember(index, name, relationship, relationshipNotes, age)
                        }
                    }
                }
            }
        }

        // Вкладка друзей
        ColumnLayout {
            spacing: Theme.spacingMedium

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 60
                color: Theme.surface
                border.color: Theme.border
                radius: Theme.borderRadius

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: Theme.spacingMedium

                    Label {
                        text: "👥 Друзья:"
                        font.pixelSize: Theme.fontSizeLarge
                    }

                    Label {
                        text: lifepathBridge && lifepathBridge.friendsModel ? lifepathBridge.friendsModel.count : 0
                        font.pixelSize: Theme.fontSizeLarge
                        font.bold: true
                        color: Theme.accent
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Button {
                        text: "➕ Добавить"
                        onClicked: addFriendDialog.open()
                    }
                }
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                Column {
                    width: parent.width
                    spacing: Theme.spacingMedium

                    Repeater {
                        model: lifepathBridge ? lifepathBridge.friendsModel : null
                        FriendItem {

                            onRemoveRequested: {
                                if (root.lifepathBridge.friendsModel) {
                                    root.lifepathBridge.friendsModel.removeFriend(index);
                                }
                            }
                            onEdited: {
                                if (root.lifepathBridge.friendsModel) {
                                    root.lifepathBridge.friendsModel.updateFriend(index, name, info, notes);
                                }
                            }
                        }
                    }
                }
            }
        }

        // Вкладка врагов
        ColumnLayout {
            spacing: Theme.spacingMedium

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 60
                color: Theme.surface
                border.color: Theme.border
                radius: Theme.borderRadius

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: Theme.spacingMedium

                    Label {
                        text: "⚔️ Враги:"
                        font.pixelSize: Theme.fontSizeLarge
                    }

                    Label {
                        text: lifepathBridge && lifepathBridge.enemiesModel ? lifepathBridge.enemiesModel.count : 0
                        font.pixelSize: Theme.fontSizeLarge
                        font.bold: true
                        color: Theme.accent
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Button {
                        text: "➕ Добавить"
                        onClicked: addEnemyDialog.open()
                    }
                }
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                Column {
                    width: parent.width
                    spacing: Theme.spacingMedium

                    Repeater {
                        model: lifepathBridge ? lifepathBridge.enemiesModel : null
                        EnemyItem {
                            onRemoveRequested: {
                                if (root.lifepathBridge.enemiesModel) {
                                    root.lifepathBridge.enemiesModel.removeEnemy(index);
                                }
                            }
                            onEdited: {
                                if (root.lifepathBridge.enemiesModel) {
                                    root.lifepathBridge.enemiesModel.updateEnemy(index, name, info);
                                }
                            }
                        }
                    }
                }
            }
        }

        // Вкладка событий
        ColumnLayout {
            spacing: Theme.spacingMedium

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 60
                color: Theme.surface
                border.color: Theme.border
                radius: Theme.borderRadius

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: Theme.spacingMedium

                    Label {
                        text: "📜 События:"
                        font.pixelSize: Theme.fontSizeLarge
                    }

                    Label {
                        text: lifepathBridge && lifepathBridge.eventsModel ? lifepathBridge.eventsModel.count : 0
                        font.pixelSize: Theme.fontSizeLarge
                        font.bold: true
                        color: Theme.accent
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Button {
                        text: "➕ Добавить"
                        onClicked: addEventDialog.open()
                    }
                }
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                Column {
                    width: parent.width
                    spacing: Theme.spacingMedium

                    Repeater {
                        model: lifepathBridge ? lifepathBridge.eventsModel : null
                        EventItem {
                            onRemoveRequested: lifepathBridge.eventsModel.removeEvent(index)
                            onEdited: lifepathBridge.eventsModel.updateEvent(index, age, event)
                        }
                    }
                }
            }
        }
    }

    /// Диалог добавления члена семьи
    Dialog {
        id: addFamilyDialog
        title: "Добавить члена семьи"
        width: 400

        Column {
            anchors.fill: parent
            spacing: Theme.spacingMedium
            padding: Theme.spacingMedium

            TextField {
                id: famNameField
                placeholderText: "Имя"
                width: parent.width
            }
            TextField {
                id: famRelField
                placeholderText: "Родство"
                width: parent.width
            }
            TextArea {
                id: famNotesField
                placeholderText: "Заметки"
                height: 80
                width: parent.width
            }
            SpinBox {
                id: famAgeField
                from: 0
                to: 150
                value: 30
                editable: true
                width: parent.width
            }

            RowLayout {
                width: parent.width
                spacing: Theme.spacingMedium

                Button {
                    text: "Отмена"
                    Layout.fillWidth: true
                    onClicked: addFamilyDialog.close()
                }
                Button {
                    text: "Добавить"
                    Layout.fillWidth: true
                    onClicked: {
                        if (root.lifepathBridge.familyModel) {
                            root.lifepathBridge.familyModel.addFamilyMember(famNameField.text, famRelField.text, famNotesField.text, famAgeField.value);
                            // Сброс полей после добавления
                            famNameField.text = "";
                            famRelField.text = "";
                            famNotesField.text = "";
                            famAgeField.value = 30;
                        }
                        addFamilyDialog.close();
                    }
                }
            }
        }
    }

    // Диалог добавления друга
    Dialog {
        id: addFriendDialog
        title: "Добавить друга"
        width: 400

        Column {
            spacing: Theme.spacingMedium
            padding: Theme.spacingMedium
            width: parent.width

            TextField {
                id: friendNameField
                placeholderText: "Имя друга"
                width: parent.width
            }
            TextField {
                id: friendInfoField
                placeholderText: "Информация о друге"
                width: parent.width
            }
            TextArea {
                id: friendNotesField
                placeholderText: "Заметки об отношениях..."
                height: 80
                width: parent.width
            }

            RowLayout {
                width: parent.width
                spacing: Theme.spacingMedium

                Button {
                    text: "Отмена"
                    Layout.fillWidth: true
                    onClicked: addFriendDialog.close()
                }
                Button {
                    text: "Добавить"
                    Layout.fillWidth: true
                    onClicked: {
                        if (root.lifepathBridge && root.lifepathBridge.friendsModel) {
                            root.lifepathBridge.friendsModel.addFriend(friendNameField.text, friendInfoField.text, friendNotesField.text);
                            friendNameField.text = "";
                            friendInfoField.text = "";
                            friendNotesField.text = "";
                        }
                        addFriendDialog.close();
                    }
                }
            }
        }
    }

    // Диалог добавления врага
    Dialog {
        id: addEnemyDialog
        title: "Добавить врага"
        width: 400

        Column {
            spacing: Theme.spacingMedium
            padding: Theme.spacingMedium
            width: parent.width

            TextField {
                id: enemyNameField
                placeholderText: "Имя врага"
                width: parent.width
            }
            TextField {
                id: enemyInfoField
                placeholderText: "Информация о враге"
                width: parent.width
            }
            TextArea {
                id: enemyNotesField
                placeholderText: "Заметки об отношениях..."
                height: 80
                width: parent.width
            }

            RowLayout {
                width: parent.width
                spacing: Theme.spacingMedium

                Button {
                    text: "Отмена"
                    Layout.fillWidth: true
                    onClicked: addEnemyDialog.close()
                }
                Button {
                    text: "Добавить"
                    Layout.fillWidth: true
                    onClicked: {
                        if (root.lifepathBridge && root.lifepathBridge.enemiesModel) {
                            root.lifepathBridge.enemiesModel.addEnemy(enemyNameField.text, enemyInfoField.text, enemyNotesField.text);
                            enemyNameField.text = "";
                            enemyInfoField.text = "";
                            enemyNotesField.text = "";
                        }
                        addEnemyDialog.close();
                    }
                }
            }
        }
    }
    Dialog {
        id: addEventDialog
        title: "Добавить событие"
        width: 400

        Column {
            spacing: Theme.spacingMedium
            padding: Theme.spacingMedium
            width: parent.width

            TextField {
                id: eventAgeField
                placeholderText: "Возраст"
                width: parent.width
            }

            TextArea {
                id: eventTextField
                placeholderText: "Описание события"
                height: 80
                width: parent.width
            }

            RowLayout {
                width: parent.width
                spacing: Theme.spacingMedium

                Button {
                    text: "Отмена"
                    Layout.fillWidth: true
                    onClicked: addEventDialog.close()
                }

                Button {
                    text: "Добавить"
                    Layout.fillWidth: true
                    onClicked: {
                        if (root.lifepathBridge && root.lifepathBridge.eventsModel) {
                            root.lifepathBridge.eventsModel.addEvent(eventAgeField.text, eventTextField.text);
                            eventAgeField.text = "";
                            eventTextField.text = "";
                        }
                        addEventDialog.close();
                    }
                }
            }
        }
    }
}
