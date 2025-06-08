from PySide6.QtCore import QObject, Property, Signal

from core.models.character import Character


class StatusBridge(QObject):
    healthChanged = Signal()

    def __init__(self, character: Character):
        super().__init__()
        self._character = character


    def get_current_damage(self): return self._character.health.current_damage

    def set_current_damage(self, value):
        self._character.health.current_damage = value
        self.healthChanged.emit()
    current_damage = Property(int, get_current_damage, set_current_damage,
                      None, "",  notify=healthChanged)
