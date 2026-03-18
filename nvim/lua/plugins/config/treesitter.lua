require("nvim-treesitter").setup({})

-- ensure parsers are installed (replaces old ensure_installed option)
require("nvim-treesitter.install").install({
	"c",
	"rust",
	"javascript",
	"typescript",
	"css",
	"scss",
	"python",
	"bash",
	"lua",
	"go",
	"gomod",
	"gosum",
	"gowork",
	"vim",
	"cpp",
	"http",
})
