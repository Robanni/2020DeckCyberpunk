from PySide6.QtCore import QObject, Property, Signal
from desktop.controllers.character_controller import CharacterController


class StatsBridge(QObject):
    intChanged = Signal()
    refChanged = Signal()
    techChanged = Signal()
    coolChanged = Signal()
    attrChanged = Signal()
    luckChanged = Signal()
    maChanged = Signal()
    bodyChanged = Signal()
    empChanged = Signal()

    def __init__(self, controller: CharacterController):
        super().__init__()
        self._controller = controller

    def update(self):
        self.intChanged.emit()
        self.refChanged.emit()
        self.techChanged.emit()
        self.coolChanged.emit()
        self.attrChanged.emit()
        self.luckChanged.emit()
        self.maChanged.emit()
        self.bodyChanged.emit()
        self.empChanged.emit()

    def get_INT(self):
        return self._controller.character.stats.INT

    def set_INT(self, value):
        if self._controller.character.stats.INT != value:
            self._controller.character.stats.INT = value
            self.intChanged.emit()

    def get_REF(self):
        return self._controller.character.stats.REF

    def set_REF(self, value):
        if self._controller.character.stats.REF != value:
            self._controller.character.stats.REF = value
            self.refChanged.emit()

    def get_TECH(self):
        return self._controller.character.stats.TECH

    def set_TECH(self, value):
        if self._controller.character.stats.TECH != value:
            self._controller.character.stats.TECH = value
            self.techChanged.emit()

    def get_COOL(self):
        return self._controller.character.stats.COOL

    def set_COOL(self, value):
        if self._controller.character.stats.COOL != value:
            self._controller.character.stats.COOL = value
            self.coolChanged.emit()

    def get_ATTR(self):
        return self._controller.character.stats.ATTR

    def set_ATTR(self, value):
        if self._controller.character.stats.ATTR != value:
            self._controller.character.stats.ATTR = value
            self.attrChanged.emit()

    def get_LUCK(self):
        return self._controller.character.stats.LUCK

    def set_LUCK(self, value):
        if self._controller.character.stats.LUCK != value:
            self._controller.character.stats.LUCK = value
            self.luckChanged.emit()

    def get_MA(self):
        return self._controller.character.stats.MA

    def set_MA(self, value):
        if self._controller.character.stats.MA != value:
            self._controller.character.stats.MA = value
            self.maChanged.emit()

    def get_BODY(self):
        return self._controller.character.stats.BODY

    def set_BODY(self, value):
        if self._controller.character.stats.BODY != value:
            self._controller.character.stats.BODY = value
            self.bodyChanged.emit()

    def get_EMP(self):
        return self._controller.character.stats.EMP

    def set_EMP(self, value):
        if self._controller.character.stats.EMP != value:
            self._controller.character.stats.EMP = value
            self.empChanged.emit()


    INT = Property(int, get_INT, set_INT, notify=intChanged)
    REF = Property(int, get_REF, set_REF, notify=refChanged)
    TECH = Property(int, get_TECH, set_TECH, notify=techChanged)
    COOL = Property(int, get_COOL, set_COOL, notify=coolChanged)
    ATTR = Property(int, get_ATTR, set_ATTR, notify=attrChanged)
    LUCK = Property(int, get_LUCK, set_LUCK, notify=luckChanged)
    MA = Property(int, get_MA, set_MA, notify=maChanged)
    BODY = Property(int, get_BODY, set_BODY, notify=bodyChanged)
    EMP = Property(int, get_EMP, set_EMP, notify=empChanged)
