.PHONY: install update clean backup install-fonts install-brew link help

NVIM_DIR := $(HOME)/.config/nvim
BACKUP_DIR := $(HOME)/.config/nvim-backup-$(shell date +%Y%m%d-%H%M%S)

# Detect OS
UNAME_S := $(shell uname -s)

# Default Nerd Fonts to install (can be overridden)
NERD_FONTS ?= font-jetbrains-mono-nerd-font font-fira-code-nerd-font font-hack-nerd-font font-meslo-lg-nerd-font

help:
	@echo "Neovim Configuration Management"
	@echo "================================"
	@echo "install        - Install/sync all plugins via lazy.nvim"
	@echo "update         - Update all plugins to latest versions"
	@echo "clean          - Clean plugin cache and unused plugins"
	@echo "backup         - Backup current configuration"
	@echo "link           - Create symlink from current directory to ~/.config/nvim"
	@echo "install-fonts  - Install Nerd Fonts (macOS: via brew)"
	@echo "install-brew   - Install Homebrew (macOS only)"
	@echo ""
	@echo "Environment Variables:"
	@echo "  NERD_FONTS   - Space-separated list of fonts to install"
	@echo "                 Default: JetBrains Mono, Fira Code, Hack, Meslo LG"

install:
	@echo "Installing/syncing Neovim plugins..."
	nvim --headless "+Lazy! sync" +qa
	@echo "✓ Plugins installed successfully"

update:
	@echo "Updating Neovim plugins..."
	nvim --headless "+Lazy! update" +qa
	@echo "✓ Plugins updated successfully"

clean:
	@echo "Cleaning plugin cache..."
	nvim --headless "+Lazy! clean" +qa
	@echo "✓ Cache cleaned successfully"

backup:
	@echo "Backing up configuration to $(BACKUP_DIR)..."
	@cp -r $(NVIM_DIR) $(BACKUP_DIR)
	@echo "✓ Backup created at $(BACKUP_DIR)"

link:
	@echo "Creating symlink to ~/.config/nvim..."
	@if [ -e $(NVIM_DIR) ] || [ -L $(NVIM_DIR) ]; then \
		if [ -L $(NVIM_DIR) ]; then \
			current_target=$$(readlink $(NVIM_DIR)); \
			if [ "$$current_target" = "$(CURDIR)" ]; then \
				echo "✓ Symlink already points to $(CURDIR)"; \
				exit 0; \
			fi; \
		fi; \
		echo "⚠ $(NVIM_DIR) already exists"; \
		backup_dir=$(HOME)/.config/nvim-backup-$$(date +%Y%m%d-%H%M%S); \
		echo "Creating backup at $$backup_dir..."; \
		mv $(NVIM_DIR) $$backup_dir; \
		echo "✓ Backup created at $$backup_dir"; \
	fi
	@mkdir -p $(HOME)/.config
	@ln -s $(CURDIR) $(NVIM_DIR)
	@echo "✓ Symlink created: $(NVIM_DIR) -> $(CURDIR)"

install-brew:
ifeq ($(UNAME_S),Darwin)
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		echo "✓ Homebrew installed successfully"; \
	else \
		echo "✓ Homebrew already installed"; \
	fi
else
	@echo "⚠ Homebrew installation is only supported on macOS"
endif

install-fonts: install-brew
ifeq ($(UNAME_S),Darwin)
	@echo "Installing Nerd Fonts on macOS..."
	@for font in $(NERD_FONTS); do \
		echo "Installing $$font..."; \
		brew install --cask $$font || echo "⚠ Failed to install $$font"; \
	done
	@echo "✓ Nerd Fonts installation complete"
else ifeq ($(UNAME_S),Linux)
	@echo "Installing Nerd Fonts on Linux..."
	@mkdir -p $(HOME)/.local/share/fonts
	@for font in $(NERD_FONTS); do \
		font_name=$$(echo $$font | sed 's/font-//;s/-nerd-font//;s/-/ /g'); \
		echo "Downloading $$font_name..."; \
		curl -fLo "$(HOME)/.local/share/fonts/$$font.zip" \
			"https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$$font_name.zip" || \
			echo "⚠ Failed to download $$font"; \
		unzip -o "$(HOME)/.local/share/fonts/$$font.zip" -d "$(HOME)/.local/share/fonts/" 2>/dev/null || true; \
		rm -f "$(HOME)/.local/share/fonts/$$font.zip"; \
	done
	@fc-cache -fv
	@echo "✓ Nerd Fonts installation complete"
else
	@echo "⚠ Unsupported OS: $(UNAME_S)"
endif
