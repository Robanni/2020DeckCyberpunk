from pydantic import BaseModel, Field
from typing import List, Optional


class CharacterStats(BaseModel):
    INT: int = Field(ge=1, le=10)
    REF: int = Field(ge=1, le=10)
    TECH: int = Field(ge=1, le=10)
    COOL: int = Field(ge=1, le=10)
    ATTR: int = Field(ge=1, le=10)
    LUCK: int = Field(ge=1, le=10)
    MA: int = Field(ge=1, le=10)
    BODY: int = Field(ge=1, le=10)
    EMP: int = Field(ge=1, le=10)

    def average(self) -> float:
        return sum(self.dict().values()) / len(self.dict())
    
    @classmethod
    def generate_default(cls) -> 'CharacterStats':
        return cls(INT=5, REF=5, TECH=5, COOL=5, ATTR=5, LUCK=5, MA=5, BODY=5, EMP=5)

class Health(BaseModel):
    current_damage: int = 0

class Skill(BaseModel):
    name: str
    category: Optional[str] = ""
    description: Optional[str] = ""
    level: int = Field(ge=0, le=15)


class Equipment(BaseModel):
    name: str
    type: str
    description: Optional[str] = ""


class Cyberware(BaseModel):
    name: str
    humanity_cost: int = Field(ge=0)
    description: Optional[str] = ""


class Lifepath(BaseModel):
    origin: str
    family: str
    motivation: str
    enemies: List[str] = []
    romance: Optional[str] = ""


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

    skills: List[Skill] = []
    equipment: List[Equipment] = []
    cyberware: List[Cyberware] = []
    lifepath: Lifepath

    humanity: int = 100
    reputation: int = 0
    money: int = 0
    notes: Optional[str] = ""

    def apply_cyberware_costs(self) -> None:
        self.humanity = max(
            0, 100 - sum(c.humanity_cost for c in self.cyberware))
    
    @classmethod
    def generate_default(cls) -> 'Character':
        """Создаёт персонажа с настройками по умолчанию"""
        return Character(
            name="Новый персонаж",
            role="Solo",
            stats=CharacterStats(**{stat: 5 for stat in CharacterStats.model_fields}),
            special_ability = "",
            health=Health(current_damage=0),
            armor=Armor(),
            lifepath=Lifepath(
                origin="",
                family="",
                motivation="",
                enemies=[],
                romance=None
            ),
            skills=[],
            equipment=[],
            cyberware=[],
            humanity=100,
            reputation=0,
            money=0,
            notes=""
        )
