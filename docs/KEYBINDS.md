# All shortcuts (cheat sheet)

**Super** = Windows / Command key (Hyprland mod).  
**Leader** (Neovim) = **Space**.

Configs can drift; this matches the repo as written. Hyprland extras may live in `hyprland.local.conf`.

---

## Hyprland

### Apps & session

| Keys | Action |
|------|--------|
| **Super+Enter** | Ghostty → tmux session `main` |
| **Super+Shift+Enter** | Ghostty → new tmux session loop |
| **Super+Ctrl+Enter** | Ghostty (no tmux script) |
| **Super+Q** | Close focused window |
| **Super+Shift+M** | Exit Hyprland (logout) |
| **Super+F** | wofi (app launcher) |
| **Super+B** | Firefox |

### Window layout

| Keys | Action |
|------|--------|
| **Super+3** | Fullscreen |
| **Super+4** | Toggle floating |
| **Super+H / J / K / L** | Focus left / down / up / right |
| **Super+N** | Next window |
| **Super+E** | Previous window |
| **Super+Shift+N** | Swap with next |
| **Super+Shift+E** | Swap with previous |
| **Super+M** | Shrink master ratio |
| **Super+I** | Grow master ratio |
| **Super+drag (LMB)** | Move window |
| **Super+drag (RMB)** | Resize window |
| **Super+Shift+click (middle)** | Kill window |

### Workspaces (labeled bar: 一 二 三 …)

| Keys | Workspace |
|------|-----------|
| **Super+R** | 11 |
| **Super+S** | 12 |
| **Super+T** | 13 |
| **Super+X** | 14 |
| **Super+C** | 15 |
| **Super+D** | 16 |
| **Super+G** | 17 |
| **Super+V** | 18 |
| **Super+Ctrl+R … V** | Move window to 11–18 |
| **Super+Alt+1–9** | Workspaces 1–9 |
| **Super+scroll** | Previous / next workspace |

### Audio & screenshots

| Keys | Action |
|------|--------|
| **Super+W** | Volume down (+ wob bar) |
| **Super+P** | Volume up |
| **Super+2** | Mute |
| **Super+U** | Screenshot region (hyprshot) |
| **Super+L** | Screenshot full output |
| **Super+Y** | Toggle screen record (wl-screenrec, if installed) |

### Other

| Keys | Action |
|------|--------|
| **Super+Shift+L** | Lock screen (swaylock) |
| **Super+Shift+Z** | Keyboard layout script |

### wofi (launcher)

- Type to filter → **Enter** to launch.
- **Esc** to close.

---

## tmux

**Prefix** = **Ctrl+Space** (then release, then press the next key).  
**Ctrl+Space** twice = send literal Ctrl+Space to the program inside.

### After prefix

| Keys | Action |
|------|--------|
| **Prefix I** | TPM: install plugins (capital **I**) |
| **Prefix %** | Split pane vertical (left / right) |
| **Prefix "** | Split pane horizontal (top / bottom) |
| **Prefix t** | Popup: project sessionizer (fzf) |
| **Prefix h** | Toggle status bar |
| **Prefix C-r** or **Prefix r** | fzf session switcher |
| **Prefix i** | Tile panes (script) |
| **Prefix N** | Swap window with next |
| **Prefix E** | Swap window with previous |

### Without prefix (global)

| Keys | Action |
|------|--------|
| **F7** | Copy mode |
| **F8** | Session / window tree |
| **PageDown** | Next window (+ pane script) |
| **PageUp** | Previous window (+ pane script) |
| **Home** | New window (script) |
| **End** | Kill window (confirm) |

### Copy mode (vi)

| Keys | Action |
|------|--------|
| **v** | Begin selection |
| **y** | Copy selection & exit |

**Mouse**: on — click to select panes, drag borders.

---

## Neovim

**Leader** = **Space**.

### Files & search

| Keys | Action |
|------|--------|
| **Ctrl+p** | Telescope: git files (untracked on) |
| **Ctrl+p** | In `*/.config/*` buffers: git files (untracked off) |
| **Ctrl+f** | Live grep from git root (or cwd if not git) |
| **Ctrl+n** | Toggle nvim-tree (from git root or `.`) |
| **Space ff** | Find files |
| **Space fg** | Live grep (ivy theme) |
| **Space fb** | Buffers |
| **Space fh** | Help tags |

### Clipboard

| Keys | Action |
|------|--------|
| **Space y** | Yank to system clipboard (normal / visual) |
| **Space Y** | Yank line to `+` |
| **Space p** | Paste after |
| **Space P** | Paste before |

### Git (Fugitive + Gitsigns)

| Keys | Action |
|------|--------|
| **Space J** / **Space jj** | `:Git` |
| **Space ja** | `git add %` |
| **Space jm** | `git commit` |
| **Space js** | `git status` |
| **Space jl** | `git log` |
| **Space jd** | `git diff %` |
| **Space l** | Open current file in **librewolf** (change to firefox in config if you want) |
| **]c** / **[c** | Next / previous hunk (Gitsigns) |
| **Space hs** / **Space hu** | Stage / reset hunk (visual: selection) |
| **Space hS** | Stage buffer |
| **Space hr** | Undo stage hunk |
| **Space hU** | Reset buffer |
| **Space hp** | Preview hunk |
| **Space hb** | Blame line (full) |
| **Space tb** | Toggle line blame |
| **Space hd** / **Space hD** | Diff / diff `~` |
| **Space td** | Toggle deleted |
| **ih** (operator) | Select hunk |

### LSP (when server attached)

| Keys | Action |
|------|--------|
| **gd** | Go to definition |
| **gD** | Type definition |
| **gr** | References (Telescope) |
| **gs** | Workspace symbols (Telescope) |
| **gi** | Implementations (Telescope) |
| **K** | Hover docs |
| **Space e** | Diagnostic float |
| **[d** / **]d** | Prev / next diagnostic |
| **Space rn** | Rename |
| **Space n** | Code actions |
| **Space wa / wr / wl** | Workspace folder add / remove / list |
| **Ctrl+k** (insert) | Signature help |

### Completion (cmp) — insert mode

**Note:** **Ctrl+Space** here is the same chord as the tmux prefix. In Neovim insert mode it triggers completion; in a tmux pane, tmux may grab it first unless you use **Ctrl+Space** twice to pass through, or trigger completion another way.

| Keys | Action |
|------|--------|
| **Ctrl+Space** | Trigger completion |
| **Ctrl+e** | Close completion |
| **Enter** | Confirm |
| **Tab** / **Ctrl+n** | Next item |
| **Shift+Tab** / **Ctrl+p** | Previous item |
| **Ctrl+u / Ctrl+d** | Scroll docs |
| **Ctrl+f / Ctrl+b** | Scroll docs (larger step) |

### Other

| Keys | Action |
|------|--------|
| **Ctrl+c** | Clear search highlight |
| **Ctrl+w u** | Close window (`Ctrl+w q`) |

### nvim-tree (buffer-local)

| Keys | Action |
|------|--------|
| **?** | Help |
| **n / e** | Down / up (colemak-style) |
| **i** | CD into node |
| **Ctrl+c** | Close tree |

---

## Dunst (notifications)

| Keys | Action |
|------|--------|
| **Ctrl+Shift+Space** | Close / close all |
| **Ctrl+`** | History |
| **Ctrl+Shift+.** | Context |

---

## zsh / terminal

| Keys | Action |
|------|--------|
| **Ctrl+C** | Interrupt |
| **Ctrl+D** | EOF / exit |
| **Ctrl+L** | Clear (if bound) |
| **Tab** | Completion |

(Starship prompt only — no extra global binds from this repo.)

---

## Quick reference card

```
Hyprland: Super+Enter terminal  Super+F launcher  Super+B firefox  Super+Shift+M quit
          Super+R–V workspaces 11–18   Super+Alt+1–9 workspaces 1–9

tmux:     Ctrl+Space then I (plugins)  %  "  splits   t sessionizer   F7 copy mode

Neovim:   Space = leader   Ctrl+p files   Ctrl+f grep   Ctrl+n tree   gd gr K LSP
```

← [Documentation index](README.md)
