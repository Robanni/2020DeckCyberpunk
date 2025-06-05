from PySide6.QtCore import QObject, Property
from desktop.backend.stats_bridge import StatsBridge
from core.services.character_service import CharacterService
from desktop.controllers.character_controller import CharacterController
from desktop.views.character import CharacterView


class CharacterBridge(QObject):
    def __init__(self, view: CharacterView, character_service: CharacterService):
        super().__init__()

        self.controller = CharacterController(view=view, character_service=character_service)
        
        self._stats_bridge = StatsBridge(stats=self.controller.character.stats)

    def get_stats(self):
        return self._stats_bridge

    def set_stats(self, value):
        self._stats_bridge = value

    stats = Property(QObject, get_stats, set_stats, None, "")
