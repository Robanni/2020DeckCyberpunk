from pathlib import Path

from core.models.character import Character, Cyberware, Equipment, Skill
from core.services.character_service import CharacterService
from core.usecases.character_logic import CharacterUseCase


class CharacterController:
    def __init__(self, character_service: CharacterService):
        self.service = character_service

        self.default_save_path = Path("data/characters")
        self.default_save_path.mkdir(parents=True, exist_ok=True)

        self.usecase = CharacterUseCase()
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
        self.usecase.add_cyberware(self.character,cyberware)

    def remove_cyberware(self, name: str):
        self.usecase.remove_cyberware(self.character,name)

    def add_equipment(self, equipment: Equipment):
        self.usecase.add_equipment(self.character,equipment)

    def remove_equipment(self, name: str):
        self.usecase.remove_equipment(self.character,name)

    def add_skill(self, name: str, level: int, category: str = "", description: str = ""):
        self.usecase.add_skill(self.character, name, level, category, description)

    def remove_skill(self, name: str):
        self.usecase.remove_skill(self.character, name)

    def update_skill(self, index: int, name: str, level: int, category: str = "", description: str = ""):
        self.usecase.update_skill_by_index(self.character, index, name, level, category, description)
