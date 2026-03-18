vim.g.mapleader = " "

local map = vim.keymap.set

-- ── Telescope ─────────────────────────────────────────────
map("n", "<C-p>",     "<cmd>lua require('telescope.builtin').git_files({ show_untracked = true })<cr>")
map("n", "<C-f>",     "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>ff","<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>fg","<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>fb","<cmd>lua require('telescope.builtin').buffers()<cr>")
map("n", "<leader>fh","<cmd>lua require('telescope.builtin').help_tags()<cr>")

-- ── File tree ─────────────────────────────────────────────
map("n", "<C-n>", ":NvimTreeToggle<CR>")
map("n", "<leader>e", ":NvimTreeToggle<CR>")

-- ── Splits ────────────────────────────────────────────────
map("n", "<leader>sv", ":vsplit<CR>")
map("n", "<leader>sh", ":split<CR>")
map("n", "<C-w>u",     "<C-w>q")

-- ── Buffers ───────────────────────────────────────────────
map("n", "<Tab>",   ":bnext<CR>")
map("n", "<S-Tab>", ":bprev<CR>")

-- ── Clipboard ─────────────────────────────────────────────
map("n", "<leader>y", '"+y')
map("n", "<leader>Y", '"+yg_')
map("n", "<leader>p", '"+p')
map("n", "<leader>P", '"+P')
map("v", "<leader>y", '"+y')

-- ── Git (fugitive) ────────────────────────────────────────
map("n", "<leader>J",  "<cmd>Git<cr>")
map("n", "<leader>ja", "<cmd>Git add %<cr>")
map("n", "<leader>jm", "<cmd>Git commit<cr>")
map("n", "<leader>js", "<cmd>Git status<cr>")
map("n", "<leader>jl", "<cmd>Git log<cr>")
map("n", "<leader>jd", "<cmd>Git diff %<cr>")

-- ── Misc ──────────────────────────────────────────────────
map("n", "<C-c>", ":noh<CR>:<Esc>")

-- ── tmux-navigator (Ctrl+H/J/K/L) handled by plugin ──────
