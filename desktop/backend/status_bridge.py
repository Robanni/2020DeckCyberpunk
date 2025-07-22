from PySide6.QtCore import QObject, Property, Signal

from core.models.character import Character
from desktop.controllers.character_controller import CharacterController


class StatusBridge(QObject):
    healthChanged = Signal()

    def __init__(self, controller: CharacterController):
        super().__init__()
        self._controller = controller

    def update(self):
        self.healthChanged.emit()

    def get_current_damage(self):
        return self._controller.character.health.current_damage

    def set_current_damage(self, value):
        self._controller.character.health.current_damage = value
        self.healthChanged.emit()

    current_damage = Property(
        int, get_current_damage, set_current_damage, None, "", notify=healthChanged
    )
