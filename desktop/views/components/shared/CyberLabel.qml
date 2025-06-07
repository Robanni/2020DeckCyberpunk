import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects 

Label {
    property bool header: false

    color: "#e94560" // Неоново-розовый цвет
    font {
        family: header ? "Courier New" : "Arial"
        bold: true
        pixelSize: header ? 18 : 14
        letterSpacing: header ? 1.5 : 0.5
    }

    // Эффект свечения через тень текста (альтернатива Glow)
    layer.enabled: true
    layer.effect: DropShadow {
        color: "#e94560"
        radius: 3
        samples: 6
        spread: 0.2
    }

    // Простая анимация без QtQuick.Animations
    Timer {
        interval: 50
        running: true
        repeat: true
        property real hue: 0
        onTriggered: {
            hue = (hue + 0.01) % 1.0
            parent.color = Qt.hsva(hue, 0.8, 1.0, 1.0)
        }
    }
}