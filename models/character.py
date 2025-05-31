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


class Skill(BaseModel):
    name: str
    level: int = Field(ge=1, le=10)


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


class Character(BaseModel):
    name: str
    handle: Optional[str] = ""  # "никнейм"
    role: str                   # Solo, Netrunner, Fixer и т.д.
    stats: CharacterStats
    special_ability: str

    skills: List[Skill] = []
    equipment: List[Equipment] = []
    cyberware: List[Cyberware] = []
    lifepath: Lifepath

    humanity: int = 100
    reputation: int = 0
    money: int = 0
    notes: Optional[str] = ""

    def apply_cyberware_costs(self) -> None:
        self.humanity = max(0, 100 - sum(c.humanity_cost for c in self.cyberware))
