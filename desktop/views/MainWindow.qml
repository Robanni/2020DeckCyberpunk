import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import "tabs"

ApplicationWindow {
    visible: true
    width: 1024
    height: 768
    title: "2020DECK — Панель игрока"
    Material.theme: Material.Dark
    Material.accent: Material.Purple

    // Состояние загрузки
    property bool isBackendReady: false
    property bool isDataLoaded: false
    property bool isReady: isBackendReady && isDataLoaded

    // Проверяем готовность бэкенда
    function checkBackend() {
        if (typeof characterBridge !== 'undefined' && characterBridge) {
            isBackendReady = true
            loadData()
        }
    }

    // Загружаем данные после готовности бэкенда
    function loadData() {
        if (!isBackendReady) return
        
        // Проверяем наличие всех необходимых данных
        if (characterBridge.status && 
            characterBridge.stats && 
            characterBridge.info &&
            characterBridge.armor) {
            isDataLoaded = true
        }
    }

    // Проверяем бэкенд при создании и периодически
    Component.onCompleted: {
        checkBackend()
        // Проверяем каждые 100мс на случай асинхронной загрузки
        backendCheckTimer.start()
    }

    Timer {
        id: backendCheckTimer
        interval: 100
        repeat: true
        onTriggered: {
            if (isReady) {
                stop()
            } else {
                checkBackend()
            }
        }
    }

    // Основной интерфейс показываем только когда все готово
    Loader {
        id: mainLoader
        anchors.fill: parent
        active: isReady
        sourceComponent: mainComponent
    }

    // Индикатор загрузки
    BusyIndicator {
        anchors.centerIn: parent
        running: !isReady
        visible: !isReady
        Material.accent: Material.Purple
    }

    // Текст статуса загрузки
    Text {
        anchors.top: parent.verticalCenter
        anchors.topMargin: 60
        anchors.horizontalCenter: parent.horizontalCenter
        text: {
            if (!isBackendReady) return "Загрузка бэкенда..."
            if (!isDataLoaded) return "Загрузка данных персонажа..."
            return "Запуск приложения..."
        }
        color: Material.color(Material.Purple)
        font.pixelSize: 16
        visible: !isReady
    }

    // Главный компонент интерфейса (загружается только когда все готово)
    Component {
        id: mainComponent
        
        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            // Стилизованная панель вкладок
            TabBar {
                id: tabBar
                Layout.fillWidth: true
                currentIndex: 0
                Material.background: "#1a1a2e"
                Material.foreground: "#e94560"

                Repeater {
                    model: ["🎭 Персонаж", "🛡️ Броня", "🔧 Навыки", "⚙️ Кибернетика", "🔫 Оборудование", "📝 Жизненный Путь", "📋 Прочее"]
                    
                    TabButton {
                        text: modelData
                        padding: 12
                        font.bold: true
                        font.pixelSize: 14
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#16213e"
                border.color: "#e94560"
                border.width: 1
                radius: 4

                StackLayout {
                    id: stackLayout
                    anchors.fill: parent
                    anchors.margins: 10
                    currentIndex: tabBar.currentIndex

                    CharacterTab {}
                    CharacterStatusTab {}
                    SkillsTab {}
                    CyberwareTab {}
                    EquipmentTab {}
                    LifepathTab {}
                    OtherInfoTab {}
                }
            }
        }
    }
}