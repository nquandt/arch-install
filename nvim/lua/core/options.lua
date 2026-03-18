-- ── Indentation ───────────────────────────────────────────
vim.opt.expandtab   = true
vim.opt.tabstop     = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth  = 2
vim.opt.smartindent = true
vim.opt.autoindent  = true

-- Per-filetype overrides
vim.cmd([[
  autocmd FileType go         setlocal shiftwidth=4 tabstop=4 noexpandtab
  autocmd FileType c          setlocal shiftwidth=4 tabstop=4
  autocmd FileType lua        setlocal shiftwidth=2 tabstop=2
  autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
  autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
  autocmd FileType json       setlocal shiftwidth=2 tabstop=2
  autocmd FileType markdown   setlocal shiftwidth=2 tabstop=2 textwidth=100
  autocmd FileType html       setlocal shiftwidth=2 tabstop=2
  autocmd FileType css        setlocal shiftwidth=2 tabstop=2
  autocmd FileType scss       setlocal shiftwidth=2 tabstop=2
]])

-- ── UI ────────────────────────────────────────────────────
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true
vim.opt.cursorlineopt  = "number"
vim.opt.numberwidth    = 2
vim.opt.signcolumn     = "yes"
vim.opt.wrap           = false
vim.opt.scrolloff      = 8
vim.opt.showmode       = false
vim.opt.termguicolors  = true
vim.opt.cmdheight      = 1

vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.fillchars = vim.opt.fillchars + "vert:▏"

-- ── Search ────────────────────────────────────────────────
vim.opt.ignorecase = true
vim.opt.smartcase  = true

-- ── Files ─────────────────────────────────────────────────
vim.opt.swapfile = false
vim.opt.undofile = true

-- ── Performance ───────────────────────────────────────────
vim.opt.updatetime  = 250
vim.opt.timeoutlen  = 300

-- ── Completion ────────────────────────────────────────────
vim.opt.completeopt = "menuone,noselect"

-- ── Clipboard (Wayland) ───────────────────────────────────
vim.opt.clipboard = "unnamedplus"
vim.g.clipboard = {
  name  = "wl-clipboard",
  copy  = { ["+"] = "wl-copy", ["*"] = "wl-copy" },
  paste = { ["+"] = "wl-paste", ["*"] = "wl-paste" },
  cache_enabled = 0,
}

-- ── Misc ──────────────────────────────────────────────────
vim.opt.mouse      = "a"
vim.opt.compatible = false
vim.g.netrw_banner = 0
vim.cmd([[filetype plugin on]])
