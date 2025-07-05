import os
import sys

from PySide6.QtCore import QUrl
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine

from core.services.character_service import CharacterService
from desktop.backend.character_bridge import CharacterBridge


class ApplicationInitializer:
    def __init__(self):
        os.environ["QT_QUICK_CONTROLS_STYLE"] = "Material"
        self.app = QApplication(sys.argv)
        self.engine = QQmlApplicationEngine()

        self.character_service = None
        self.character_bridge = None

    def initialize_services(self):
        """Создание backend-сервисов"""
        self.character_service = CharacterService()

    def initialize_controllers(self):
        """Создание мостов между QML и Python"""
        self.character_bridge = CharacterBridge(
            character_service=self.character_service
        )

    def register_contexts(self):
        """Передача объектов в QML-контекст"""
        self.engine.rootContext().setContextProperty(
            "characterBridge", self.character_bridge
        )

    def load_main_qml(self):
        self.engine.load(QUrl("desktop/views/MainWindow.qml"))
        if not self.engine.rootObjects():
            sys.exit(-1)

    def run(self):
        sys.exit(self.app.exec())


class App:
    def __init__(self):
        self.initializer = ApplicationInitializer()

    def setup(self):
        self.initializer.initialize_services()
        self.initializer.initialize_controllers()
        self.initializer.register_contexts()
        self.initializer.load_main_qml()

    def run(self):
        self.initializer.run()


def main():
    app = App()
    app.setup()
    app.run()


if __name__ == "__main__":
    main()
