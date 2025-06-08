from PySide6.QtCore import QObject, Property
from desktop.backend.info_bridge import InfoBridge
from desktop.backend.stats_bridge import StatsBridge
from core.services.character_service import CharacterService
from desktop.backend.status_bridge import StatusBridge
from desktop.controllers.character_controller import CharacterController
from desktop.views.character import CharacterView


class CharacterBridge(QObject):
    def __init__(self, view: CharacterView, character_service: CharacterService):
        super().__init__()

        self.controller = CharacterController(view=view, character_service=character_service)

        
        self._info_bridge = InfoBridge(character=self.controller.character)
        self._stats_bridge = StatsBridge(stats=self.controller.character.stats)
        self._status_bridge = StatusBridge(character=self.controller.character)

    def get_info(self):
        return self._info_bridge

    def set_info(self, value):
        self._info_bridge = value

    info = Property(QObject, get_info, set_info, None, "")

    def get_stats(self):
        return self._stats_bridge

    def set_stats(self, value):
        self._stats_bridge = value

    stats = Property(QObject, get_stats, set_stats, None, "")

    def get_status(self):
        return self._status_bridge

    def set_status(self, value):
        self._status_bridge = value

    status = Property(QObject, get_status, set_status, None, "")
