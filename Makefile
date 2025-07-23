BUILD_NUMBER ?= 001
BUILD_DIR := build\\v$(BUILD_NUMBER)

MAIN_SCRIPT := main.py
MAIN_EXE := $(BUILD_DIR)\\main.exe

ICON_PATH := desktop\\assets\\icons\\icon.ico
DATA_SRC := data\\characters
DATA_DST := $(BUILD_DIR)\\data\\characters

WORKPATH := $(BUILD_DIR)\\build
SPECPATH := $(BUILD_DIR)\\spec
PYCACHE := __pycache__

VENV := .build_venv
PYTHON := $(VENV)\\Scripts\\python.exe
PYINSTALLER := $(VENV)\\Scripts\\pyinstaller.exe

.PHONY: all build clean_temp pre_clean dirs

all: build

build: pre_clean dirs main copy_data clean_temp
	@echo ✅ Build completed! Output: $(BUILD_DIR)

dirs:
	@echo 🗂️ Creating folders...
	@if not exist "$(BUILD_DIR)" mkdir "$(BUILD_DIR)"

main:
	@echo 🚀 Building main GUI app...
	"$(PYINSTALLER)" --name main --onefile --windowed \
		--icon="$(ICON_PATH)" \
		--add-data=data/characters:data/characters \
		--distpath "$(BUILD_DIR)" \
		--workpath "$(WORKPATH)" \
		--clean "$(MAIN_SCRIPT)"

copy_data:
	@echo 📁 Copying data/characters to $(DATA_DST)
	@if exist "$(DATA_SRC)" xcopy /E /I /Y "$(DATA_SRC)" "$(DATA_DST)"

clean_temp:
	@echo 🧹 Cleaning temp files...
	@if exist "$(WORKPATH)" rmdir /S /Q "$(WORKPATH)"
	@if exist "$(SPECPATH)" rmdir /S /Q "$(SPECPATH)"
	@if exist "$(PYCACHE)" rmdir /S /Q "$(PYCACHE)"
	@del /Q "$(BUILD_DIR)\\*.spec" 2>nul

pre_clean:
	@echo 🗑️ Removing old build version: $(BUILD_DIR)
	@if exist "$(BUILD_DIR)" rmdir /S /Q "$(BUILD_DIR)"
