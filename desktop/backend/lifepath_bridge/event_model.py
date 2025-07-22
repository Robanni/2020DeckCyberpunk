from PySide6.QtCore import Property, QAbstractListModel, Qt, QModelIndex, Signal, Slot
from core.models.character import LifeEvent
from desktop.controllers.character_controller import CharacterController



class LifeEventModel(QAbstractListModel):
    AgeRole = Qt.UserRole + 1
    EventRole = Qt.UserRole + 2

    countChanged = Signal()

    def __init__(self, controller: CharacterController):
        super().__init__()
        self.controller = controller
        self._events = self.controller.character.lifepath.life_events

    def update(self):
        self.beginResetModel()
        self._events = self.controller.character.lifepath.life_events
        self.endResetModel()
        self.countChanged.emit()

    def rowCount(self, parent=QModelIndex()):
        return len(self._events)
    
    @Property(int, notify=countChanged)
    def count(self):
        return len(self._events)

    def data(self, index, role):
        if not index.isValid():
            return None
        event = self._events[index.row()]
        if role == self.AgeRole:
            return event.age
        elif role == self.EventRole:
            return event.event
        return None

    def roleNames(self):
        return {
            self.AgeRole: b"age",
            self.EventRole: b"event",
        }

    @Slot(str, str)
    def addEvent(self, age: str, event_text: str):
        self.beginInsertRows(QModelIndex(), len(self._events), len(self._events))
        self._events.append(LifeEvent(age=age, event=event_text))
        self.endInsertRows()
        self.countChanged.emit()

    @Slot(int)
    def removeEvent(self, index: int):
        if 0 <= index < len(self._events):
            self.beginRemoveRows(QModelIndex(), index, index)
            del self._events[index]
            self.endRemoveRows()
            self.countChanged.emit()

    @Slot(int, str, str)
    def updateEvent(self, index: int, age: str, event_text: str):
        if 0 <= index < len(self._events):
            evt = self._events[index]
            evt.age = age
            evt.event = event_text
            self.dataChanged.emit(self.index(index), self.index(index))