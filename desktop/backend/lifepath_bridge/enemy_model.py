from PySide6.QtCore import Property, QAbstractListModel, Qt, QModelIndex, Signal, Slot
from core.models.character import Enemy
from desktop.controllers.character_controller import CharacterController



class EnemyModel(QAbstractListModel):
    NameRole = Qt.UserRole + 1
    InfoRole = Qt.UserRole + 2

    countChanged = Signal()

    def __init__(self, controller: CharacterController):
        super().__init__()
        self.controller = controller
        self._enemies = self.controller.character.lifepath.enemies

    def rowCount(self, parent=QModelIndex()):
        return len(self._enemies)

    @Property(int, notify=countChanged)
    def count(self):
        return len(self._enemies)

    def data(self, index, role):
        if not index.isValid():
            return None
        enemy = self._enemies[index.row()]
        if role == self.NameRole:
            return enemy.name
        elif role == self.InfoRole:
            return enemy.info
        return None

    def roleNames(self):
        return {
            self.NameRole: b"name",
            self.InfoRole: b"info",
        }

    @Slot(str, str)
    def addEnemy(self, name: str, info: str):
        self.beginInsertRows(QModelIndex(), len(self._enemies), len(self._enemies))
        self._enemies.append(Enemy(name=name, info=info))
        self.endInsertRows()
        self.countChanged.emit()

    @Slot(int)
    def removeEnemy(self, index: int):
        if 0 <= index < len(self._enemies):
            self.beginRemoveRows(QModelIndex(), index, index)
            del self._enemies[index]
            self.endRemoveRows()
            self.countChanged.emit()

    @Slot(int, str, str)
    def updateEnemy(self, index: int, name: str, info: str):
        if 0 <= index < len(self._enemies):
            enemy = self._enemies[index]
            enemy.name = name
            enemy.info = info
            self.dataChanged.emit(self.index(index), self.index(index))