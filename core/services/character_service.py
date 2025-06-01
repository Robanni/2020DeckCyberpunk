# core/services/character_service.py
import json
from pathlib import Path
from typing import Optional
from core.models.character import Character

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