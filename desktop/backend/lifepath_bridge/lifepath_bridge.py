from PySide6.QtCore import Property, QObject, Signal
from core.models.character import Lifepath
from desktop.backend.lifepath_bridge.enemy_model import EnemyModel
from desktop.backend.lifepath_bridge.family_model import FamilyModel
from desktop.backend.lifepath_bridge.friend_model import FriendModel
from desktop.backend.lifepath_bridge.event_model import LifeEventModel
from desktop.backend.lifepath_bridge.romance_bridge import RomanceBridge
from desktop.controllers.character_controller import CharacterController


class LifepathBridge(QObject):
    originChanged = Signal()
    ethnicBackgroundChanged = Signal()
    familyHistoryChanged = Signal()

    def __init__(self, controller: CharacterController):
        super().__init__()

        self.controller = controller

        self._family_model = FamilyModel(self.controller)
        self._enemy_model = EnemyModel(self.controller)
        self._friend_model = FriendModel(self.controller)
        self._event_model = LifeEventModel(self.controller)
        self._romance_bridge = RomanceBridge(self.controller)

    def get_origin(self):
        return self.controller.character.lifepath.origin

    def set_origin(self, value: str):
        if self.controller.character.lifepath.origin != value:
            self.controller.character.lifepath.origin = value
            self.originChanged.emit()

    origin = Property(str, get_origin, set_origin, notify=originChanged)

    def get_ethnic_background(self):
        return self.controller.character.lifepath.ethnic_background or ""

    def set_ethnic_background(self, value: str):
        if self.controller.character.lifepath.ethnic_background != value:
            self.controller.character.lifepath.ethnic_background = value
            self.ethnicBackgroundChanged.emit()

    ethnicBackground = Property(
        str,
        get_ethnic_background,
        set_ethnic_background,
        notify=ethnicBackgroundChanged,
    )

    def get_family_history(self):
        return self.controller.character.lifepath.family_history or ""

    def set_family_history(self, value: str):
        if self.controller.character.lifepath.family_history != value:
            self.controller.character.lifepath.family_history = value
            self.familyHistoryChanged.emit()

    familyHistory = Property(
        str, get_family_history, set_family_history, notify=familyHistoryChanged
    )

    def get_family_model(self):
        return self._family_model

    def get_enemies(self):
        return self._enemy_model

    def get_friends(self):
        return self._friend_model

    def get_events(self):
        return self._event_model

    def get_romance(self):
        return self._romance_bridge

    familyModel = Property(QObject, get_family_model, constant=True)
    enemiesModel = Property(QObject, get_enemies, constant=True)
    friendsModel = Property(QObject, get_friends, constant=True)
    eventsModel = Property(QObject, get_events, constant=True)
    romance = Property(QObject, get_romance, constant=True)
