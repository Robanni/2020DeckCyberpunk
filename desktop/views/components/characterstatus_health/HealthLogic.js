function updateStatus(blocksStatus, blockIndex, boxIndex) {
    // Создаем  копию массива
    var newStatus = []
    for (var i = 0; i < blocksStatus.length; i++) {
        newStatus.push(blocksStatus[i].slice())
    }
    
    // Обрабатываем текущий блок
    var currentBlock = newStatus[blockIndex]
    var currentState = currentBlock[boxIndex]
    
    if (!currentState) {
        // Заполняем все до текущей позиции
        for (var j = 0; j <= boxIndex; j++) {
            currentBlock[j] = true
        }
    } else {
        // Сбрасываем все после текущей позиции
        for (var k = boxIndex; k < currentBlock.length; k++) {
            currentBlock[k] = false
        }
    }
    
    // Заполняем все предыдущие блоки
    for (i = 0; i < blockIndex; i++) {
        for (j = 0; j < newStatus[i].length; j++) {
            newStatus[i][j] = true
        }
    }
    
    // Сбрасываем все последующие блоки
    for (i = blockIndex + 1; i < newStatus.length; i++) {
        for (j = 0; j < newStatus[i].length; j++) {
            newStatus[i][j] = false
        }
    }
    
    return newStatus
}