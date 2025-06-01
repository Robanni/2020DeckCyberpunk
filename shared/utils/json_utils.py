from pathlib import Path
from typing import Union
import json

from core.models.character import Character


def load_character_from_json(path: Union[str, Path]) -> Character:
    """Загружает персонажа из JSON-файла"""
    path = Path(path)
    if not path.exists():
        raise FileNotFoundError(f"Файл {path} не найден")
    with path.open("r", encoding="utf-8") as f:
        data = json.load(f)
    return Character(**data)


def save_character_to_json(character: Character, path: Union[str, Path]) -> None:
    """Сохраняет персонажа в JSON-файл"""
    path = Path(path)
    with path.open("w", encoding="utf-8") as f:
        json.dump(character.dict(), f, ensure_ascii=False, indent=2)
