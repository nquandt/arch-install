# Ghostty

**Config:** `ghostty/config` + `ghostty/themes/` → `~/.config/ghostty/`

Ghostty is the default terminal (AUR). Hyprland opens it with **Super+Enter** (tmux), **Super+Shift+Enter**, or **Super+Ctrl+Enter** (no tmux).

## Settings (high level)

- **Theme:** Catppuccin Mocha (`theme = catppuccin-mocha` + theme file under `themes/`).
- **Font:** JetBrains Mono (+ Twemoji for icons if configured).
- **Padding, opacity** — set in **`ghostty/config`**.
- **gtk-single-instance** — one window group on GTK.

## Changing the terminal

If you switch to **kitty** or **alacritty**, edit **`hypr/hyprland.conf`** and replace every **`ghostty`** in `exec` lines with your terminal’s command.

## Docs

- [ghostty.org/docs](https://ghostty.org/docs)
