from core.models.character import Armor, Character, CharacterStats, Health, Skill, Equipment, Cyberware, Lifepath

# Создаем персонажа Johnny Silverhand
johnny = Character(
    name="Johnny Silverhand",
    handle="Samurai",
    role="Rockerboy",
    stats=CharacterStats(
        INT=8,
        REF=9,
        TECH=7,
        COOL=10,
        ATTR=9,
        LUCK=6,
        MA=8,
        BODY=7,
        EMP=4  # Низкая эмпатия из-за кибернетики
    ),
    health=Health(current_damage=0),
    armor=Armor(),
    special_ability="Charismatic Leadership",
    skills=[
        Skill(name="Pistol", level=10),
        Skill(name="Composition", level=9),
        Skill(name="Performance", level=10),
        Skill(name="Persuasion", level=8),
        Skill(name="Streetwise", level=9)
    ],
    equipment=[
        Equipment(
            name="Malorian Arms 3516",
            type="Power Handgun",
            description="Custom .50 caliber handgun. 'The only gun that'll shoot through a tank'"
        ),
        Equipment(
            name="Armored Rockerjacket",
            type="Light Armor Jacket",
            description="SP 10, looks like a classic rocker jacket"
        ),
        Equipment(
            name="Guitar Case",
            type="Container",
            description="Holds guitar and ammo"
        )
    ],
    cyberware=[
        Cyberware(
            name="Silverhand Cyberarm",
            humanity_cost=14,
            description="Chrome-plated cybernetic left arm with reinforced strength"
        ),
        Cyberware(
            name="Subdermal Grip",
            humanity_cost=3,
            description="Palm-mounted grip implant for weapon stability"
        ),
        Cyberware(
            name="AudioVox Enhancer",
            humanity_cost=5,
            description="Vocal cord enhancement for performances"
        )
    ],
    lifepath=Lifepath(
        origin="Military Brat",
        family="Both parents deceased (Militech conflict)",
        motivation="Fight corporate oppression",
        enemies=["Adam Smasher", "Arasaka Corp", "Militech Execs"],
        romance="Alt Cunningham (deceased)"
    ),
    humanity=100 - (14 + 3 + 5),  # 78 humanity
    reputation=9,  # Legendary status
    money=2500,  # Not rich but gets by
    notes="Former frontman of SAMURAI. Lost left arm in 2023 Arasaka Tower raid. Hates corporations with a passion."
)

# Применяем эффекты кибернетики
johnny.apply_cyberware_costs()
