import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects 

Label {
    property bool header: false
    property int animationDuration: 2200 // Длительность одного этапа анимации в мс

    color: "#e94560" // Розовато-красный основной цвет проекта
    font {
        family: header ? "Courier New" : "Arial"
        bold: true
        pixelSize: header ? 18 : 14
        letterSpacing: header ? 1.2 : 0.4
    }

    // Мягкое, анимированное свечение
    layer.enabled: true
    layer.effect: DropShadow {
        id: shadow
        color: "#ffb3c6" // Очень светлый розовый для свечения
        radius: 2
        samples: 6
        spread: 0.02
        transparentBorder: true
        opacity: 0.4
        // Анимация свечения
        SequentialAnimation on opacity {
            loops: Animation.Infinite
            NumberAnimation { to: 0.7; duration: animationDuration; easing.type: Easing.InOutQuad }
            NumberAnimation { to: 0.3; duration: animationDuration; easing.type: Easing.InOutQuad }
        }
    }
}