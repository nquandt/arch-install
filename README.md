# Arch Hyprland dotfiles

Wayland desktop for **development** on **low-power / iGPU** machines (ITX, low-TDP CPUs): Hyprland without blur or animations by default, **zram** + sysctl tuning, Ghostty, **tmux**, **Neovim**, **zsh**. From [angelofallars/dotfiles](https://github.com/angelofallars/dotfiles), adapted for **Arch**.

---

## Quick start

1. Minimal Arch from **[arch-install.md](arch-install.md)** (includes `zsh`, `git`, `sudo`, NetworkManager).
2. Wi‑Fi / `sudo pacman -Syu`.
3. Clone this repo and run:

```bash
git clone https://github.com/YOU/arch-install.git && cd arch-install
bash install.sh                        # low-power / iGPU (default)
# bash install.sh --performance        # stronger PC: blur, animations, cava
# bash install.sh --performance --claude-code
```

4. **Log out and back in** (or reboot) so **zsh** is your login shell.
5. At **SDDM**, choose **Hyprland**.
6. In **tmux**: **Ctrl+Space** then **I** (install TPM plugins). In **nvim**: first run downloads Lazy/Mason.

---

## What gets installed

`install.sh` builds **paru** if needed, then installs packages and symlinks **`~/.config/`** + shell files from this repo.

### Desktop & session

| Piece | Role |
|-------|------|
| **Hyprland** | Wayland compositor (tiling) |
| **SDDM** | Graphical login |
| **Waybar** | Status bar (workspaces, audio, CPU/RAM, updates, cava, clock) |
| **wofi** | App launcher (**Super+F**) |
| **polkit-kde-agent** | Permission prompts for GUI apps |
| **xdg-desktop-portal-hyprland** | Screenshare, portals for sandboxed apps |
| **nwg-look** | GTK/Qt theme tweaks |
| **Adwaita-dark** + **Papirus-Dark** | Default GTK/icons (via gsettings) |

### Terminal & shell

| Piece | Role |
|-------|------|
| **Ghostty** | Default terminal (AUR) |
| **tmux** | Multiplexer; prefix **Ctrl+Space** |
| **zsh** | Login shell; config in **`shell/zshrc`** |
| **starship** | Shell prompt (**`starship.toml`**) |
| **fzf** | Fuzzy finder (tmux sessions, etc.) |

### Editor & dev tools

| Piece | Role |
|-------|------|
| **Neovim ≥ 0.11** | Editor; Lazy + Mason + LSP (see **docs/neovim.md**) |
| **git**, **gcc**, **cmake**, **make**, **python** | Build & version control |
| **ripgrep**, **fd** | Search / find |
| **eza**, **bat** | `ls` / cat-style viewing (used from zsh aliases) |
| **nodejs/npm** | Optional; Neovim markdown preview plugin |

### Audio & media

| Piece | Role |
|-------|------|
| **PipeWire** + **WirePlumber** | Audio (user session enabled by installer) |
| **pamixer** | CLI volume (bound in Hyprland) |
| **wob** | On-screen volume bar |

### Power / memory (installer)

| Piece | Role |
|-------|------|
| **zram-generator** | Compressed RAM swap (reboot once to activate) |
| **sysctl profile** | Lower swappiness, NMI watchdog off, etc. |
| **thermald** | Intel thermal management |
| **earlyoom** | Avoid full RAM freeze (disable if unwanted — see **docs/system-optimization.md**) |

### Browser & apps

| Piece | Role |
|-------|------|
| **Firefox** | **Super+B** |
| **Dunst** | Notifications |
| **swaylock** | **Super+Shift+L** |
| **hyprshot** | Screenshots (**Super+U** / **Super+L**) |
| **cliphist** + **wl-clipboard** | Clipboard history daemon |
| **mesa** (+ Intel Vulkan/VA-API when available) | Graphics stack |

### Optional (flags / AUR)

| Piece | How |
|-------|-----|
| **Claude Code** | `bash install.sh --claude-code` → **[docs/claude-code.md](docs/claude-code.md)** |
| **wl-screenrec** | AUR if install succeeds → **Super+Y** record |

---

## How to use this setup (day to day)

### Workflow sketch

1. **Log in** → Hyprland loads **Waybar**, **Dunst**, **wob** pipe.
2. **Super+Enter** → **Ghostty** with **tmux** session **`main`** (persistent shell loop).
3. **Super+F** → **wofi** to launch apps; **Super+B** → **Firefox**.
4. Use **workspaces 11–18** (**Super+R S T…**) for main tasks; **Super+Alt+1–9** for extra numbered desks.
5. Code in **nvim** inside tmux (or **Super+Ctrl+Enter** for a plain terminal tab).
6. **Super+Shift+M** to **exit Hyprland** (logout).

### Things you should know

| Topic | Notes |
|-------|--------|
| **Profiles** | Default = low-power. **`--performance`** = eye-candy + skip zram/earlyoom. **docs/system-optimization.md**. |
| **tmux prefix** | **Ctrl+Space** then **I** for TPM. If IME uses Ctrl+Space, switch IME hotkey or use `Ctrl+b` in tmux.conf. |
| **zsh config** | Edit **`shell/zshrc`** in the repo (symlinked). Add secrets via **`~/.zshrc.local`** (see **docs/zsh-and-starship.md**). |
| **Neovim first run** | Wait for Lazy; run **`:Mason`** for language servers. |
| **Updates** | Waybar shows pacman pending count; click for `checkupdates` in terminal. |
| **Theming** | Run **nwg-look** if GTK apps look wrong. |

### Hyprland shortcuts (cheat sheet)

| Keys | Action |
|------|--------|
| **Super+Enter / Shift+Enter / Ctrl+Enter** | Ghostty (+ tmux variants) |
| **Super+F** | wofi |
| **Super+B** | Firefox |
| **Super+Shift+M** | Exit Hyprland |
| **Super+R S T X C D G V** | Workspaces 11–18 |
| **Super+Alt+1–9** | Workspaces 1–9 |
| **Super+HJKL** | Focus windows |
| **Super+3 / 4** | Fullscreen / float |
| **Super+W P** | Volume; **Super+2** mute |
| **Super+U L** | Screenshot region / output |
| **Super+Shift+L** | Lock screen |

Full tables: **[docs/hyprland.md](docs/hyprland.md)**.

---

## Repo layout (what maps where)

| In repo | On machine |
|---------|------------|
| `hypr/` | `~/.config/hypr/` |
| `waybar/` | `~/.config/waybar/` |
| `wofi/` | `~/.config/wofi/` |
| `ghostty/` | `~/.config/ghostty/` |
| `tmux/` | `~/.config/tmux/` |
| `nvim/` | `~/.config/nvim/` |
| `dunst/` | `~/.config/dunst/` |
| `scripts/` | `~/.config/scripts/` |
| `shell/zshrc`, `shell/zprofile` | `~/.zshrc`, `~/.zprofile` |
| `starship.toml` | `~/.config/starship.toml` |

Edit files **in the repo** and re-run **`install.sh`** (or refresh symlinks) so changes apply; existing non-symlink configs are backed up to **`.bak`**.

---

## Documentation (in depth)

| Doc | Topic |
|-----|--------|
| **[docs/README.md](docs/README.md)** | Index of all docs |
| **[docs/hyprland.md](docs/hyprland.md)** | Compositor, workspaces, all keybindings |
| **[docs/tmux.md](docs/tmux.md)** | Prefix, TPM, splits, sessionizer |
| **[docs/neovim.md](docs/neovim.md)** | Plugins, Mason, keymaps |
| **[docs/waybar-and-wofi.md](docs/waybar-and-wofi.md)** | Bar modules, wofi |
| **[docs/ghostty.md](docs/ghostty.md)** | Terminal config |
| **[docs/zsh-and-starship.md](docs/zsh-and-starship.md)** | Shell & prompt |
| **[docs/system-audio-gui.md](docs/system-audio-gui.md)** | SDDM, PipeWire, GTK, portals |
| **[docs/desktop-utilities.md](docs/desktop-utilities.md)** | Dunst, wob, screenshots, scripts |
| **[docs/claude-code.md](docs/claude-code.md)** | Optional Claude CLI |
| **[docs/system-optimization.md](docs/system-optimization.md)** | Low-power tuning, re-enable blur/cava |

---

## Troubleshooting

- **Waybar won’t start** — remove **cava** from **`waybar/config`** (see **docs/waybar-and-wofi.md**).
- **Neovim LSP errors** — need **Neovim 0.11+**; run **`:Mason`**.
- **paru build fails** — see [AUR helpers](https://wiki.archlinux.org/title/AUR_helpers).

**Cord.nvim** (Discord presence) is **disabled** in **`nvim/lua/plugins/init.lua`** — enable if you want it.

**Upstream reference** (gitignored): clone into **`reference/angelofallars-dotfiles/`** to diff against [angelofallars/dotfiles](https://github.com/angelofallars/dotfiles).
