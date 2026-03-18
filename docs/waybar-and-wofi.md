# Waybar & wofi

## Waybar

**Config:** `waybar/config` + `waybar/default-modules.json` + `waybar/style.css` → `~/.config/waybar/`

**Bottom bar** (Catppuccin-styled):

| Section | Contents |
|---------|----------|
| Left | Arch icon, Hyprland workspaces (11–18 as 一二…), pulseaudio, pacman update count (**arch_updates** Python script), CPU, RAM |
| Center | Active window title |
| Right | tray, clock *(cava removed for low CPU/GPU — see **system-optimization.md** to re-add)* |

**Click** the update module → Ghostty runs `checkupdates` (read-only list).

### Scripts

`~/.config/waybar/scripts/` includes **arch_updates** (needs **pacman-contrib**), downloads helpers, etc.

### Workspace strip shows boxes, wrong glyphs, or empty cells

Waybar’s **hyprland/workspaces** module picks icons by workspace **name**, not ID. This repo sets **defaultName** 一…八 on workspaces **11–18** in **`hypr/hyprland.conf`** so names always match. **noto-fonts-cjk** (installed by **`install.sh`**) + **`#workspaces`** font fallback in **`style.css`** render those kanji; JetBrains Mono Nerd alone does not include them.

### If Waybar fails to start

- Remove **`"cava"`** from **`modules-right`** in **`waybar/config`** if your Waybar build has no cava module.
- On a laptop without battery, some builds still work; if not, trim the battery module (not in default bar here).

### Editing

Main layout is JSON in **`waybar/config`**; module definitions live in **`default-modules.json`**. CSS is large — tweak colors/sizing in **`style.css`**.

---

## wofi

**Style:** `wofi/style.css` → `~/.config/wofi/style.css`

**Super+F** runs **`wofi --show drun`** — launch apps by name.

No separate **`wofi/config`** is required for basic drun; add one if you want custom width/location.

- [Waybar wiki](https://github.com/Alexays/Waybar/wiki)
- `man wofi`
