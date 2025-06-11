from pathlib import Path

from PySide6.QtWidgets import QFileDialog
from core.models.character import Character, Cyberware, Equipment, Skill
from desktop.views.character import CharacterView
from core.services.character_service import CharacterService


class CharacterController:
    def __init__(self, view: CharacterView, character_service: CharacterService):
        self.view = view
        self.service = character_service

        self.default_save_path = Path("data/characters")
        self.default_save_path.mkdir(parents=True, exist_ok=True)


        self.character: Character = self._load_default_character()

        # Подключаем сигналы
        self.view.character_updated.connect(self.update_character)
        self.view.skill_updated.connect(self.service.update_skill)
        self.view.cyberware_added.connect(self.add_cyberware)
        self.view.cyberware_removed.connect(self.remove_cyberware)
        self.view.equipment_added.connect(self.add_equipment)
        self.view.equipment_removed.connect(self.remove_equipment)

        self.view.save_requested.connect(self.save_character)
        self.view.load_requested.connect(self.load_character)
        self.view.new_character_requested.connect(self.new_character)

    def _load_default_character(self):
        default = self.service.get_character("Johnny Silverhand")
        return default if default else self.service.create_default_character()

    def update_character(self, character: Character):
        self.character = character

    def save_character(self):
        self.service.save_character(self.character, self.default_save_path)

    def load_character(self):
        loaded = self.service.load_character(self.default_save_path)
        if loaded:
            self.character = loaded

    def new_character(self):
        self.character = self.service.create_default_character()

    def add_cyberware(self, cyberware: Cyberware):
        self.character.cyberware.append(cyberware)
        self.character.apply_cyberware_costs()

    def remove_cyberware(self, name: str):
        self.character.cyberware = [c for c in self.character.cyberware if c.name != name]
        self.character.apply_cyberware_costs()

    def add_equipment(self, equipment: Equipment):
        self.character.equipment.append(equipment)

    def remove_equipment(self, name: str):
        self.character.equipment = [e for e in self.character.equipment if e.name != name]