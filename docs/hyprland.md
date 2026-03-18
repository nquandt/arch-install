# Hyprland

**Config:** `hypr/hyprland.conf` + **`hyprland.local.conf`** (from **`hyprland.local.lowpower`** or **`.performance`**) → `~/.config/hypr/`

- **Default install:** minimal GPU use (base config + small **lowpower** local).
- **`bash install.sh --performance`:** blur, shadows, animations via **`hyprland.local.performance`**. See **[system-optimization.md](system-optimization.md)**.

## Workspaces

- **Super+R S T X C D G V** → workspaces **11–18** (shown on Waybar as 一 二 三 …).
- **Super+Ctrl+** same letters → **move** focused window to that workspace.
- **Super+Alt+1–9** → workspaces **1–9** (Super+2 is reserved for **mute**).
- **Super+scroll** → previous/next workspace.
- Session starts on workspace **11**.

## Windows

| Shortcut | Action |
|----------|--------|
| **Super+Enter** | Ghostty → tmux “main” session |
| **Super+Shift+Enter** | Ghostty → fresh tmux loop |
| **Super+Ctrl+Enter** | Plain Ghostty |
| **Super+Q** | Close window |
| **Super+Shift+M** | **Exit Hyprland** (logout) |
| **Super+F** | App launcher (**wofi**) |
| **Super+B** | **Firefox** |
| **Super+3** | Fullscreen |
| **Super+4** | Toggle floating |
| **Super+H/J/K/L** | Focus left/down/up/right |
| **Super+N / E** | Next / previous window |
| **Super+Shift+N/E** | Swap windows |
| **Super+M / I** | Shrink / grow master ratio |
| **Super+drag** | Move window |
| **Super+right-drag** | Resize |
| **Super+Shift+click** | Kill window |

## Media & capture

| Shortcut | Action |
|----------|--------|
| **Super+W / P** | Volume down / up (bar: **wob**) |
| **Super+2** | Mute |
| **Super+U** | Screenshot region (**hyprshot**) |
| **Super+L** | Screenshot full output |
| **Super+Y** | Toggle screen record (**wl-screenrec**, if installed) |

## Other

- **Super+Shift+L** → **swaylock**
- **Super+Shift+Z** → keyboard layout script (edit `scripts/switch_keyboard_layout.sh` for your layouts)

## “Smart gaps”

When only one tiled window is on a workspace, gaps/borders can collapse (rules at top of config). Comment those lines if you prefer gaps always on.

## Multi-monitor

Default is **one monitor** (`monitor=,preferred,auto,1`). Uncomment and edit the **DP-1 / HDMI** examples in the config for multiple outputs, then adjust Waybar `output` if you use per-monitor bars.

## Learn more

- [Hyprland wiki](https://wiki.hyprland.org/)
