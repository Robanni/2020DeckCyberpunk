from PySide6.QtWidgets import (
    QDialog, QVBoxLayout, QLineEdit, QComboBox, QTextEdit,
    QPushButton, QFormLayout, QHBoxLayout
)
from core.models.character import Equipment


class EquipmentDialog(QDialog):
    def __init__(self,type:str, parent=None ):
        super().__init__(parent)
        self.setWindowTitle("Добавить снаряжение")

        layout = QVBoxLayout()
        form = QFormLayout()

        self.name_edit = QLineEdit()
        self.type = type
        # self.type_combo.addItems(["weapon", "armor", "gear"])
        self.desc_edit = QTextEdit()

        form.addRow("Название:", self.name_edit)
        # form.addRow("Тип:", self.type_combo)
        form.addRow("Описание:", self.desc_edit)

        layout.addLayout(form)

        btn_layout = QHBoxLayout()
        self.ok_btn = QPushButton("Добавить")
        self.cancel_btn = QPushButton("Отмена")
        btn_layout.addWidget(self.ok_btn)
        btn_layout.addWidget(self.cancel_btn)

        layout.addLayout(btn_layout)
        self.setLayout(layout)

        self.ok_btn.clicked.connect(self.accept)
        self.cancel_btn.clicked.connect(self.reject)

    def get_equipment(self) -> Equipment:
        return Equipment(
            name=self.name_edit.text(),
            type=self.type,
            description=self.desc_edit.toPlainText()
        )
