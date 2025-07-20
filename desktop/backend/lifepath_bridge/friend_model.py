from PySide6.QtCore import Property, QAbstractListModel, Qt, QModelIndex, Signal, Slot
from core.models.character import Friend
from desktop.controllers.character_controller import CharacterController



class FriendModel(QAbstractListModel):
    NameRole = Qt.UserRole + 1
    InfoRole = Qt.UserRole + 2
    NotesRole = Qt.UserRole + 3

    countChanged = Signal()

    def __init__(self, controller: CharacterController):
        super().__init__()
        self.controller = controller
        self._friends = self.controller.character.lifepath.friendship

    def rowCount(self, parent=QModelIndex()):
        return len(self._friends)

    @Property(int, notify=countChanged)
    def count(self):
        return len(self._friends)

    def data(self, index, role):
        if not index.isValid():
            return None
        friend = self._friends[index.row()]
        if role == self.NameRole:
            return friend.name
        elif role == self.InfoRole:
            return friend.info
        elif role == self.NotesRole:
            return friend.relationship_notes
        return None

    def roleNames(self):
        return {
            self.NameRole: b"name",
            self.InfoRole: b"info",
            self.NotesRole: b"relationshipNotes",
        }

    @Slot(str, str, str)
    def addFriend(self, name: str, info: str, notes: str):
        self.beginInsertRows(QModelIndex(), len(self._friends), len(self._friends))
        self._friends.append(Friend(name=name, info=info, relationship_notes=notes))
        self.endInsertRows()
        self.countChanged.emit()

    @Slot(int)
    def removeFriend(self, index: int):
        if 0 <= index < len(self._friends):
            self.beginRemoveRows(QModelIndex(), index, index)
            del self._friends[index]
            self.endRemoveRows()
            self.countChanged.emit()

    @Slot(int, str, str, str)
    def updateFriend(self, index: int, name: str, info: str, notes: str):
        if 0 <= index < len(self._friends):
            friend = self._friends[index]
            friend.name = name
            friend.info = info
            friend.relationship_notes = notes
            self.dataChanged.emit(self.index(index), self.index(index))
