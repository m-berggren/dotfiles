# dotfiles
Dotfiles for GNU Stow usage

## Details
**OS**: Arch Linux <br>
**VM**: Hyprland <br>
**Terminals**: Alacritty & Ghostty <br>
**Shell**: Fish with Starship customization <br>
**Themes**: Mainly Kanagawa, Everforest

## Applications in use
Some of the applications installed through Makefile:
- Anki
- Docker
- Logseq
- Neovim
- Podman
- Postman
- Tailscale
- VsCode
- Zen Browser
- Yazi

## Run Makefile
Install everything through `make all` or `make` command.

`make restow` to just recreate symlinks, or `make restow-dry` to simulate before actual run.

`make clean` will remove all symlinks.
