from PySide6.QtCore import QObject, Property, Signal
from core.models.character import Romance
from desktop.controllers.character_controller import CharacterController



class RomanceBridge(QObject):
    nameChanged = Signal()
    infoChanged = Signal()

    def __init__(self, controller: CharacterController):
        super().__init__()
        self.controller = controller
        self._romance = self.controller.character.lifepath.romance or Romance(name="", info="")

    def update(self):
        self._romance = self.controller.character.lifepath.romance
        self.nameChanged.emit()
        self.infoChanged.emit()

    def get_name(self):
        return self._romance.name

    def set_name(self, value):
        if self._romance.name != value:
            self._romance.name = value
            self.nameChanged.emit()

    name = Property(str, get_name, set_name, notify=nameChanged)

    def get_info(self):
        return self._romance.info

    def set_info(self, value):
        if self._romance.info != value:
            self._romance.info = value
            self.infoChanged.emit()

    info = Property(str, get_info, set_info, notify=infoChanged)