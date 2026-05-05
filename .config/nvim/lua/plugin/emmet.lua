-- Emmet lets you expand html stuff with a nice shorthand (div > div + a*3)
return {
	"mattn/emmet-vim",
	ft = { "html", "css", "scss", "vue", "jsx", "tsx", "javascriptreact", "typescriptreact" },
	init = function()
		vim.g.user_emmet_leader_key = "<C-y>" -- default, trigger is then <C-y>,
		-- vim.g.user_emmet_mode = "i"          -- uncomment to limit to insert mode
	end,
}
