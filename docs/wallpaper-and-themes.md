# Wallpaper & Themes

## Wallpaper (swww)

**Package:** `swww` (pacman)
**Config:** `scripts/wallpaper-set` → `~/.config/scripts/wallpaper-set`
**Wallpaper directory:** `~/Pictures/wallpapers/` (create and add your own images)

`swww-daemon` starts automatically on Hyprland login. On each login it also restores the last set wallpaper (1 second delay to let the daemon init first).

### Setting a wallpaper

```bash
wall              # random image from ~/Pictures/wallpapers/
wall ~/Pictures/wallpapers/anime-desk.jpg   # specific file
```

Supports **jpg, jpeg, png, gif, webp**. Subdirectories are searched one level deep.

### Monitor size

This setup uses a **3440×1440 ultrawide (21:9)**. Search for wallpapers at that resolution or filter by **21:9** aspect ratio on sites like Wallhaven to avoid stretching.

### Transition

Uses `swww img --transition-type grow` (grow from center, 1s, 60fps). Edit `scripts/wallpaper-set` to change transition type/speed.

### State

Last wallpaper path is saved to `~/.config/current-wallpaper`.

---

## Theme switcher

**Config:** `scripts/theme-switch` → `~/.config/scripts/theme-switch`
**Themes:** Catppuccin **mocha** (default) → **macchiato** → **frappe** → **latte** (light)

```bash
theme             # cycle to next theme
theme mocha       # set specific theme
theme latte       # switch to light mode
```

### What gets updated

| App | How |
|-----|-----|
| **Ghostty** | `theme =` line swapped; Ghostty auto-reloads config |
| **Hyprland borders** | `hyprctl keyword` (live, instant) + persisted in `hyprland.conf` |
| **Dunst** | Colors sed'd in `dunstrc` + `SIGHUP` to reload |
| **Wofi** | Colors sed'd in `style.css` (takes effect on next open) |
| **Waybar** | Structural colors (bg/surface/text) sed'd + `SIGUSR2` to reload |

Waybar's rainbow workspace animations intentionally cycle the full Catppuccin spectrum and are left as-is across all themes.

### Ghostty theme files

All four Catppuccin variants live in `ghostty/themes/` and are symlinked into `~/.config/ghostty/themes/`:

- `catppuccin-mocha` (dark, default)
- `catppuccin-macchiato` (dark, slightly warmer)
- `catppuccin-frappe` (medium dark)
- `catppuccin-latte` (light)

### State

Current theme is saved to `~/.config/current-theme`. The theme-switch script reads this on each run to know which palette to replace.

### Keybinds

| Keys | Action |
|------|--------|
| **Super+Shift+W** | Random wallpaper |
| **Super+Shift+A** | Cycle theme |

← [Documentation index](README.md)
