pragma Singleton
import QtQuick 2.15
import QtQuick.Controls 2.15

QtObject {
    // 🎨 Цвета
    property color background: "#0f3460"
    property color foreground: "#ffffff"
    property color accent: "#e94560"
    property color border: "#e94560"
    property color surface: "#16213e"
    property color highlight: "#20e94560"
    property color danger: "#ff5555"

    // 🔤 Шрифты
    property int fontSizeNormal: 14
    property int fontSizeLarge: 20
    property string fontFamily: "Segoe UI"

    // 📦 Отступы
    property int spacingSmall: 4
    property int spacingMedium: 10
    property int spacingLarge: 20

    // 📐 Размеры и радиусы
    property int borderRadius: 6
    property int borderWidth: 2
}
