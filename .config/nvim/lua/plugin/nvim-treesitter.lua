return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = { highlight = { enable = true } },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"cpp",
				"bash",
				"python",
				"clojure",
			},
			highlight = {
				enable = true,
			},
			indent = { enable = true },
		})

		vim.filetype.add({
			extension = {
				gotmpl = "gotmpl",
			},
		})
	end,
}
