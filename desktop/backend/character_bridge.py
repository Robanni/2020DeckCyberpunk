from PySide6.QtCore import QObject, Property, Signal, Slot
from desktop.backend.armor_bridge import ArmorBridge
from desktop.backend.cyberware_bridge import CyberwareBridge
from desktop.backend.equipment_bridge import EquipmentBridge
from desktop.backend.info_bridge import InfoBridge
from desktop.backend.lifepath_bridge.lifepath_bridge import LifepathBridge
from desktop.backend.other import OtherBridge
from desktop.backend.skills_bridge import SkillsBridge
from desktop.backend.stats_bridge import StatsBridge
from core.services.character_service import CharacterService
from desktop.backend.status_bridge import StatusBridge
from desktop.controllers.character_controller import CharacterController


class CharacterBridge(QObject):
    operationCompleted = Signal(str)
    characterSaved = Signal(bool)

    def __init__(self, character_service: CharacterService):
        super().__init__()

        self.controller = CharacterController(character_service=character_service)

        self._info_bridge = InfoBridge(self.controller)
        self._stats_bridge = StatsBridge(self.controller)
        self._status_bridge = StatusBridge(self.controller)
        self._armor_bridge = ArmorBridge(self.controller)

        self._skills_model = SkillsBridge(self.controller)
        self._cyberware_bridge = CyberwareBridge(self.controller)
        self._equipment_bridge = EquipmentBridge(self.controller)
        self._lifepath_bridge = LifepathBridge(self.controller)
        self._other_bridge = OtherBridge(self.controller)
    
    @Slot(result=str)
    def get_default_save_path(self):
        return self.controller.get_default_save_path()

    @Slot(result=str)
    def saveCharacter(self):
        result = self.controller.save_character()
        self.characterSaved.emit(result)
        return result

    @Slot(str,result=str)
    def loadCharacter(self, file_path: str):
        result = self.controller.load_character(file_path)
        self.operationCompleted.emit(result)
        self._update_all_bridges()
        return result

    @Slot(result=str)
    def newCharacter(self):
        result = self.controller.new_character()
        self.operationCompleted.emit(result)
        self._update_all_bridges()
        return result

    def _update_all_bridges(self):
        self._info_bridge.update()
        self._stats_bridge.update()
        self._status_bridge.update()
        self._armor_bridge.update()
        self._skills_model.update()
        self._cyberware_bridge.update()
        self._equipment_bridge.update()
        self._lifepath_bridge.update()
        self._other_bridge.update()

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

    skillsModel = Property(QObject, get_skills_model, constant=True)

    def get_cyberware_bridge(self):
        return self._cyberware_bridge

    cyberwareModel = Property(QObject, get_cyberware_bridge, constant=True)

    def get_equipment_bridge(self):
        return self._equipment_bridge

    equipmentModel = Property(QObject, get_equipment_bridge, constant=True)

    def get_lifepath_bridge(self):
        return self._lifepath_bridge

    lifepath = Property(QObject, get_lifepath_bridge, constant=True)

    def get_other(self):
        return self._other_bridge

    other = Property(QObject, get_other, constant=True)
