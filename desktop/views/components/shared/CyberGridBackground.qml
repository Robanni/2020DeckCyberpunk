import QtQuick 2.15

Canvas {
    id: canvas
    anchors.fill: parent

    // Настройки сетки
    property color lineColor: "#e94560"   // Основной цвет линий
    property real lineOpacity: 0.25       // Прозрачность линий
    property int gridSize: 20             // Размер ячейки в пикселях
    property real lineWidth: 1            // Толщина линий

    // Автоматическая перерисовка при изменении свойств
    Component.onCompleted: requestPaint()
    onLineColorChanged: requestPaint()
    onLineOpacityChanged: requestPaint()
    onGridSizeChanged: requestPaint()
    onLineWidthChanged: requestPaint()
    onWidthChanged: requestPaint()
    onHeightChanged: requestPaint()

    // Логика отрисовки
    onPaint: {
        const ctx = getContext("2d")
        ctx.strokeStyle = Qt.rgba(
            lineColor.r, 
            lineColor.g, 
            lineColor.b, 
            lineOpacity
        )
        ctx.lineWidth = lineWidth
        
        // Вертикальные линии
        for(let x = 0; x < width; x += gridSize) {
            ctx.beginPath()
            ctx.moveTo(x, 0)
            ctx.lineTo(x, height)
            ctx.stroke()
        }
        
        // Горизонтальные линии
        for(let y = 0; y < height; y += gridSize) {
            ctx.beginPath()
            ctx.moveTo(0, y)
            ctx.lineTo(width, y)
            ctx.stroke()
        }
    }
}
