from PySide6.QtCore import QObject, Property, Signal
from core.models.character import Character
from desktop.controllers.character_controller import CharacterController


class OtherBridge(QObject):
    styleChanged = Signal()
    notesChanged = Signal()

    def __init__(self, controller: CharacterController):
        super().__init__()
        self.controller = controller
        self._character: Character = controller.character

    def update(self):
        self.styleChanged.emit()
        self.notesChanged.emit()

    def get_style(self):
        return self._character.style or ""

    def set_style(self, value: str):
        if self._character.style != value:
            self._character.style = value
            self.styleChanged.emit()

    style = Property(str, get_style, set_style, notify=styleChanged)

    def get_notes(self):
        return self._character.notes or ""

    def set_notes(self, value: str):
        if self._character.notes != value:
            self._character.notes = value
            self.notesChanged.emit()

    notes = Property(str, get_notes, set_notes, notify=notesChanged)
