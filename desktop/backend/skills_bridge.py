from PySide6.QtCore import QAbstractListModel, Qt, QModelIndex, Signal, Property, Slot

from core.models.character import Skill
from desktop.controllers.character_controller import CharacterController


class SkillsBridge(QAbstractListModel):
    NameRole = Qt.UserRole + 1
    CategoryRole = Qt.UserRole + 2
    DescriptionRole = Qt.UserRole + 3
    LevelRole = Qt.UserRole + 4

    def __init__(self, controller: CharacterController):
        super().__init__()
        self.controller = controller
        self._skills: list[Skill] = controller.character.skills

    def rowCount(self, parent=QModelIndex()):
        return len(self._skills)

    def data(self, index, role):
        if not index.isValid():
            return None
        skill = self._skills[index.row()]
        if role == self.NameRole:
            return skill.name
        if role == self.CategoryRole:
            return skill.category
        if role == self.DescriptionRole:
            return skill.description
        if role == self.LevelRole:
            return skill.level
        return None

    def roleNames(self):
        return {
            self.NameRole: b"name",
            self.CategoryRole: b"category",
            self.DescriptionRole: b"description",
            self.LevelRole: b"level",
        }

    @Slot(str, str, str, int)
    def addSkill(self, name: str, category: str, description: str, level: int = 1):
        self.controller.add_skill(name, level, category, description)
        self.refresh()

    @Slot(int)
    def removeSkill(self, index: int):
        if 0 <= index < len(self._skills):
            name = self._skills[index].name
            self.controller.remove_skill(name)
            self.refresh()

    @Slot(int, str, str, str, int)
    def updateSkill(
        self, index: int, name: str, category: str, description: str, level: int
    ):
        self.controller.update_skill(index, name, level, category, description)
        self.refresh()

    def refresh(self):
        self.beginResetModel()
        self._skills = self.controller.character.skills
        self.endResetModel()
