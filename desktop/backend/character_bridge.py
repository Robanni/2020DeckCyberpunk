from PySide6.QtCore import QObject, Property
from desktop.backend.armor_bridge import ArmorBridge
from desktop.backend.info_bridge import InfoBridge
from desktop.backend.skills_bridge import SkillsBridge
from desktop.backend.stats_bridge import StatsBridge
from core.services.character_service import CharacterService
from desktop.backend.status_bridge import StatusBridge
from desktop.controllers.character_controller import CharacterController


class CharacterBridge(QObject):
    def __init__(self, character_service: CharacterService):
        super().__init__()

        self.controller = CharacterController( character_service=character_service)

        
        self._info_bridge = InfoBridge(character=self.controller.character)
        self._stats_bridge = StatsBridge(stats=self.controller.character.stats)
        self._status_bridge = StatusBridge(character=self.controller.character)
        self._armor_bridge = ArmorBridge(armor=self.controller.character.armor)
        self._skills_model = SkillsBridge(self.controller)

    def get_info(self):
        return self._info_bridge

    def set_info(self, value):
        pass

    info = Property(QObject, get_info, set_info, None, "")

    def get_stats(self):
        return self._stats_bridge

    def set_stats(self, value):
        pass

    stats = Property(QObject, get_stats, set_stats, None, "")

    def get_status(self):
        return self._status_bridge

    def set_status(self, value):
        pass

    status = Property(QObject, get_status, set_status, None, "")

    def get_armor(self):
        return self._armor_bridge

    def set_armor(self, value):
        pass

    armor = Property(QObject, get_armor, set_armor, None, "")


    def get_skills_model(self):
        return self._skills_model

    skillsModel = Property(QObject, get_skills_model, constant=True) # type: ignore

    