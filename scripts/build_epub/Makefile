.PHONY: help setup install build test clean clean-all setup-check

VENV := .venv
PYTHON := $(VENV)/bin/python
PIP := $(VENV)/bin/pip
PANDOC := build_epub.sh
OUTPUT_DIR := output
EPUB_FILE := $(OUTPUT_DIR)/Go_Course_10_Days.epub

help:
	@echo "Go Course EPUB Build System"
	@echo ""
	@echo "Available targets:"
	@echo "  make setup          - Create and setup virtual environment"
	@echo "  make install        - Install dependencies (requires setup)"
	@echo "  make pandoc         - Download Pandoc (requires setup)"
	@echo "  make build          - Generate EPUB (default)"
	@echo "  make rebuild        - Clean and rebuild EPUB"
	@echo "  make test           - Test build and verify output"
	@echo "  make clean          - Remove generated EPUB files"
	@echo "  make clean-venv     - Remove virtual environment"
	@echo "  make clean-all      - Remove venv and generated files"
	@echo "  make check          - Verify setup and dependencies"
	@echo ""
	@echo "Examples:"
	@echo "  make setup && make build  - First-time setup and build"
	@echo "  make rebuild              - Quick rebuild after markdown edit"

setup-check:
	@if [ ! -d "$(VENV)" ]; then \
		echo "❌ Virtual environment not found"; \
		echo "Run: make setup"; \
		exit 1; \
	fi
	@echo "✓ Virtual environment OK"

setup:
	@echo "Setting up virtual environment..."
	python3 -m venv $(VENV)
	$(PIP) install --upgrade pip
	@echo "✓ Virtual environment created"

install: setup-check
	@echo "Installing dependencies..."
	$(PIP) install -q -r requirements.txt
	@echo "✓ Dependencies installed"

pandoc: setup-check
	@echo "Downloading Pandoc..."
	$(PYTHON) -c "import pypandoc; pypandoc.download_pandoc()"
	@echo "✓ Pandoc downloaded"

build: setup-check pandoc
	@echo "Building EPUB..."
	@. $(VENV)/bin/activate && bash $(PANDOC)
	@if [ -f "$(EPUB_FILE)" ]; then \
		echo "✓ EPUB generated: $(EPUB_FILE)"; \
		ls -lh $(EPUB_FILE); \
	else \
		echo "❌ Build failed!"; \
		exit 1; \
	fi
	@rm pandoc*.deb 2>/dev/null || true

rebuild: clean build

test: build
	@echo "Testing EPUB..."
	@if [ ! -f "$(EPUB_FILE)" ]; then \
		echo "❌ EPUB file not found!"; \
		exit 1; \
	fi
	@size=$$(stat -f%z "$(EPUB_FILE)" 2>/dev/null || stat -c%s "$(EPUB_FILE)"); \
	if [ $$size -gt 10000 ]; then \
		echo "✓ EPUB file size OK: $$(du -h $(EPUB_FILE) | cut -f1)"; \
	else \
		echo "❌ EPUB file seems too small"; \
		exit 1; \
	fi
	@echo "✓ All tests passed!"

check: setup-check
	@echo "Checking setup..."
	@echo "Python: $$($(PYTHON) --version)"
	@. $(VENV)/bin/activate && which pandoc && pandoc --version | head -1 || echo "⚠ Pandoc needs download: make pandoc"
	@$(PYTHON) -c "import pygments; print('Pygments:', pygments.__version__)" 2>/dev/null || echo "❌ Pygments not installed"
	@$(PYTHON) -c "import pypandoc; print('pypandoc: OK')" 2>/dev/null || echo "❌ pypandoc not installed"
	@echo "✓ Setup verified"

clean:
	@echo "Cleaning generated files..."
	@rm -f $(EPUB_FILE)
	@rm -rf $(OUTPUT_DIR)
	@echo "✓ Cleaned"

clean-venv:
	@echo "Removing virtual environment..."
	@rm -rf $(VENV)
	@echo "✓ Virtual environment removed"

clean-all: clean clean-venv
	@echo "✓ Full cleanup complete"

# Default target
.DEFAULT_GOAL := build
