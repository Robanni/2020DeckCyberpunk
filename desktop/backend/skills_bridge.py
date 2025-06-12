from PySide6.QtCore import QAbstractListModel, Qt, QModelIndex, Signal, Property, Slot

from core.models.character import Skill


class SkillsBridge(QAbstractListModel):
    NameRole = Qt.UserRole + 1
    CategoryRole = Qt.UserRole + 2
    DescriptionRole = Qt.UserRole + 3
    LevelRole = Qt.UserRole + 4

    def __init__(self, skills: list[Skill]):
        super().__init__()
        self._skills: list[Skill] = skills

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
            self.NameRole: b'name',
            self.CategoryRole: b'category',
            self.DescriptionRole: b'description',
            self.LevelRole: b'level',
        }

    @Slot(str, str, str, int)
    def addSkill(self, name: str, category: str, description: str, level: int = 1):
        self.beginInsertRows(QModelIndex(), len(
            self._skills), len(self._skills))
        self._skills.append(
            Skill(name=name, category=category, description=description, level=level))
        self.endInsertRows()

    @Slot(int)
    def removeSkill(self, index: int):
        if 0 <= index < len(self._skills):
            self.beginRemoveRows(QModelIndex(), index, index)
            self._skills.pop(index)
            self.endRemoveRows()

    @Slot(int, str, str, str, int)
    def updateSkill(self, index: int, name: str, category: str, description: str, level: int):
        if 0 <= index < len(self._skills):
            self._skills[index] = Skill(
                name=name, category=category, description=description, level=level)
            self.dataChanged.emit(self.index(index), self.index(index))
