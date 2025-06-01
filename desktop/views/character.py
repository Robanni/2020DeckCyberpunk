# desktop/views/character.py
from PySide6.QtGui import QFont
from PySide6.QtWidgets import (
    QFrame, QHBoxLayout, QLayout, QPushButton, QWidget, QTabWidget, QFormLayout, QLineEdit, QSpinBox, QTextEdit,
    QListWidget, QListWidgetItem, QTableWidget, QTableWidgetItem,
    QVBoxLayout, QLabel, QGroupBox, QGridLayout, QComboBox, QMessageBox
)
from PySide6.QtCore import Qt, Signal
from core.models.character import Armor, BodyPart, Character, CharacterStats, Skill, Equipment, Cyberware, Lifepath
from desktop.views.equipment_dialog import EquipmentDialog


class CharacterView(QWidget):
    character_updated = Signal(Character)
    skill_updated = Signal(str, int)
    cyberware_added = Signal(Cyberware)
    cyberware_removed = Signal(str)
    equipment_added = Signal(Equipment)
    equipment_removed = Signal(str)
    save_requested = Signal()
    load_requested = Signal()
    new_character_requested = Signal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setup_ui()

    def setup_ui(self):
        self.main_layout = QVBoxLayout()
        self.tabs = QTabWidget()
        self.main_layout.addWidget(self.tabs)
        self.setLayout(self.main_layout)

        # Создаем вкладки
        self.create_basic_info_tab()
        self.create_armor_tab()
        self.create_stats_block()
        self.create_skills_tab()
        self.create_cybernetics_tab()
        self.create_equipment_tab()
        self.create_lifepath_tab()
        self.create_other_info_tab()

        # Кнопки управления внизу
        self._setup_control_buttons()

        self.save_btn.clicked.connect(self.save_requested)
        self.load_btn.clicked.connect(self.load_requested)
        self.new_btn.clicked.connect(self.new_character_requested)

    def _setup_control_buttons(self):
        """Панель кнопок управления внизу"""
        btn_layout = QHBoxLayout()

        self.save_btn = QPushButton("Сохранить")
        self.load_btn = QPushButton("Загрузить")
        self.new_btn = QPushButton("Новый")

        btn_layout.addWidget(self.new_btn)
        btn_layout.addWidget(self.load_btn)
        btn_layout.addWidget(self.save_btn)
        btn_layout.addStretch()

        self.main_layout.addLayout(btn_layout)

    def create_basic_info_tab(self):
        tab = QWidget()
        layout = QFormLayout()

        self.name_edit = QLineEdit()
        self.handle_edit = QLineEdit()
        self.role_combo = QComboBox()
        self.role_combo.addItems(
            ["Solo", "Netrunner", "Fixer", "Techie", "Rockerboy", "Medtech"])
        self.special_ability_edit = QLineEdit()

        layout.addRow("Имя", self.name_edit)
        layout.addRow("Кличка", self.handle_edit)
        layout.addRow("Роль", self.role_combo)
        layout.addRow("Классовый Навык", self.special_ability_edit)

        # Connect signals
        self.name_edit.textChanged.connect(self.emit_character_update)
        self.handle_edit.textChanged.connect(self.emit_character_update)
        self.role_combo.currentTextChanged.connect(self.emit_character_update)
        self.special_ability_edit.textChanged.connect(
            self.emit_character_update)

        tab.setLayout(layout)
        self.tabs.addTab(tab, "Базовая Информация")

    def create_stats_block(self):
        tab = self.tabs.widget(0) if self.tabs.count() > 0 else QWidget()
        layout = tab.layout() if tab.layout() else QFormLayout()

        # Создаем группу для статов
        stats_group = QGroupBox("Статы")
        stats_layout = QGridLayout()

        self.stat_widgets = {}
        stats = [
            ("ИНТ (Интеллект)", "INT"),
            ("РЕФ (Рефлексы)", "REF"),
            ("ТЕХ (Техника)", "TECH"),
            ("КУЛ (Хладнокровие)", "COOL"),
            ("АТТР (Привлекательность)", "ATTR"),
            ("УДАЧА", "LUCK"),
            ("ДВИЖ (Движение)", "MA"),
            ("ТЕЛО", "BODY"),
            ("ЭМП (Эмпатия)", "EMP")
        ]

        for i, (label, stat) in enumerate(stats):
            spin = QSpinBox()
            spin.setRange(1, 10)
            spin.valueChanged.connect(self.emit_character_update)
            stats_layout.addWidget(QLabel(label), i // 3, (i % 3) * 2)
            stats_layout.addWidget(spin, i // 3, (i % 3) * 2 + 1)
            self.stat_widgets[stat] = spin

        stats_group.setLayout(stats_layout)

        if isinstance(layout, QFormLayout):
            layout.addRow(stats_group)
        elif isinstance(layout, QLayout):
            layout.addWidget(stats_group)

        if isinstance(layout, QLayout) and not tab.layout():
            tab.setLayout(layout)

    def create_armor_tab(self):
        """Создает вкладку с визуализацией брони по частям тела"""
        tab = QWidget()
        layout = QVBoxLayout()
        tab.setLayout(layout)

        # Сетка для расположения частей тела
        grid = QGridLayout()
        grid.setSpacing(10)

        # Создаем виджеты для каждой части тела
        self.armor_widgets = {}
        body_parts = [
            ("Голова", "head", 0, 1),
            ("Торс", "body", 1, 1),
            ("Левая рука", "left_arm", 1, 0),
            ("Правая рука", "right_arm", 1, 2),
            ("Левая нога", "left_leg", 2, 0),
            ("Правая нога", "right_leg", 2, 2)
        ]

        for label, part_name, row, col in body_parts:
            widget = self._create_armor_part_widget(label, part_name)
            self.armor_widgets[part_name] = widget
            grid.addWidget(widget, row, col)

        # Добавляем сетку в основной layout
        layout.addLayout(grid)
        layout.addStretch()

        # Кнопка для сброса брони
        reset_btn = QPushButton("Сбросить броню")
        reset_btn.clicked.connect(self.reset_armor)
        layout.addWidget(reset_btn)

        self.tabs.addTab(tab, "🛡️ Броня")

    def _create_armor_part_widget(self, label: str, part_name: str) -> QFrame:
        """Создает виджет для отображения брони на части тела"""
        frame = QFrame()
        frame.setFrameShape(QFrame.Shape.Box)
        frame.setLineWidth(1)
        frame.setMinimumSize(100, 100)

        layout = QVBoxLayout()
        frame.setLayout(layout)

        # Заголовок (название части тела)
        title = QLabel(label)
        title_font = QFont()
        title_font.setBold(True)
        title.setFont(title_font)
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)
        layout.addWidget(title)

        # Значение брони (большой шрифт)
        value_label = QLabel("0")
        value_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        value_label.setObjectName(f"{part_name}_value")

        value_font = QFont()
        value_font.setPointSize(20)
        value_font.setBold(True)
        value_label.setFont(value_font)
        layout.addWidget(value_label)

        # Кнопки для изменения значения
        btn_layout = QHBoxLayout()

        minus_btn = QPushButton("-")
        minus_btn.setMaximumWidth(30)
        minus_btn.clicked.connect(lambda: self.adjust_armor(part_name, -1))

        plus_btn = QPushButton("+")
        plus_btn.setMaximumWidth(30)
        plus_btn.clicked.connect(lambda: self.adjust_armor(part_name, 1))

        btn_layout.addWidget(minus_btn)
        btn_layout.addWidget(plus_btn)
        layout.addLayout(btn_layout)

        return frame

    def adjust_armor(self, part_name: str, delta: int):
        """Изменяет значение брони для указанной части тела"""
        # Находим текущее значение
        value_label = self.findChild(QLabel, f"{part_name}_value")
        if value_label:
            try:
                current_value = int(value_label.text())
                new_value = max(0, current_value + delta)
                value_label.setText(str(new_value))
                self.emit_character_update()
            except ValueError:
                pass

    def reset_armor(self):
        """Сбрасывает все значения брони к 0"""
        for part_name in self.armor_widgets:
            value_label = self.findChild(QLabel, f"{part_name}_value")
            if value_label:
                value_label.setText("0")
        self.emit_character_update()

    def create_skills_tab(self):
        tab = QWidget()
        layout = QVBoxLayout()

        self.skills_table = QTableWidget(0, 2)
        self.skills_table.setHorizontalHeaderLabels(["Навык", "Уровень"])
        self.skills_table.horizontalHeader().setStretchLastSection(True)

        # Кнопки для управления навыками
        btn_layout = QHBoxLayout()
        self.add_skill_btn = QPushButton("Добавить Навык")
        self.remove_skill_btn = QPushButton("Удалить Навык")
        btn_layout.addWidget(self.add_skill_btn)
        btn_layout.addWidget(self.remove_skill_btn)

        layout.addWidget(self.skills_table)
        layout.addLayout(btn_layout)
        tab.setLayout(layout)
        self.tabs.addTab(tab, "Навыки")

        # Connect signals
        self.skills_table.cellChanged.connect(self.handle_skill_change)
        self.add_skill_btn.clicked.connect(self.add_skill_row)
        self.remove_skill_btn.clicked.connect(self.remove_skill_row)

    def create_cybernetics_tab(self):
        tab = QWidget()
        layout = QVBoxLayout()

        self.cyberware_list = QListWidget()
        self.cyberware_list.setAlternatingRowColors(True)

        # Информационные метки
        info_layout = QFormLayout()
        self.humanity_value = QLabel("100")
        self.capacity_value = QLabel("0/100")
        info_layout.addRow("Человечность:", self.humanity_value)
        info_layout.addRow("Осталось:", self.capacity_value)

        # Кнопки управления
        btn_layout = QHBoxLayout()
        self.add_cyberware_btn = QPushButton("Добавить Кибернетику")
        self.remove_cyberware_btn = QPushButton("Удалить Выделенное")
        btn_layout.addWidget(self.add_cyberware_btn)
        btn_layout.addWidget(self.remove_cyberware_btn)

        layout.addWidget(self.cyberware_list)
        layout.addLayout(info_layout)
        layout.addLayout(btn_layout)
        tab.setLayout(layout)
        self.tabs.addTab(tab, "Кибернетика")

        # Connect signals
        self.add_cyberware_btn.clicked.connect(self.emit_add_cyberware)
        self.remove_cyberware_btn.clicked.connect(self.emit_remove_cyberware)
        self.cyberware_list.itemDoubleClicked.connect(self.show_list_item_description)

    def create_equipment_tab(self):
        tab = QWidget()
        layout = QVBoxLayout()

        # Оружие
        weapons_group = QGroupBox("Оружие")
        self.weapons_list = QListWidget()
        weapons_layout = QVBoxLayout()
        add_weapon_btn = QPushButton("Добавить оружие")
        add_weapon_btn.clicked.connect(lambda: self.emit_add_equipment_for_list("weapon"))
        weapons_layout.addWidget(self.weapons_list)
        weapons_layout.addWidget(add_weapon_btn)
        weapons_group.setLayout(weapons_layout)

        # Броня
        armor_group = QGroupBox("Броня")
        self.armor_list = QListWidget()
        armor_layout = QVBoxLayout()
        add_armor_btn = QPushButton("Добавить броню")
        add_armor_btn.clicked.connect(lambda: self.emit_add_equipment_for_list("armor"))
        armor_layout.addWidget(self.armor_list)
        armor_layout.addWidget(add_armor_btn)
        armor_group.setLayout(armor_layout)

        # Снаряжение
        gear_group = QGroupBox("Предметы")
        self.gear_list = QListWidget()
        gear_layout = QVBoxLayout()
        add_gear_btn = QPushButton("Добавить снарягу")
        add_gear_btn.clicked.connect(lambda: self.emit_add_equipment_for_list("gear"))
        gear_layout.addWidget(self.gear_list)
        gear_layout.addWidget(add_gear_btn)
        gear_group.setLayout(gear_layout)

        # Финансы
        money_layout = QFormLayout()
        self.money_edit = QSpinBox()
        self.money_edit.setRange(0, 1000000)
        money_layout.addRow("Деньги:", self.money_edit)



        layout.addWidget(weapons_group)
        layout.addWidget(armor_group)
        layout.addWidget(gear_group)
        layout.addLayout(money_layout)


        tab.setLayout(layout)
        self.tabs.addTab(tab, "Вещи")

        # Connect signals
        self.money_edit.valueChanged.connect(self.emit_character_update)
        self.weapons_list.itemDoubleClicked.connect(self.show_list_item_description)
        self.armor_list.itemDoubleClicked.connect(self.show_list_item_description)
        self.gear_list.itemDoubleClicked.connect(self.show_list_item_description)

    def create_lifepath_tab(self):
        tab = QWidget()
        layout = QFormLayout()

        self.origin_edit = QLineEdit()
        self.family_edit = QLineEdit()
        self.motivation_edit = QLineEdit()
        self.enemies_edit = QTextEdit()
        self.romance_edit = QLineEdit()

        layout.addRow("Ориджин:", self.origin_edit)
        layout.addRow("Семья:", self.family_edit)
        layout.addRow("Мотивация:", self.motivation_edit)
        layout.addRow("Враги*(список):", self.enemies_edit)
        layout.addRow("Романы:", self.romance_edit)

        tab.setLayout(layout)
        self.tabs.addTab(tab, "Жизненный Путь")

        # Connect signals
        self.origin_edit.textChanged.connect(self.emit_character_update)
        self.family_edit.textChanged.connect(self.emit_character_update)
        self.motivation_edit.textChanged.connect(self.emit_character_update)
        self.enemies_edit.textChanged.connect(self.emit_character_update)
        self.romance_edit.textChanged.connect(self.emit_character_update)

    def create_other_info_tab(self):
        tab = QWidget()
        layout = QFormLayout()

        self.reputation_spin = QSpinBox()
        self.reputation_spin.setRange(-10, 10)
        self.notes_edit = QTextEdit()

        layout.addRow("Репутация:", self.reputation_spin)
        layout.addRow("Заметки:", self.notes_edit)

        tab.setLayout(layout)
        self.tabs.addTab(tab, "Прочее")

        # Connect signals
        self.reputation_spin.valueChanged.connect(self.emit_character_update)
        self.notes_edit.textChanged.connect(self.emit_character_update)

    def show_list_item_description(self, item: QListWidgetItem):
        QMessageBox.information(
            self,
            "Описание",
            item.toolTip() or "Нет описания"
        )


    # ====================
    # Сигналы и обработчики
    # ====================

    def emit_character_update(self):
        """Собирает данные и отправляет сигнал контроллеру"""
        character = self.get_character_data()
        self.character_updated.emit(character)

    def handle_skill_change(self, row, column):
        if column == 1:
            skill_name_item = self.skills_table.item(row, 0)
            skill_value_item = self.skills_table.item(row, 1)

            if skill_name_item and skill_value_item:
                skill_name = skill_name_item.text()
                try:
                    skill_value = int(skill_value_item.text())
                    self.skill_updated.emit(skill_name, skill_value)
                except ValueError:
                    pass

    def add_skill_row(self):
        row_count = self.skills_table.rowCount()
        self.skills_table.insertRow(row_count)
        self.skills_table.setItem(row_count, 0, QTableWidgetItem("New Skill"))
        self.skills_table.setItem(row_count, 1, QTableWidgetItem("1"))

    def remove_skill_row(self):
        current_row = self.skills_table.currentRow()
        if current_row >= 0:
            self.skills_table.removeRow(current_row)
            self.emit_character_update()

    def emit_add_cyberware(self):
        from PySide6.QtWidgets import QInputDialog

        name, ok = QInputDialog.getText(self, "Киберимплант", "Название:")
        if not ok or not name:
            return

        humanity_cost, ok = QInputDialog.getInt(
            self, "Humanity Cost", "Потеря человечности:", 1, 0, 100)
        if not ok:
            return

        desc, ok = QInputDialog.getText(
            self, "Описание", "Описание (необязательно):")

        cyberware = Cyberware(
            name=name,
            humanity_cost=humanity_cost,
            description=desc if ok else ""
        )
        self.cyberware_added.emit(cyberware)

    def emit_remove_cyberware(self):
        current_item = self.cyberware_list.currentItem()
        if current_item:
            implant_name = current_item.text().split(" - ")[0]
            self.cyberware_removed.emit(implant_name)

    def emit_add_equipment_for_list(self, eq_type: str):
        dialog = EquipmentDialog(eq_type,self)
        if dialog.exec():
            equipment = dialog.get_equipment()
            equipment.type = eq_type  
            self.equipment_added.emit(equipment)


    # ====================
    # Методы обновления UI
    # ====================

    def update_character(self, character: Character):
        """Обновляет все виджеты на основе модели персонажа"""
        # Блокируем сигналы во время обновления
        self.blockSignals(True)

        # Основная информация
        self.name_edit.setText(character.name)
        self.handle_edit.setText(str(character.handle))
        self.role_combo.setCurrentText(character.role)
        self.special_ability_edit.setText(character.special_ability)

        # Статы
        for stat, value in character.stats.dict().items():
            if stat in self.stat_widgets:
                self.stat_widgets[stat].setValue(value)

        self.update_skills(character.skills)

        self.update_armor(character.armor)

        self.update_cybernetics(character)

        self.update_equipment(character.equipment)

        self.update_lifepath(character.lifepath)

        # Другое
        self.reputation_spin.setValue(character.reputation)
        self.money_edit.setValue(character.money)
        self.notes_edit.setText(character.notes or "")

        # Разблокируем сигналы
        self.blockSignals(False)

    def update_skills(self, skills: list[Skill]):
        self.skills_table.blockSignals(True)
        self.skills_table.setRowCount(len(skills))

        for row, skill in enumerate(skills):
            self.skills_table.setItem(row, 0, QTableWidgetItem(skill.name))
            self.skills_table.setItem(
                row, 1, QTableWidgetItem(str(skill.level)))

        self.skills_table.blockSignals(False)

    def update_armor(self, armor: Armor):
        for part_name in ["head", "body", "left_arm", "right_arm", "left_leg", "right_leg"]:
            value_label = self.findChild(QLabel, f"{part_name}_value")
            if value_label:
                body_part = getattr(armor, part_name)
                value_label.setText(str(body_part.value))

    def update_cybernetics(self, character: Character):
        self.cyberware_list.clear()
        for cyber in character.cyberware:
            item = QListWidgetItem(f"{cyber.name} - HC: {cyber.humanity_cost}")
            if cyber.description:
                item.setToolTip(cyber.description)
            self.cyberware_list.addItem(item)

        self.humanity_value.setText(str(character.humanity))
        # TODO: нужно добавить расчет capacity
        self.capacity_value.setText(
            f"{sum(len(c.name) for c in character.cyberware)}/100")

    def update_equipment(self, equipment: list[Equipment]):
        self.weapons_list.clear()
        self.armor_list.clear()
        self.gear_list.clear()

        for item in equipment:
            list_widget = None
            if "weapon" in item.type.lower():
                list_widget = self.weapons_list
            elif "armor" in item.type.lower():
                list_widget = self.armor_list
            else:
                list_widget = self.gear_list

            if list_widget:
                list_item = QListWidgetItem(f"{item.name} ({item.type})")
                if item.description:
                    list_item.setToolTip(item.description)
                list_widget.addItem(list_item)



    def update_lifepath(self, lifepath: Lifepath):
        self.origin_edit.setText(lifepath.origin)
        self.family_edit.setText(lifepath.family)
        self.motivation_edit.setText(lifepath.motivation)
        self.enemies_edit.setText("\n".join(lifepath.enemies))
        self.romance_edit.setText(lifepath.romance or "")

    # ======================
    # Методы получения данных
    # ======================

    def get_character_data(self) -> Character:
        """Создает объект Character на основе данных UI"""
        # Собираем статы
        stats_data = {stat: widget.value()
                      for stat, widget in self.stat_widgets.items()}
        stats = CharacterStats(**stats_data)

        armor_data = {}
        for part_name in ["head", "body", "left_arm", "right_arm", "left_leg", "right_leg"]:
            value_label = self.findChild(QLabel, f"{part_name}_value")
            if value_label:
                try:
                    value = int(value_label.text())
                except ValueError:
                    value = 0
                armor_data[part_name] = BodyPart(name=part_name, value=value)

        armor = Armor(**armor_data)

        # Собираем навыки
        skills = []
        for row in range(self.skills_table.rowCount()):
            name_item = self.skills_table.item(row, 0)
            level_item = self.skills_table.item(row, 1)
            if name_item and level_item:
                try:
                    skill = Skill(name=name_item.text(),
                                  level=int(level_item.text()))
                    skills.append(skill)
                except ValueError:
                    pass

        return Character(
            name=self.name_edit.text(),
            handle=self.handle_edit.text(),
            role=self.role_combo.currentText(),
            special_ability=self.special_ability_edit.text(),
            stats=stats,
            skills=skills,
            armor=armor,
            equipment=[],
            cyberware=[],
            lifepath=Lifepath(
                origin=self.origin_edit.text(),
                family=self.family_edit.text(),
                motivation=self.motivation_edit.text(),
                enemies=self.enemies_edit.toPlainText().splitlines(),
                romance=self.romance_edit.text() or None
            ),
            humanity=int(self.humanity_value.text()),
            reputation=self.reputation_spin.value(),
            money=self.money_edit.value(),
            notes=self.notes_edit.toPlainText() or None
        )
