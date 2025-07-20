from PySide6.QtCore import QObject, Property, Signal
from core.models.character import Motivation
from desktop.controllers.character_controller import CharacterController


class MotivationBridge(QObject):
    personalityTraitsChanged = Signal()
    personYouValueMostChanged = Signal()
    whatDoYouValueMostChanged = Signal()
    howDoYouFeelAboutMostPeopleChanged = Signal()
    mostValuedPossessionChanged = Signal()

    def __init__(self, controller: CharacterController):
        super().__init__()
        self.controller = controller
        self._motivation = self.controller.character.lifepath.motivation

    def get_traits(self):
        return self._motivation.personality_traits

    def set_traits(self, val):
        if self._motivation.personality_traits != val:
            self._motivation.personality_traits = val
            self.personalityTraitsChanged.emit()

    personalityTraits = Property(
        str, get_traits, set_traits, notify=personalityTraitsChanged
    )

    def get_person(self):
        return self._motivation.person_you_value_most

    def set_person(self, val):
        if self._motivation.person_you_value_most != val:
            self._motivation.person_you_value_most = val
            self.personYouValueMostChanged.emit()

    personYouValueMost = Property(
        str, get_person, set_person, notify=personYouValueMostChanged
    )

    def get_what(self):
        return self._motivation.what_do_you_value_most

    def set_what(self, val):
        if self._motivation.what_do_you_value_most != val:
            self._motivation.what_do_you_value_most = val
            self.whatDoYouValueMostChanged.emit()

    whatDoYouValueMost = Property(
        str, get_what, set_what, notify=whatDoYouValueMostChanged
    )

    def get_feeling(self):
        return self._motivation.how_do_you_feel_about_most_people

    def set_feeling(self, val):
        if self._motivation.how_do_you_feel_about_most_people != val:
            self._motivation.how_do_you_feel_about_most_people = val
            self.howDoYouFeelAboutMostPeopleChanged.emit()

    howDoYouFeelAboutMostPeople = Property(
        str, get_feeling, set_feeling, notify=howDoYouFeelAboutMostPeopleChanged
    )

    def get_item(self):
        return self._motivation.your_most_valued_possession

    def set_item(self, val):
        if self._motivation.your_most_valued_possession != val:
            self._motivation.your_most_valued_possession = val
            self.mostValuedPossessionChanged.emit()

    mostValuedPossession = Property(
        str, get_item, set_item, notify=mostValuedPossessionChanged
    )