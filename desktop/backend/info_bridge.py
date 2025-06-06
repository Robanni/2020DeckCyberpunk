from PySide6.QtCore import QObject, Property, Signal

from core.models.character import Character


class InfoBridge(QObject):
    nameChanged = Signal()
    handleChanged = Signal()
    roleChanged = Signal()
    specialAbilityChanged = Signal()

    def __init__(self, character:Character):
        super().__init__()
        self._character = character

    def get_name(self): return self._character.name

    def set_name(self, value):
        if self._character.name != value:
            self._character.name = value
            self.nameChanged.emit()
    name = Property(str, get_name, set_name, None, "",  notify=nameChanged)

    def get_handle(self): return self._character.handle or ""

    def set_handle(self, value):
        if self._character.handle != value:
            self._character.handle = value
            self.handleChanged.emit()
    handle = Property(str, get_handle, set_handle,
                      None, "",  notify=handleChanged)

    def get_role(self): return self._character.role

    def set_role(self, value):
        if self._character.role != value:
            self._character.role = value
            self.roleChanged.emit()
    role = Property(str, get_role, set_role, None, "",  notify=roleChanged)

    def get_special_ability(self): return self._character.special_ability

    def set_special_ability(self, value):
        if self._character.special_ability != value:
            self._character.special_ability = value
            self.specialAbilityChanged.emit()
    specialAbility = Property(
        str, get_special_ability, set_special_ability, None, "", notify=specialAbilityChanged)
