from PySide6.QtCore import QObject, Property, Signal

from core.models.character import Character
from desktop.controllers.character_controller import CharacterController


class InfoBridge(QObject):
    nameChanged = Signal()
    handleChanged = Signal()
    roleChanged = Signal()
    specialAbilityChanged = Signal()

    def __init__(self, controller: CharacterController):
        super().__init__()
        self._controller = controller


    def update(self):
        self.nameChanged.emit()
        self.roleChanged.emit()
        self.handleChanged.emit()
        self.specialAbilityChanged.emit()

    def get_name(self):
        return self._controller.character.name

    def set_name(self, value):
        if self._controller.character.name != value:
            self._controller.character.name = value
            self.nameChanged.emit()

    def get_handle(self):
        return self._controller.character.handle or ""

    def set_handle(self, value):
        if self._controller.character.handle != value:
            self._controller.character.handle = value
            self.handleChanged.emit()

    def get_role(self):
        return self._controller.character.role

    def set_role(self, value):
        if self._controller.character.role != value:
            self._controller.character.role = value
            self.roleChanged.emit()

    def get_special_ability(self):
        return self._controller.character.special_ability

    def set_special_ability(self, value):
        if self._controller.character.special_ability != value:
            self._controller.character.special_ability = value
            self.specialAbilityChanged.emit()

    name = Property(str, get_name, set_name, notify=nameChanged)
    handle = Property(str, get_handle, set_handle, notify=handleChanged)
    role = Property(str, get_role, set_role, notify=roleChanged)
    specialAbility = Property(
        str, get_special_ability, set_special_ability, notify=specialAbilityChanged
    )
