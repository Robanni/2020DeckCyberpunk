from PySide6.QtCore import QAbstractListModel, Qt, QModelIndex, Signal, Slot, Property
from core.models.character import Cyberware
from desktop.controllers.character_controller import CharacterController


class CyberwareBridge(QAbstractListModel):
    NameRole = Qt.UserRole + 1
    DescriptionRole = Qt.UserRole + 2
    HumanityCostRole = Qt.UserRole + 3

    humanityChanged = Signal()

    def __init__(self, controller: CharacterController):
        super().__init__()
        self.controller = controller
        self._cyberware: list[Cyberware] = []
        self.refresh()

    def rowCount(self, parent=QModelIndex()):
        return len(self._cyberware)

    def data(self, index, role):
        if not index.isValid() or not (0 <= index.row() < len(self._cyberware)):
            return None

        item = self._cyberware[index.row()]
        try:
            if role == self.NameRole:
                return item.name
            elif role == self.DescriptionRole:
                return item.description
            elif role == self.HumanityCostRole:
                return item.humanity_cost
        except Exception as e:
            print(f"[CyberwareBridge] Error in data(): {e}")
        return None

    def roleNames(self):
        return {
            self.NameRole: b"name",
            self.DescriptionRole: b"description",
            self.HumanityCostRole: b"humanityCost"
        }

    @Slot(str, str, int)
    def addCyberware(self, name: str, description: str, humanity_cost: int):
        self.controller.add_cyberware(
            Cyberware(name=name, description=description, humanity_cost=humanity_cost)
        )
        self.refresh()

    @Slot(int)
    def removeCyberware(self, index: int):
        if 0 <= index < len(self._cyberware):
            name = self._cyberware[index].name
            self.controller.remove_cyberware(name)
            self.refresh()

    @Slot(int, str, str, int)
    def updateCyberware(self, index: int, name: str, description: str, humanity_cost: int):
        """Обновляет киберимплант по индексу"""
        if 0 <= index < len(self._cyberware):
            self.controller.update_cyberware(index, name, description, humanity_cost)
            self.refresh()


    def refresh(self):
        self.beginResetModel()
        self._cyberware = list(self.controller.character.cyberware)
        self.endResetModel()
        self.humanityChanged.emit()

    @Property(int, notify=humanityChanged)
    def currentHumanity(self):
        return self.controller.character.humanity
