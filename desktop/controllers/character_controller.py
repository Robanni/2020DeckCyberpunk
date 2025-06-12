from pathlib import Path

from PySide6.QtWidgets import QFileDialog
from core.models.character import Character, Cyberware, Equipment, Skill
from core.services.character_service import CharacterService


class CharacterController:
    def __init__(self, character_service: CharacterService):
        self.service = character_service

        self.default_save_path = Path("data/characters")
        self.default_save_path.mkdir(parents=True, exist_ok=True)


        self.character: Character = self._load_default_character()


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