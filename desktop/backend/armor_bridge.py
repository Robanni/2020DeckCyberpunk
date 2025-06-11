from PySide6.QtCore import QObject, Property, Signal
from core.models.character import Armor

class ArmorBridge(QObject):
    headChanged = Signal()
    bodyChanged = Signal()
    leftArmChanged = Signal()
    rightArmChanged = Signal()
    leftLegChanged = Signal()
    rightLegChanged = Signal()

    def __init__(self, armor: Armor):
        super().__init__()
        self._armor = armor

    def get_head_armor(self): return self._armor.head
    def set_head_armor(self, value: int):
        if self._armor.head != value:
            self._armor.head = value
            self.headChanged.emit()
    head = Property(int, get_head_armor, set_head_armor, None, "", notify=headChanged)

    def get_body_armor(self): return self._armor.body
    def set_body_armor(self, value: int):
        if self._armor.body != value:
            self._armor.body = value
            self.bodyChanged.emit()
    body = Property(int, get_body_armor, set_body_armor, None, "", notify=bodyChanged)

    def get_left_arm_armor(self): return self._armor.left_arm
    def set_left_arm_armor(self, value: int):
        if self._armor.left_arm != value:
            self._armor.left_arm = value
            self.leftArmChanged.emit()
    leftArm = Property(int, get_left_arm_armor, set_left_arm_armor, None, "", notify=leftArmChanged)

    def get_right_arm_armor(self): return self._armor.right_arm
    def set_right_arm_armor(self, value: int):
        if self._armor.right_arm != value:
            self._armor.right_arm = value
            self.rightArmChanged.emit()
    rightArm = Property(int, get_right_arm_armor, set_right_arm_armor, None, "", notify=rightArmChanged)

    def get_left_leg_armor(self): return self._armor.left_leg
    def set_left_leg_armor(self, value: int):
        if self._armor.left_leg != value:
            self._armor.left_leg = value
            self.leftLegChanged.emit()
    leftLeg = Property(int, get_left_leg_armor, set_left_leg_armor, None, "", notify=leftLegChanged)

    def get_right_leg_armor(self): return self._armor.right_leg
    def set_right_leg_armor(self, value: int):
        if self._armor.right_leg != value:
            self._armor.right_leg = value
            self.rightLegChanged.emit()
    rightLeg = Property(int, get_right_leg_armor, set_right_leg_armor, None, "", notify=rightLegChanged)

