pragma Singleton
import QtQuick 2.15
import QtQuick.Controls 2.15

QtObject {
    // 🎨 Основные цвета
    property color background: "#0f3460"
    property color foreground: "#ffffff"
    property color accent: "#e94560"
    property color border: "#e94560"
    property color surface: "#16213e"
    property color highlight: "#20e94560"
    property color danger: "#ff5555"
    property color text: "#e94560"
    property color textSecondary: "#a0a0a0"
    property color textOnSurface: "#ffffff"

    // 🔤 Шрифты и текст
    property int fontSizeSmall: 12
    property int fontSizeNormal: 14
    property int fontSizeMedium: 16
    property int fontSizeLarge: 20
    property int fontSizeExtraLarge: 24
    property string fontFamily: "Segoe UI"
    property font defaultFont: Qt.font({
        family: fontFamily,
        pixelSize: fontSizeNormal
    })

    // 📦 Отступы и промежутки
    property int spacingTiny: 2
    property int spacingSmall: 4
    property int spacingMedium: 8
    property int spacingLarge: 16
    property int spacingExtraLarge: 24

    // 📐 Размеры и радиусы
    property int borderRadiusSmall: 4
    property int borderRadius: 6
    property int borderRadiusLarge: 8
    property int borderWidth: 1
    property int borderWidthThick: 2

    // 🛠 Размеры элементов
    property int controlHeightSmall: 28
    property int controlHeightNormal: 36
    property int controlHeightLarge: 44
    property int buttonMinWidth: 80
}