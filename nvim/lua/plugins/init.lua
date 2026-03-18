require("lazy").setup({

  -- ── Theme ───────────────────────────────────────────────
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          nvimtree     = true,
          telescope    = true,
          treesitter   = true,
          gitsigns     = true,
          indent_blankline = { enabled = true },
          mini         = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- ── tmux/neovim seamless navigation ─────────────────────
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft", "TmuxNavigateDown",
      "TmuxNavigateUp",   "TmuxNavigateRight",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
  },

  -- ── File tree ───────────────────────────────────────────
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFileToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
      })
    end,
  },

  -- ── Fuzzy finder ────────────────────────────────────────
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
          layout_config = { prompt_position = "top" },
        },
      })
      require("telescope").load_extension("fzf")
    end,
  },

  -- ── Statusline ──────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          globalstatus = true,
        },
      })
    end,
  },

  -- ── Treesitter ──────────────────────────────────────────
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "bash", "markdown",
          "javascript", "typescript", "css", "html",
          "json", "rust", "go", "python", "c",
        },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent    = { enable = true },
      })
    end,
  },

  -- ── Git signs ───────────────────────────────────────────
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "▎" },
          change       = { text = "▎" },
          delete       = { text = "" },
          topdelete    = { text = "" },
          changedelete = { text = "▎" },
        },
      })
    end,
  },

  -- ── Git fugitive ────────────────────────────────────────
  { "tpope/vim-fugitive" },

  -- ── Autopairs ───────────────────────────────────────────
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- ── Comments ────────────────────────────────────────────
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = false,
  },

  -- ── Indent guides ───────────────────────────────────────
  {
    "nvim-mini/mini.indentscope",
    version = "*",
    config = function()
      require("mini.indentscope").setup({
        symbol = "▏",
        draw = {
          delay = 0,
          animation = require("mini.indentscope").gen_animation.none(),
        },
        options = { try_as_border = true },
      })
    end,
  },

  -- ── LSP ─────────────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim",            opts = {} },
      { "mason-org/mason-lspconfig.nvim",  opts = {} },
    },
    config = function()
      local lsp = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Add LSP servers here as needed:
      -- lsp.lua_ls.setup({ capabilities = capabilities })
      -- lsp.ts_ls.setup({ capabilities = capabilities })
      -- lsp.rust_analyzer.setup({ capabilities = capabilities })
    end,
  },

  -- ── Autocompletion ──────────────────────────────────────
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind-nvim",
    },
    config = function()
      local cmp    = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        formatting = {
          format = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"]   = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]   = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]   = cmp.mapping.abort(),
          ["<CR>"]    = cmp.mapping.confirm({ select = true }),
          ["<Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- ── Color highlighter ───────────────────────────────────
  {
    "catgoose/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- ── Notifications ───────────────────────────────────────
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        render = "wrapped-compact",
        minimum_width = 40,
      })
      vim.notify = require("notify")
    end,
  },

  -- ── Better UI inputs ────────────────────────────────────
  {
    "stevearc/dressing.nvim",
    opts = {},
  },

})
