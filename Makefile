# Makefile setup

PWD := $(shell pwd)
STOW_PACKAGES := fish hypr waybar starship mise
STOW_FLAGS := -v -R -t $(HOME)

.PHONY: all install init paru packages symlinks clean help

all: install

install: init paru packages symlinks nvim vscode
	@echo "✓ Setup complete"

init:
	@echo "Initializing submodules..."
	@git submodule update --init --recursive || true

paru:
	@command -v paru >/dev/null 2>&1 || { \
		echo "Installing paru..."; \
		sudo pacman -S --needed --noconfirm base-devel git; \
		git clone https://aur.archlinux.org/paru-bin.git /tmp/paru-bin; \
		cd /tmp/paru-bin && makepkg -si --noconfirm; \
		rm -rf /tmp/paru-bin; \
	}

packages: paru
	@echo "Installing all packages..."
	@paru -S --needed --noconfirm $$(grep -v '^#' packages/packages.txt | grep -v '^$$')

symlinks: # Handle nvim separately due to being a submodule
	@echo "Creating symlinks with GNU Stow..."
	@for package in $(STOW_PACKAGES); do \
		if [ -d "$$package" ]; then \
			stow $(STOW_FLAGS) $$package && echo "  ✓ $$package linked"; \
		fi \
	done
	@if [ -d nvim/.config/nvim ]; then \
		stow $(STOW_FLAGS) nvim && echo "  ✓ nvim linked"; \
	fi

nvim:
	@echo "Ensuring neovim config..."
	@if [ ! -d ~/.config/nvim ] && [ ! -d nvim/.config/nvim ]; then \
		git clone https://github.com/m-berggren/nvim.git ~/.config/nvim; \
	fi

clean:
	@echo "Removing symlinks with stow..."
	@for package in $(STOW_PACKAGES) nvim; do \
		stow -D -t $(HOME) $$package 2>/dev/null || true; \
	done

restow: ## Relink everything (useful after changes)
	@echo "Restowing all packages..."
	@stow $(STOW_FLAGS) $(STOW_PACKAGES)
	@[ -d nvim/.config/nvim ] && stow $(STOW_FLAGS) nvim || true