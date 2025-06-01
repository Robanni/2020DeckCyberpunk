from PySide6.QtWidgets import QMainWindow, QTabWidget, QWidget, QVBoxLayout, QLabel

from core.services.character_service import CharacterService
from desktop.controllers.character_controller import CharacterController
from desktop.views.character import CharacterView


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("2020DECK — Панель игрока")

        self.character_service = CharacterService()
        
        # Создаем представление
        self.character_view = CharacterView()
        
        # Создаем контроллер
        self.character_controller = CharacterController(self.character_view, self.character_service)
            

        # Табы
        self.tabs = QTabWidget()
        self.setCentralWidget(self.tabs)

        # Добавляем вкладки
        self._init_tabs()

    def _init_tabs(self):
        self.tabs.addTab(self._create_char_tab(), "🎭 Персонаж")
        # self.tabs.addTab(self._create_npc_tab(), "🤖 NPC-Генератор")
        # self.tabs.addTab(self._create_drop_tab(), "💼 Дроп")
        # self.tabs.addTab(self._create_settings_tab(), "⚙️ Настройки")

    def _create_char_tab(self) -> QWidget:
        tab = QWidget()
        layout = QVBoxLayout()
    
        layout.addWidget(self.character_view)
        
        tab.setLayout(layout)
        return tab

    def _create_npc_tab(self) -> QWidget:
        tab = QWidget()
        layout = QVBoxLayout()
        layout.addWidget(QLabel("Тут будет генерация NPC"))
        tab.setLayout(layout)
        return tab

    def _create_drop_tab(self) -> QWidget:
        tab = QWidget()
        layout = QVBoxLayout()
        layout.addWidget(QLabel("Тут будет дроп"))
        tab.setLayout(layout)
        return tab

    def _create_settings_tab(self) -> QWidget:
        tab = QWidget()
        layout = QVBoxLayout()
        layout.addWidget(QLabel("Настройки и инфо"))
        tab.setLayout(layout)
        return tab
