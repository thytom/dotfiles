-- Plugin manifest
require("lazy").setup({
  -- Pull in plugins from custom files
  { import = "plugin" },
  { import = "plugin.lang" },
  --Themes
  {
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
  },

  -- Syntax
  {
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
  },

  -- Quality of Life
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim", "stevearc/conform.nvim" } },

  -- LSP
  {
    "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
    lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
    config = function()
      -- Your LSP settings here
    end,
  },
  { "nvim-lua/plenary.nvim" },
  { "joechrisellis/lsp-format-modifications.nvim" },
})
