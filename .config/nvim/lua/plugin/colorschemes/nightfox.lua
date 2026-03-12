return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	init = function()
		vim.cmd.colorscheme("carbonfox")
	end,
	config = function(opts)
		require("nightfox").setup({
			options = {
				transparent = true,
			},
			specs = {
				all = {
					syntax = {
						comment = "white.dim",
					},
				},
			},
			groups = {
				all = {
					CursorLine = { bg = "#070707" },
				},
			},
		})
	end,
}
