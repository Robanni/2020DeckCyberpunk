from PySide6.QtCore import QUrl
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine

from core.services.character_service import CharacterService
from desktop.backend.character_bridge import CharacterBridge

import os
os.environ["QT_QUICK_CONTROLS_STYLE"] = "Material"  # Или "Fusion", "Basic"

app = QApplication([])

# Создаем контроллер
character_service = CharacterService()
character_bridge = CharacterBridge( character_service=character_service)

engine = QQmlApplicationEngine()

# Передаем объект CharacterBridge в QML
engine.rootContext().setContextProperty("characterBridge", character_bridge)

# Загружаем основной QML файл
engine.load(QUrl("desktop/views/MainWindow.qml"))

if not engine.rootObjects():
    exit(-1)

app.exec()
