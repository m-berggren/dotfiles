# Makefile setup

PWD := $(shell pwd)

.PHONY: all install paru packages symlinks fish mise clean help

all: install

install: paru packages symlinks fish mise
	@echo "✓ Setup complete"

# Will use paru to install all packages, official or not
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
	@paru -S --needed --noconfirm $$(cat packages/packages.txt 2>/dev/null | grep -v '^#' | grep -v '^$$')

symlinks:
	@echo "Creating symlinks..."
	@mkdir -p ~/.config
	@ln -sf $(PWD)/fish/.config/fish ~/.config/
	@ln -sf $(PWD)/hypr/.config/hypr ~/.config/
	@ln -sf $(PWD)/nvim/.config/nvim ~/.config/
	@ln -sf $(PWD)/starship/.config/starship.toml ~/.config/
	@ln -sf $(PWD)/waybar/.config/waybar ~/.config/
	@ln -sf $(PWD)/mise/.config/mise ~/.config/
	@ln -sf $(PWD)/vscode/.config/Code/User/ ~/.config/

fish: packages
	@echo "Setting up fish..."
	@grep -q /usr/bin/fish /etc/shells || echo /usr/bin/fish | sudo tee -a /etc/shells
	@[ "$$SHELL" = "/usr/bin/fish" ] || chsh -s /usr/bin/fish
	@fish -c "type -q fisher || curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"

mise: packages symlinks
	@echo "Setting up mise tools..."
	@mise install --yes
	@mise reshim
	@echo "Installed languages:"
	@mise list --installed

vscode: packages
	@echo "Installing VSCode extensions..."
	@command -v code >/dev/null 2>&1 && { \
		cat vscode/extensions.txt | grep -v '^#' | grep -v '^$$' | xargs -L 1 code --install-extension; \
	} || echo "VSCode not found, skipping extensions"

clean:
	@echo "Removing symlinks..."
	@rm -rf ~/.config/fish ~/.config/hypr ~/.config/nvim ~/.config/starship.toml ~/.config/waybar ~/.config/mise

help:
	@echo "Available targets:"
	@echo "  make install    - Full installation"
	@echo "  make paru       - Install paru AUR helper"
	@echo "  make packages   - Install all packages"
	@echo "  make symlinks   - Create config symlinks"
	@echo "  make fish       - Setup fish shell"
	@echo "  make mise       - Install mise tools"
	@echo "  make vscode     - Install VSCode extensions"
	@echo "  make clean      - Remove symlinks"