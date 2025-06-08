import json
from pathlib import Path
from typing import Optional
from core.models.character import Character, Equipment, Skill, Cyberware

class CharacterService:
    def __init__(self, save_path: Path = Path("data/characters")):
        self.save_path = save_path
        self.save_path.mkdir(parents=True, exist_ok=True)
    
    def get_character(self, name: str) -> Optional[Character]:
        """Загружает персонажа по имени (ищет в папке сохранений)"""
        file_path = self.save_path / f"{name}.json"
        return self.load_character(file_path)
    
    def load_character(self, file_path: Path) -> Optional[Character]:
        """Загружает персонажа из указанного файла"""
        try:
            if not file_path.exists():
                return None
                
            with open(file_path, "r", encoding="utf-8") as f:
                data = json.load(f)
                return Character(**data)
        except Exception as e:
            print(f"Load error: {e}")
            return None
    
    def save_character(self, character: Character, file_path: Path):
        """Сохраняет персонажа в указанный файл"""
        try:
            with open(file_path, "w", encoding="utf-8") as f:
                json.dump(character.dict(), f, ensure_ascii=False, indent=2)
        except Exception as e:
            print(f"Save error: {e}")
            raise
    
    def create_default_character(self) -> Character:
        """Создает персонажа с настройками по умолчанию"""
        return Character.generate_default()
    
    def update_skill(self, character: Character, skill_name: str, level: int):
        """Обновляет конкретный навык"""
        existing_skill = next(
            (s for s in character.skills if s.name == skill_name), None)
        if existing_skill:
            existing_skill.level = level
        else:
            character.skills.append(Skill(name=skill_name, level=level))

    def add_cyberware(self, character: Character, cyberware: Cyberware):
        """Добавляет кибернетику"""
        character.cyberware.append(cyberware)
        character.apply_cyberware_costs()

    def remove_cyberware(self, character: Character, implant_name: str):
        """Удаляет кибернетику"""
        character.cyberware = [
            c for c in character.cyberware if c.name != implant_name]
        character.apply_cyberware_costs()

    def add_equipment(self, character: Character, equipment: Equipment):
        """Добавляет снаряжение"""
        character.equipment.append(equipment)

    def remove_equipment(self, character: Character, equipment_name: str):
        """Удаляет снаряжение"""
        character.equipment = [
            e for e in character.equipment if e.name != equipment_name]