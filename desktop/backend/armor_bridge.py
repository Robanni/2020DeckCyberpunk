from PySide6.QtCore import QObject, Property, Signal
from core.models.character import Armor
from desktop.controllers.character_controller import CharacterController



class ArmorBridge(QObject):
    headChanged = Signal()
    bodyChanged = Signal()
    leftArmChanged = Signal()
    rightArmChanged = Signal()
    leftLegChanged = Signal()
    rightLegChanged = Signal()

    def __init__(self, controller: CharacterController):
        super().__init__()
        self._controller = controller

    def update(self):
        self.headChanged.emit()
        self.bodyChanged.emit()
        self.leftArmChanged.emit()
        self.rightArmChanged.emit()
        self.leftLegChanged.emit()
        self.rightLegChanged.emit()

    def get_head(self):
        return self._controller.character.armor.head

    def set_head(self, value):
        if self._controller.character.armor.head != value:
            self._controller.character.armor.head = value
            self.headChanged.emit()

    def get_body(self):
        return self._controller.character.armor.body

    def set_body(self, value):
        if self._controller.character.armor.body != value:
            self._controller.character.armor.body = value
            self.bodyChanged.emit()

    def get_leftArm(self):
        return self._controller.character.armor.left_arm

    def set_leftArm(self, value):
        if self._controller.character.armor.left_arm != value:
            self._controller.character.armor.left_arm = value
            self.leftArmChanged.emit()

    def get_rightArm(self):
        return self._controller.character.armor.right_arm

    def set_rightArm(self, value):
        if self._controller.character.armor.right_arm != value:
            self._controller.character.armor.right_arm = value
            self.rightArmChanged.emit()

    def get_leftLeg(self):
        return self._controller.character.armor.left_leg

    def set_leftLeg(self, value):
        if self._controller.character.armor.left_leg != value:
            self._controller.character.armor.left_leg = value
            self.leftLegChanged.emit()

    def get_rightLeg(self):
        return self._controller.character.armor.right_leg

    def set_rightLeg(self, value):
        if self._controller.character.armor.right_leg != value:
            self._controller.character.armor.right_leg = value
            self.rightLegChanged.emit()

    head = Property(int, get_head, set_head, notify=headChanged)
    body = Property(int, get_body, set_body, notify=bodyChanged)
    leftArm = Property(int, get_leftArm, set_leftArm, notify=leftArmChanged)
    rightArm = Property(int, get_rightArm, set_rightArm, notify=rightArmChanged)
    leftLeg = Property(int, get_leftLeg, set_leftLeg, notify=leftLegChanged)
    rightLeg = Property(int, get_rightLeg, set_rightLeg, notify=rightLegChanged)