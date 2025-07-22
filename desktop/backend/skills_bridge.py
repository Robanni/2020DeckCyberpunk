from PySide6.QtCore import QAbstractListModel, Qt, QModelIndex, Signal, Property, Slot

from core.models.character import Skill
from desktop.controllers.character_controller import CharacterController


class SkillsBridge(QAbstractListModel):
    NameRole = Qt.UserRole + 1
    CategoryRole = Qt.UserRole + 2
    DescriptionRole = Qt.UserRole + 3
    LevelRole = Qt.UserRole + 4
    IdRole = Qt.UserRole + 5


    def __init__(self, controller: CharacterController):
        super().__init__()
        self.controller = controller
        self._flat_skills: list[tuple[str, Skill]] = [] 
        self.refresh()

    def update(self):
        self.refresh()

    def rowCount(self, parent=QModelIndex()):
        return len(self._flat_skills)

    def data(self, index, role):
        if not index.isValid() or not (0 <= index.row() < len(self._flat_skills)):
            return None

        stat, skill = self._flat_skills[index.row()]
        try:
            if role == self.NameRole:
                return skill.title
            elif role == self.CategoryRole:
                return stat
            elif role == self.DescriptionRole:
                return skill.description
            elif role == self.LevelRole:
                return skill.level
            elif role == self.IdRole:
                return skill.id
        except Exception as e:
            print(f"[SkillsBridge] Error in data(): {e}")
        return None
    
    def roleNames(self):
        return {
            self.NameRole: b"name",
            self.CategoryRole: b"category",
            self.DescriptionRole: b"description",
            self.LevelRole: b"level",
            self.IdRole: b"skillId",
        }

    @Slot(str, str, str, int)
    def addSkill(self, name: str, category: str, description: str, level: int = 1):
        """Добавляет навык, категория == stat"""
        self.controller.add_skill(stat=category, group_title=category, name=name, level=level, description=description)
        self.refresh()


    @Slot(int)
    def removeSkill(self, skill_id: int):
        for stat, skill in self._flat_skills:
            if skill.id == skill_id:
                self.controller.remove_skill(stat=stat, name=skill.title)
                self.refresh()
                return

    @Slot(int, str, str, str, int)
    def updateSkill(self, index: int, title: str, category: str, description: str, level: int):
        """Обновляет навык по индексу (с сохранением ID)"""
        if 0 <= index < len(self._flat_skills):
            stat, old_skill = self._flat_skills[index]
            self.controller.update_skill(
                skill_id=index,
                title=title,
                level=level,
                stat=category,
                description=description,
            )
            self.refresh()

    def refresh(self):
        """Обновляет плоский список навыков"""
        self.beginResetModel()
        self._flat_skills = []
        for group in self.controller.character.skills:
            for skill in group.items:
                self._flat_skills.append((group.stat, skill))
        self.endResetModel()
