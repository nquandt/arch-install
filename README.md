# dotfiles

Personal dotfiles for Arch Linux — Hyprland + Ghostty + tmux + Neovim (Catppuccin Mocha).

## Includes

| Config | Location |
|---|---|
| Hyprland | `~/.config/hypr/hyprland.conf` |
| Waybar | `~/.config/waybar/config` + `style.css` |
| wofi | `~/.config/wofi/style.css` |
| Ghostty | `~/.config/ghostty/config` |
| tmux | `~/.config/tmux/tmux.conf` |
| Neovim | `~/.config/nvim/init.lua` |

## Install

Clone the repo and run the install script:

```bash
git clone https://github.com/nquandt/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash install.sh
```

Or one-liner:

```bash
bash <(curl -s https://raw.githubusercontent.com/nquandt/dotfiles/main/install.sh)
```

> The install script symlinks all configs into place. Any existing files are backed up with a `.bak` extension before being replaced.

## After Install

1. Start tmux and press `Ctrl+Space` then `I` to install tmux plugins
2. Open `nvim` — lazy.nvim will auto-install all plugins on first launch
3. Run `nwg-look` to apply `Adwaita-dark` GTK theme and `Papirus-Dark` icons

## Dependencies

Make sure these are installed before running:

```bash
sudo pacman -S hyprland waybar wofi ghostty tmux neovim \
  ttf-jetbrains-mono-nerd noto-fonts noto-fonts-emoji \
  wl-clipboard nwg-look papirus-icon-theme

paru -S ghostty tmux-plugin-manager
```
