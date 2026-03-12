-- Plugin manifest
require("lazy").setup({
  -- Pull in plugins from custom files
  { import = "plugin" },
  { import = "plugin.lang" },
  { import = "plugin.colorschemes" }
  --Themes
  ,

  -- LSP
  {
    "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
    lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
    config = function()
      -- Your LSP settings here
    end,
  },
  { "nvim-lua/plenary.nvim" },
})
