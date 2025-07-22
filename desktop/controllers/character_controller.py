from pathlib import Path
from typing import Optional

from core.models.character import Character, Cyberware, Equipment
from core.services.character_service import CharacterService
from core.usecases.character_logic import CharacterUseCase


class CharacterController:
    def __init__(self, character_service: CharacterService):
        self.service = character_service

        self.default_save_path = Path("data/characters")
        self.default_save_path.mkdir(parents=True, exist_ok=True)

        self.usecase = CharacterUseCase()
        self.character: Character = self._load_default_character()

    def get_default_save_path(self):
        return str(self.default_save_path.absolute())

    def _load_default_character(self):
        default = self.service.get_character("Johnny Silverhand")
        return default if default else self.service.create_default_character()

    def update_character(self, character: Character):
        self.character = character

    def save_character(self):
        return self.service.save_character(self.character, self.default_save_path)

    def load_character(self, file_path: str):
        file_path = Path(file_path)
        loaded = self.service.load_character(file_path)
        if loaded:
            self.character = loaded

    def new_character(self):
        self.character = self.service.create_default_character()

    def add_cyberware(self, cyberware: Cyberware):
        self.usecase.add_cyberware(self.character, cyberware)

    def remove_cyberware(self, name: str):
        self.usecase.remove_cyberware(self.character, name)

    def update_cyberware(
        self, index: int, name: str, description: str, humanity_cost: int
    ):
        self.usecase.update_cyberware_by_index(
            character=self.character,
            index=index,
            name=name,
            description=description,
            humanity_cost=humanity_cost,
        )

    def add_skill(
        self,
        stat: str,
        group_title: str,
        name: str,
        level: int,
        description: str = "",
        skill_id: Optional[int] = None,
    ):
        self.usecase.add_skill(
            self.character,
            stat=stat,
            group_title=group_title,
            name=name,
            level=level,
            skill_id=skill_id,
            description=description,
        )

    def remove_skill(self, stat: str, name: str):
        self.usecase.remove_skill(character=self.character, stat=stat, name=name)

    def update_skill(
        self,
        stat: str,
        skill_id: int,
        title: str,
        level: int,
        description: str = "",
    ):
        self.usecase.update_skill_by_id(
            character=self.character,
            stat=stat,
            skill_id=skill_id,
            title=title,
            level=level,
            description=description,
        )

    def add_equipment(self, equipment: Equipment):
        self.usecase.add_equipment(self.character, equipment)

    def remove_equipment(self, name: str):
        self.usecase.remove_equipment(self.character, name)

    def update_equipment(self, index: int, equipment: Equipment):
        self.usecase.update_equipment_by_index(self.character, index, equipment)
