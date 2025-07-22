from PySide6.QtCore import QAbstractListModel, Qt, QModelIndex, Signal, Slot, Property
from core.models.character import Equipment
from desktop.controllers.character_controller import CharacterController


class EquipmentBridge(QAbstractListModel):
    NameRole = Qt.UserRole + 1
    DescriptionRole = Qt.UserRole + 2
    WeightRole = Qt.UserRole + 3
    PriceRole = Qt.UserRole + 4
    AmountRole = Qt.UserRole + 5

    countChanged = Signal()


    def __init__(self, controller: CharacterController):
        super().__init__()
        self.controller = controller
        self._equipment: list[Equipment] = []
        self.refresh()

    def update(self):
        self.beginResetModel()
        self._equipment = list(self.controller.character.equipment)
        self.endResetModel()
        self.countChanged.emit()

    @Property(int, notify=countChanged)
    def count(self):
        return len(self._equipment)
    
    def rowCount(self, parent=QModelIndex()):
        return len(self._equipment)

    def data(self, index, role):
        if not index.isValid() or not (0 <= index.row() < len(self._equipment)):
            return None

        item = self._equipment[index.row()]
        try:
            if role == self.NameRole:
                return item.name
            elif role == self.DescriptionRole:
                return item.description
            elif role == self.WeightRole:
                return item.weight
            elif role == self.PriceRole:
                return item.price
            elif role == self.AmountRole:
                return item.amount
        except Exception as e:
            print(f"[EquipmentBridge] Error in data(): {e}")
        return None

    def roleNames(self):
        return {
            self.NameRole: b"name",
            self.DescriptionRole: b"description",
            self.WeightRole: b"weight",
            self.PriceRole: b"price",
            self.AmountRole: b"amount"
        }

    @Slot(str, str, float, float, int)
    def addEquipment(self, name: str, description: str, weight: float, price: float, amount: int):
        self.controller.add_equipment(
            Equipment(
                name=name,
                description=description,
                weight=weight,
                price=price,
                amount=amount
            )
        )
        self.refresh()

    @Slot(int)
    def removeEquipment(self, index: int):
        if 0 <= index < len(self._equipment):
            name = self._equipment[index].name
            self.controller.remove_equipment(name)
            self.refresh()
            

    @Slot(int, str, str, float, float, int)
    def updateEquipment(self, index: int, name: str, description: str, weight: float, price: float, amount: int):
        if 0 <= index < len(self._equipment):
            self.controller.update_equipment(
                index,
                Equipment(
                    name=name,
                    description=description,
                    weight=weight,
                    price=price,
                    amount=amount
                )
            )
            self.refresh()

    def refresh(self):
        self.beginResetModel()
        self._equipment = list(self.controller.character.equipment)
        self.endResetModel()
        self.countChanged.emit()