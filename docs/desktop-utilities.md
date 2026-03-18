# Desktop utilities

## Dunst

Notification daemon. **Catppuccin-style** colors in **`dunst/dunstrc`**.

Dismiss: **Ctrl+Shift+Space** (see dunstrc shortcuts).

## wob

Volume bar overlay. Hyprland pipes **pamixer** volume into **`/tmp/wobpipe`** on **Super+W/P**.

## cliphist

**wl-paste** watches copy **text** and **images** into **cliphist**. List/select with **`cliphist list | wofi | cliphist decode | wl-copy`** or a custom binding — not bound by default.

## hyprshot

**Super+U** — region screenshot. **Super+L** — full output. Files land where hyprshot defaults (often `~/Pictures`).

## imv

**Wayland image viewer** (minimal, keyboard-driven). Installed from **extra**.

```bash
imv ~/Pictures/screenshot.png
imv ~/Pictures/*.png   # directory / glob
```

Launch from **wofi** or bind in Hyprland if you want. Default associations: set **`imv`** as default for `image/png` etc. in **`~/.config/mimeapps.list`** or **nwg-look** / portal file picker as needed.

## swaylock

**Super+Shift+L** — lock screen (Catppuccin-colored solid lock). Requires **swaylock**.

## Firefox

**Super+B** — browser. Installed from **extra**.

## Fonts

**JetBrains Mono Nerd Font** (Waybar, terminal), **Noto** + emoji — good Unicode coverage.

## Dev CLIs (pacman)

**ripgrep**, **fd**, **gcc**, **cmake**, **make**, **python**, **git** — general development. **tree-sitter-cli** / **luarocks** may be present for editor tooling.

## Optional AUR

- **wl-screenrec** — **Super+Y** screen recording (`hypr/record.sh`).
- **Claude Code** — see **[claude-code.md](claude-code.md)**.

## swww (wallpaper daemon)

Wayland wallpaper daemon. Starts automatically on Hyprland login. See **[wallpaper-and-themes.md](wallpaper-and-themes.md)** for full details.

```bash
wall              # random wallpaper from ~/Pictures/wallpapers/
wall /path/to/img # specific image
```

## Theme switcher

Cycles Catppuccin variants across Ghostty, Hyprland, Dunst, Wofi, Waybar. See **[wallpaper-and-themes.md](wallpaper-and-themes.md)**.

```bash
theme             # cycle: mocha → macchiato → frappe → latte
theme latte       # jump to specific theme
```

## Scripts (`~/.config/scripts/`)

Symlinked from **`scripts/`**: tmux entrypoints, **lock**, **switch_keyboard_layout**, **wallpaper-set**, **theme-switch**, **tmux-pane-tile**, etc. All executable after **install.sh**.
