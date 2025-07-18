from typing import Optional
from core.models.character import Character, Skill, Equipment, Cyberware, SkillGroup


class CharacterUseCase:
    def add_skill(
        self,
        character: Character,
        stat: str,
        group_title: str,
        name: str,
        level: int,
        skill_id: Optional[int] = None,
        description: str = "",
    ):
        """Добавляет или обновляет навык в группе по стату"""
        group = next((g for g in character.skills if g.stat == stat), None)

        if not group:
            group = SkillGroup(title=group_title, stat=stat)
            character.skills.append(group)

        existing = next((s for s in group.items if s.title == name), None)

        if existing:
            existing.level = level
            existing.description = description
        else:
            if skill_id is None:
                max_id = max((s.id for s in group.items), default=-1)
                skill_id = max_id + 1

            group.items.append(
                Skill(title=name, id=skill_id, level=level, description=description)
            )

    def remove_skill(self, character: Character, stat: str, name: str):
        """Удаляет навык из группы по стату"""
        for group in character.skills:
            if group.stat == stat:
                group.items = [s for s in group.items if s.title != name]
                break

    def update_skill_by_id(
        self,
        character: Character,
        stat: str,
        skill_id: int,
        title: str,
        level: int,
        description: str,
    ):
        """Обновляет навык по ID в указанной группе"""
        for group in character.skills:
            if group.stat == stat:
                for skill in group.items:
                    if skill.id == skill_id:
                        skill.title = title
                        skill.level = level
                        skill.description = description
                        return

    def add_cyberware(self, character: Character, cyberware: Cyberware):
        character.cyberware.append(cyberware)
        character.apply_cyberware_costs()

    def remove_cyberware(self, character: Character, implant_name: str):
        character.cyberware = [c for c in character.cyberware if c.name != implant_name]
        character.apply_cyberware_costs()

    def update_cyberware_by_index(
        self,
        character: Character,
        index: int,
        name: str,
        description: str,
        humanity_cost: int,
    ):
        """Обновляет киберимплант по индексу"""
        if 0 <= index < len(character.cyberware):
            character.cyberware[index].name = name
            character.cyberware[index].description = description
            character.cyberware[index].humanity_cost = humanity_cost
            character.apply_cyberware_costs()

    def add_equipment(self, character: Character, equipment: Equipment):
        character.equipment.append(equipment)

    def remove_equipment(self, character: Character, name: str):
        character.equipment = [e for e in character.equipment if e.name != name]

    def update_equipment_by_index(
        self,
        character: Character,
        index: int,
        equipment: Equipment,  
    ):
        """Обновляет снаряжение по индексу"""
        if 0 <= index < len(character.equipment):
            character.equipment[index] = equipment
