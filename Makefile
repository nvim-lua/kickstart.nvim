# Neovim Config — Dependency Installation
# Run: make install

.PHONY: install check clean help

# Core dependencies (required)
CORE_DEPS := neovim gcc make git ripgrep fd tree-sitter-cli unzip xclip

# Linting (recommended)
LINT_DEPS := shellcheck golangci-lint

# All deps combined
ALL_DEPS := $(CORE_DEPS) $(LINT_DEPS)

install:
	@echo "==> Installing core dependencies..."
	sudo pacman -S --needed --noconfirm $(CORE_DEPS)
	@echo "==> Installing linting dependencies..."
	sudo pacman -S --needed --noconfirm $(LINT_DEPS) 2>/dev/null || true
	@echo "==> Done. Launch nvim to auto-install plugins."

check:
	@echo "==> Checking dependencies..."
	@missing=0; \
	for dep in $(ALL_DEPS); do \
		if command -v $$dep >/dev/null 2>&1; then \
			echo "  [OK] $$dep"; \
		else \
			echo "  [MISSING] $$dep"; \
			missing=1; \
		fi; \
	done; \
	if [ $$missing -eq 0 ]; then echo "==> All dependencies installed."; \
	else echo "==> Run 'make install' to install missing deps."; fi

clean:
	@echo "==> This removes Neovim's local data (plugins, cache). Use with caution."
	@echo "    Run: rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim"

help:
	@echo "Targets:"
	@echo "  make install   Install all system dependencies via pacman"
	@echo "  make check     Check which dependencies are installed"
	@echo "  make clean     Instructions for wiping Neovim data"
