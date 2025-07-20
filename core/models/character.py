from pydantic import BaseModel, Field
from typing import List, Optional


class CharacterStats(BaseModel):
    INT: int = Field(ge=1, le=20)
    REF: int = Field(ge=1, le=20)
    TECH: int = Field(ge=1, le=20)
    COOL: int = Field(ge=1, le=20)
    ATTR: int = Field(ge=1, le=20)
    LUCK: int = Field(ge=1, le=20)
    MA: int = Field(ge=1, le=20)
    BODY: int = Field(ge=1, le=20)
    EMP: int = Field(ge=1, le=20)

    def average(self) -> float:
        return sum(self.dict().values()) / len(self.dict())
    
    @classmethod
    def generate_default(cls) -> 'CharacterStats':
        return cls(**{k: 5 for k in cls.__annotations__})

class Health(BaseModel):
    current_damage: int = 0

class Skill(BaseModel):
    title: str
    id: int
    level: int = Field(ge=0, le=15)
    description: Optional[str] = ""

class SkillGroup(BaseModel):
    title: str           
    stat: str           
    items: List[Skill] = [] 


class Equipment(BaseModel):
    name: str
    description: Optional[str] = ""
    weight: Optional[float] = 0.0
    price: Optional[float] = 0.0
    amount: Optional[int] = 1


class Cyberware(BaseModel):
    name: str
    humanity_cost: int = Field(ge=0)
    description: Optional[str] = ""


class Motivation(BaseModel):
    personality_traits: str
    person_you_value_most: str
    what_do_you_value_most: str
    how_do_you_feel_about_most_people: str
    your_most_valued_possession: str


class FamilyMember(BaseModel):
    name: str
    relationship: str
    relationship_notes: Optional[str] = ""
    age: int


class Enemy(BaseModel):
    name: str
    info: str


class Friend(BaseModel):
    name: str
    relationship_notes: Optional[str] = ""
    info: str


class Romance(BaseModel):
    name: str
    info: str


class LifeEvent(BaseModel):
    age: str
    event: str


class Lifepath(BaseModel):
    ethnic_background: Optional[str] = ""
    origin: str
    family_history: Optional[str] = ""
    motivation: Motivation
    family: List[FamilyMember] = []
    enemies: List[Enemy] = []
    friendship: List[Friend] = []
    romance: Optional[Romance]
    life_events: List[LifeEvent] = []


class Armor(BaseModel):
    head: int = 0  
    body: int = 0  
    left_arm: int = 0  
    right_arm: int = 0  
    left_leg: int = 0  
    right_leg: int = 0  



class Character(BaseModel):
    name: str
    handle: Optional[str] = ""
    role: str
    stats: CharacterStats
    special_ability: str
    health: Health
    armor: Armor
    skills: List[SkillGroup] = []
    equipment: List[Equipment] = []
    cyberware: List[Cyberware] = []
    lifepath: Lifepath
    humanity: int = 100
    reputation: int = 0
    money: int = 0
    style: Optional[str] = ""
    notes: Optional[str] = ""

    def apply_cyberware_costs(self) -> None:
        self.humanity = max(
            0, self.stats.EMP * 10 - sum(c.humanity_cost for c in self.cyberware)
        )

    @classmethod
    def generate_default(cls) -> 'Character':
        return cls(
            name="Новый персонаж",
            role="Solo",
            stats=CharacterStats.generate_default(),
            special_ability="",
            health=Health(),
            armor=Armor(),
            lifepath=Lifepath(
                origin="Unknown",
                motivation=Motivation(
                    personality_traits="",
                    person_you_value_most="",
                    what_do_you_value_most="",
                    how_do_you_feel_about_most_people="",
                    your_most_valued_possession=""
                )
            ),
        )