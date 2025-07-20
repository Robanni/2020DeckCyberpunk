from PySide6.QtCore import QAbstractListModel, Qt, QModelIndex, Signal, Slot, Property
from core.models.character import FamilyMember
from desktop.controllers.character_controller import CharacterController



class FamilyModel(QAbstractListModel):
    NameRole = Qt.UserRole + 1
    RelationshipRole = Qt.UserRole + 2
    NotesRole = Qt.UserRole + 3
    AgeRole = Qt.UserRole + 4

    countChanged = Signal()

    def __init__(self, controller: CharacterController):
        super().__init__()
        self.controller = controller
        self._family = self.controller.character.lifepath.family

    def rowCount(self, parent=QModelIndex()):
        return len(self._family)
    
    @Property(int, notify=countChanged)
    def count(self):
        return len(self._family)

    def data(self, index, role):
        if not index.isValid():
            return None
        member = self._family[index.row()]
        if role == self.NameRole:
            return member.name
        elif role == self.RelationshipRole:
            return member.relationship
        elif role == self.NotesRole:
            return member.relationship_notes
        elif role == self.AgeRole:
            return member.age
        return None

    def roleNames(self):
        return {
            self.NameRole: b"name",
            self.RelationshipRole: b"relationship",
            self.NotesRole: b"relationshipNotes",
            self.AgeRole: b"age"
        }

    @Slot(str, str, str, int)
    def addFamilyMember(self, name: str, relationship: str, notes: str, age: int):
        self.beginInsertRows(QModelIndex(), len(self._family), len(self._family))
        self._family.append(FamilyMember(name=name, relationship=relationship, relationship_notes=notes, age=age))
        self.endInsertRows()
        self.countChanged.emit()

    @Slot(int)
    def removeFamilyMember(self, index: int):
        if 0 <= index < len(self._family):
            self.beginRemoveRows(QModelIndex(), index, index)
            del self._family[index]
            self.endRemoveRows()
            self.countChanged.emit()

    @Slot(int, str, str, str, int)
    def updateFamilyMember(self, index: int, name: str, relationship: str, notes: str, age: int):
        if 0 <= index < len(self._family):
            member = self._family[index]
            member.name = name
            member.relationship = relationship
            member.relationship_notes = notes
            member.age = age
            self.dataChanged.emit(self.index(index), self.index(index))

