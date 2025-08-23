-- Plugin manifest
require("lazy").setup({
  -- Pull in plugins from custom files
  {import = "plugin"},
  {import = "plugin.lang"},
--Themes
  {'EdenEast/nightfox.nvim', 
    lazy=false,
    init = function()
      vim.cmd.colorscheme "carbonfox"
    end,
    config = function(opts)
      require('nightfox').setup({
        options = {
            transparent = true,
        },
        specs = {
          all = {
            syntax = {
              comment = "white.dim"
            }
          }
        },
        groups = {
            all = {
                CursorLine = { bg = "#070707"}
            }
        }
      })
    end
  },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000,
  --   init = function()
  --     vim.cmd.colorscheme "catppuccin"
  --   end,
  --   config = function(opts)
  --     require('catppuccin').setup({
  --       flavour="mocha",
  --       background = {
  --         light = "latte",
  --         dark = "mocha"
  --       },
  --       transparent_background = false,
  --       show_end_of_buffer=true,
  --       integrations = {
  --         nvimtree = true,
  --         treesitter = true,
  --       },
  --       highlight_overrides =  {
  --         mocha = function(mocha)
  --           return {
  --             Comment = {fg = mocha.lavender}
  --           }
  --         end
  --       }
  --     })
  --   end
  -- }, -- Lovely pastel theme

-- UI
  {'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    
    -- Fast statusbar plugin
    opts = {},
    config = function(opts)
      require('lualine').setup {
          options = {
              -- Default arrow separators
              --component_separators = { left = '', right = ''},
              --section_separators = { left = '', right = ''},
              --component_separators = { left = '', right = ''},
              component_separators = { left = '|', right = '|'},
              section_separators = { left = '', right = ''},
          }
      }
    end
  },

-- Syntax
  {'nvim-treesitter/nvim-treesitter', 
    build = ':TSUpdate', 
    opts={highlight={enable=true}},
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          "c",
          "cpp",
          "bash",
          "python",
          "clojure"
        },
        highlight = {
          enable = true
        },
      })
    end

  },

-- Quality of Life
  {'nvim-telescope/telescope.nvim', dependencies={'nvim-lua/plenary.nvim', 'stevearc/conform.nvim'}},
  {'windwp/nvim-autopairs'},
  {'gelguy/wilder.nvim', build = ":UpdateRemotePlugins"},
  {'nvim-tree/nvim-tree.lua', 
    dependencies={'nvim-tree/nvim-web-devicons'},
    config = function()
      -- Overrides netrw as the default file explorer
      -- By tricking nvim into thinking it's already loaded
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end
  },
  {'tanvirtin/vgit.nvim', dependenceis={'nvim-lua/plenary.nvim'}}, -- Git visualising
  {'tpope/vim-fugitive'}, -- Nice conflict resolution
  {'voldikss/vim-floaterm',
      config = function()
          vim.g.floaterm_giteditor = false
      end
  }, -- Floating terminals
  {'artemave/workspace-diagnostics.nvim'}, -- Allow workspace diagnostics for LSP

-- LSP
  {"neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
    lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
    dependencies = {
      -- main one
      { "ms-jpq/coq_nvim", branch = "coq" },

      -- 9000+ Snippets
      { "ms-jpq/coq.artifacts", branch = "artifacts" },

      -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
      -- Need to **configure separately**
      { 'ms-jpq/coq.thirdparty', branch = "3p" }
      -- - shell repl
      -- - nvim lua api
      -- - scientific calculator
      -- - comment banner
      -- - etc
    },
    init = function()
      vim.g.coq_settings = {
          auto_start = 'shut-up', -- if you want to start COQ at startup
          -- Your COQ settings here
      }
    end,
    config = function()
      -- Your LSP settings here
    end,
  },
  {'ranjithshegde/ccls.nvim'},
  {'nvim-lua/plenary.nvim'},
  {'joechrisellis/lsp-format-modifications.nvim'},
})

