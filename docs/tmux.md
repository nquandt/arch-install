# tmux

**Config:** `tmux/tmux.conf` → `~/.config/tmux/tmux.conf`

tmux multiplexes terminals: many windows/panes in one Ghostty window.

## Prefix

Default prefix is **Ctrl+b**; this config uses **Ctrl+Space** (thumb-friendly). **Ctrl+Space** twice sends a literal prefix to a nested tmux or app.

- Press **Ctrl+Space** then a command key (e.g. **Ctrl+Space** **%** for a vertical split).

## First run — install plugins

1. Open tmux (e.g. **Super+Enter** from Hyprland).
2. Press **Ctrl+Space** then **Shift+i** (capital **I**) — **TPM** installs plugins.

Plugins include **tmux-fzf** for fuzzy session switching.

## Useful keys (after prefix Ctrl+Space)


| Key                   | Action                      |
| --------------------- | --------------------------- |
| **%**                 | Split horizontal            |
| **"**                 | Split vertical              |
| **r** / **Ctrl+r**    | fzf session switcher        |
| **PageUp / PageDown** | Window nav (custom scripts) |
| **h**                 | Toggle status bar           |
| **F7**                | Copy mode                   |
| **F8**                | Tree view                   |


**Copy mode** is vi-style: **v** to select, **y** to copy (integrate with Wayland clipboard if your build supports it).

## Default shell

Every new pane uses `**/usr/bin/zsh`** (see `set -g default-shell` in the config).

## Hyprland integration

- **Super+Enter** runs `new_tmux_terminal.sh` → attaches to tmux session `**main`** (or creates it with `zsh-forever.sh`).
- **Super+Shift+Enter** runs `new_tmux_session_temporary.sh` → loop that starts a **new** session each time you exit attach.

## Sessionizer

**Ctrl+Space** **t** opens `**my-tmux-sessionizer`** — fzf over `~/repos`, `~/projects`, `~/code`, `~/dev`, `~/src`; creates a named tmux session per folder with nvim + shell window. Adjust paths in `scripts/my-tmux-sessionizer` if needed.

## Config in repo

Edit `**tmux/tmux.conf**` in the repo; symlink updates apply on next `tmux source-file` or new server.

- [tmux wiki](https://github.com/tmux/tmux/wiki)

