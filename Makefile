# Makefile setup

PWD := $(shell pwd)
STOW_PACKAGES := alacritty fish ghostty hypr mise nvim starship waybar
STOW_FLAGS := -v -R -t $(HOME)

.PHONY: all install init paru packages symlinks clean help

# Entrypoint to run everything
all: install

install: init paru packages symlinks vscode
	@echo "✓ Setup complete"

init:
	@echo "Initializing submodules..."

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

symlinks:
	@echo "Creating symlinks with GNU Stow..."
	@for package in $(STOW_PACKAGES); do \
		if [ -d "$$package" ]; then \
			stow $(STOW_FLAGS) $$package && echo "  ✓ $$package linked"; \
		fi \
	done
	@# Handle vscode with --no-folding
	@if [ -d "vscode" ]; then \
		stow $(STOW_FLAGS) --no-folding vscode && echo "  ✓ vscode linked (no-folding)"; \
	fi

vscode: symlinks
	@./scripts/install-vscode-extensions.fish

clean:
	@echo "Removing symlinks with stow..."
	@for package in $(STOW_PACKAGES) vscode; do \
		stow -D -t $(HOME) $$package 2>/dev/null || true; \
	done

restow: ## Relink everything (useful after changes)
	@echo "Restowing all packages..."
	@stow -R $(STOW_FLAGS) $(STOW_PACKAGES)
	@if [ -d "vscode" ]; then \
		stow -R $(STOW_FLAGS) --no-folding vscode && echo "  ✓ vscode restowed (no-folding)"; \
	fi

restow-dry: ## Test restow without making changes (adding -n flag)
	@echo "Simulating restow..."
	@stow -n -R $(STOW_FLAGS) $(STOW_PACKAGES)
	@if [ -d "vscode" ]; then \
		stow -n -R $(STOW_FLAGS) --no-folding vscode && echo "  ✓ vscode would be restowed (no-folding)"; \
	fi