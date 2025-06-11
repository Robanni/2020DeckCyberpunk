from PySide6.QtGui import QFont
from PySide6.QtWidgets import (
    QFrame, QHBoxLayout, QLayout, QPushButton, QWidget, QTabWidget, QFormLayout, QLineEdit, QSpinBox, QTextEdit,
    QListWidget, QListWidgetItem, QTableWidget, QTableWidgetItem,
    QVBoxLayout, QLabel, QGroupBox, QGridLayout, QComboBox, QMessageBox
)
from PySide6.QtCore import Qt, Signal
from core.models.character import Armor, Character, CharacterStats, Health, Skill, Equipment, Cyberware, Lifepath



class CharacterView(QWidget):
    character_updated = Signal(Character)
    skill_updated = Signal(str, int)
    cyberware_added = Signal(object)  
    cyberware_removed = Signal(str)
    equipment_added = Signal(object)  
    equipment_removed = Signal(str)
    save_requested = Signal()
    load_requested = Signal()
    new_character_requested = Signal()

    def __init__(self, parent=None):
        super().__init__(parent)

    def emit_character_update(self, character: Character):
        self.character_updated.emit(character)

    def emit_skill_updated(self, name: str, value: int):
        self.skill_updated.emit(name, value)

    def emit_cyberware_added(self, cyberware):
        self.cyberware_added.emit(cyberware)

    def emit_cyberware_removed(self, name: str):
        self.cyberware_removed.emit(name)

    def emit_equipment_added(self, equipment):
        self.equipment_added.emit(equipment)

    def emit_equipment_removed(self, name: str):
        self.equipment_removed.emit(name)

    def request_save(self):
        self.save_requested.emit()

    def request_load(self):
        self.load_requested.emit()

    def request_new_character(self):
        self.new_character_requested.emit()
