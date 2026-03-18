# Neovim

**Config:** `nvim/` → `~/.config/nvim/`

Neovim is the editor. This setup uses **lazy.nvim** for plugins and expects **Neovim ≥ 0.11** (LSP uses `vim.lsp.enable`).

## First launch

1. Run `**nvim`**.
2. **lazy.nvim** bootstraps and installs plugins (can take a few minutes).
3. Run `**:Mason`** and install language servers you need (e.g. **lua_ls**, **rust_analyzer**; TypeScript often via **typescript-tools.nvim**). **C#** uses **csharp-ls** installed as a dotnet global tool by **install.sh** — no Mason step needed.

**Markdown preview** needs **Node** + first-time `npm install` inside the plugin — install **nodejs/npm** from pacman if you use it.

## Highlights


| Area   | Plugins / behavior                                                                |
| ------ | --------------------------------------------------------------------------------- |
| Theme  | Catppuccin Mocha                                                                  |
| LSP    | nvim-lspconfig + Mason; many servers pre-declared in `lua/plugins/config/lsp.lua` |
| Rust   | rustaceanvim                                                                      |
| C#     | csharp_ls (dotnet global tool) + csharpls-extended-lsp.nvim for decompiled go-to-def |
| TS/JS  | typescript-tools.nvim                                                             |
| Format | conform.nvim (on save)                                                            |
| Lint   | nvim-lint                                                                         |
| Files  | oil.nvim (floating file browser), nvim-tree                                       |
| Fuzzy  | telescope + fzf-native                                                            |
| Git    | gitsigns, fugitive, git-blame                                                     |
| UI     | lualine, barbecue (navic), dressing, notify                                       |


## Common keys

**Leader** = **Space** (see `**lua/core/keymaps.lua`**).


| Key                         | Action                                      |
| --------------------------- | ------------------------------------------- |
| **Ctrl+p**                  | Telescope git files                         |
| **Ctrl+f**                  | Live grep from git root                     |
| **Ctrl+n**                  | Toggle **nvim-tree** (from git root or cwd) |
| **Space ff / fg / fb / fh** | Files / live grep / buffers / help          |
| **Space+y / p**             | Yank/paste system clipboard                 |
| **Space+J**, **jj**         | Fugitive **Git**                            |
| **Space+jm** etc.           | Git commit, status, log, diff               |


**LSP** (after server attaches): **gd**, **gr** (Telescope refs), **K** hover, **Space+e** diagnostic float — see `**lua/plugins/config/lsp.lua`**.

**Open file in browser:** **Space+l** runs `**librewolf`** on current file; change to `**firefox**` in `**keymaps.lua**` if you want.

## Disabling Discord RPC

**Cord.nvim** is off by default. Enable in `**nvim/lua/plugins/init.lua`** (`enabled = true` on the cord entry).

## Clipboard

Wayland clipboard is set in `**lua/core/options.lua**` (`wl-copy` / `wl-paste`).

## Learn more

- `:help`
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason](https://github.com/williamboman/mason.nvim)

