# desktop/controllers/character_controller.py
from pathlib import Path

from PySide6.QtWidgets import QFileDialog
from core.models.character import Character, Cyberware, Equipment, Skill
from desktop.views.character import CharacterView
from core.services.character_service import CharacterService


class CharacterController:
    def __init__(self, view: CharacterView, character_service: CharacterService):
        self.view: CharacterView = view
        self.service: CharacterService = character_service
        self.current_file_path = None
        self.character: Character = self._load_default_character()

        # Подключаем сигналы
        self.view.character_updated.connect(self.update_character)
        self.view.skill_updated.connect(self.update_skill)
        self.view.cyberware_added.connect(self.add_cyberware)
        self.view.cyberware_removed.connect(self.remove_cyberware)
        self.view.equipment_added.connect(self.add_equipment)
        self.view.equipment_removed.connect(self.remove_equipment)

        # Подключаем сигналы управления
        self.view.save_requested.connect(self.save_character)
        self.view.load_requested.connect(self.load_character)
        self.view.new_character_requested.connect(self.new_character)

        # Инициализация данных
        self.view.update_character(self.character)

    def _load_default_character(self):
        """Загружает тестового персонажа или создаёт нового"""
        default_char = self.service.get_character("Johnny Silverhand")
        if default_char:
            return default_char
        return self.service.create_default_character()

    def update_character(self, character: Character):
        """Обновляет модель на основе данных из View (без сохранения)"""
        self.character.name = character.name
        self.character.handle = character.handle
        self.character.role = character.role
        self.character.armor = character.armor
        self.character.special_ability = character.special_ability
        self.character.stats = character.stats
        self.character.lifepath = character.lifepath
        self.character.reputation = character.reputation
        self.character.money = character.money
        self.character.notes = character.notes

    def save_character(self):
        """Сохраняет текущего персонажа в файл"""
        if not self.current_file_path:
            self.save_character_as()
        else:
            self._save_to_file(self.current_file_path)

    def save_character_as(self):
        """Сохраняет персонажа с выбором файла"""
        path, _ = QFileDialog.getSaveFileName(
            None,
            "Сохранить персонажа",
            str(self.service.save_path / f"{self.character.name}.json"),
            "JSON Files (*.json)"
        )
        if path:
            self.current_file_path = Path(path)
            self._save_to_file(self.current_file_path)

    def load_character(self):
        """Загружает персонажа из файла"""
        path, _ = QFileDialog.getOpenFileName(
            None,
            "Загрузить персонажа",
            str(self.service.save_path),
            "JSON Files (*.json)"
        )
        if path:
            self.current_file_path = Path(path)
            loaded = self.service.load_character(self.current_file_path)
            if loaded:
                self.character = loaded
                self.view.update_character(self.character)
            else:
                print("Не удалось загрузить персонажа: файл пустой или повреждён.")

    def new_character(self):
        """Создаёт нового персонажа с настройками по умолчанию"""
        self.character = self.service.create_default_character()
        self.current_file_path = None
        self.view.update_character(self.character)

    def _save_to_file(self, path: Path):
        """Внутренний метод для сохранения в файл"""
        try:
            self.service.save_character(self.character, path)
            print(f"Персонаж сохранён: {path}")
        except Exception as e:
            print(f"Ошибка сохранения: {e}")

    def update_skill(self, skill_name: str, level: int):
        """Обновляет конкретный навык"""
        # Переносим логику в сервис
        self.service.update_skill(self.character, skill_name, level)

    def add_cyberware(self, cyberware: Cyberware):
        """Добавляет кибернетику"""
        self.character.cyberware.append(cyberware)
        self.character.apply_cyberware_costs()
        self.view.update_character(self.character)

    def remove_cyberware(self, implant_name: str):
        """Удаляет кибернетику"""
        self.character.cyberware = [
            c for c in self.character.cyberware if c.name != implant_name]
        self.character.apply_cyberware_costs()
        self.view.update_character(self.character)

    def add_equipment(self, equipment: Equipment):
        """Добавляет снаряжение"""
        self.character.equipment.append(equipment)
        self.view.update_character(self.character)

    def remove_equipment(self, equipment_name: str):
        """Удаляет снаряжение"""
        self.character.equipment = [
            e for e in self.character.equipment if e.name != equipment_name]
        self.view.update_character(self.character)