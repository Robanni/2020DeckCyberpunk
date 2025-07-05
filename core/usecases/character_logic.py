from core.models.character import Character, Skill, Equipment, Cyberware


class CharacterUseCase:
    def add_skill(self, character: Character, name: str, level: int, category: str = "", description: str = ""):
        existing = next((s for s in character.skills if s.name == name), None)
        if existing:
            # Обновление существующего навыка
            existing.level = level
            existing.category = category
            existing.description = description
        else:
            character.skills.append(Skill(name=name, level=level, category=category, description=description))

    def remove_skill(self, character: Character, skill_name: str):
        character.skills = [s for s in character.skills if s.name != skill_name]

    def update_skill_by_index(self, character: Character, index: int, name: str, level: int, category: str, description: str):
        if 0 <= index < len(character.skills):
            character.skills[index] = Skill(name=name, level=level, category=category, description=description)


    def add_cyberware(self, character: Character, cyberware: Cyberware):
        character.cyberware.append(cyberware)
        character.apply_cyberware_costs()

    def remove_cyberware(self, character: Character, implant_name: str):
        character.cyberware = [c for c in character.cyberware if c.name != implant_name]
        character.apply_cyberware_costs()

    def add_equipment(self, character: Character, equipment: Equipment):
        character.equipment.append(equipment)

    def remove_equipment(self, character: Character, name: str):
        character.equipment = [e for e in character.equipment if e.name != name]
