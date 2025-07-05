from PySide6.QtCore import QObject, Property, Signal
from core.models.character import CharacterStats


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

    def __init__(self, stats: CharacterStats = CharacterStats.generate_default()):
        super().__init__()
        self._stats = stats

    def get_INT(self):
        return self._stats.INT

    def set_INT(self, value):
        if self._stats.INT != value:
            self._stats.INT = value
            self.intChanged.emit()

    INT = Property(int, get_INT, set_INT, None, "", notify=intChanged)

    def get_REF(self):
        return self._stats.REF

    def set_REF(self, value):
        if self._stats.REF != value:
            self._stats.REF = value
            self.refChanged.emit()

    REF = Property(int, get_REF, set_REF, None, "", notify=refChanged)

    def get_TECH(self):
        return self._stats.TECH

    def set_TECH(self, value):
        if self._stats.TECH != value:
            self._stats.TECH = value
            self.techChanged.emit()

    TECH = Property(int, get_TECH, set_TECH, None, "", notify=techChanged)

    def get_COOL(self):
        return self._stats.COOL

    def set_COOL(self, value):
        if self._stats.COOL != value:
            self._stats.COOL = value
            self.coolChanged.emit()

    COOL = Property(int, get_COOL, set_COOL, None, "", notify=coolChanged)

    def get_ATTR(self):
        return self._stats.ATTR

    def set_ATTR(self, value):
        if self._stats.ATTR != value:
            self._stats.ATTR = value
            self.attrChanged.emit()

    ATTR = Property(int, get_ATTR, set_ATTR, None, "", notify=attrChanged)

    def get_LUCK(self):
        return self._stats.LUCK

    def set_LUCK(self, value):
        if self._stats.LUCK != value:
            self._stats.LUCK = value
            self.luckChanged.emit()

    LUCK = Property(int, get_LUCK, set_LUCK, None, "", notify=luckChanged)

    def get_MA(self):
        return self._stats.MA

    def set_MA(self, value):
        if self._stats.MA != value:
            self._stats.MA = value
            self.maChanged.emit()

    MA = Property(int, get_MA, set_MA, None, "", notify=maChanged)

    def get_BODY(self):
        return self._stats.BODY

    def set_BODY(self, value):
        if self._stats.BODY != value:
            self._stats.BODY = value
            self.bodyChanged.emit()

    BODY = Property(int, get_BODY, set_BODY, None, "", notify=bodyChanged)

    def get_EMP(self):
        return self._stats.EMP

    def set_EMP(self, value):
        if self._stats.EMP != value:
            self._stats.EMP = value
            self.empChanged.emit()

    EMP = Property(int, get_EMP, set_EMP, None, "", notify=empChanged)
