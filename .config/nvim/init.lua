vim.g.mapleader=',' -- Must be defined at the top

-- Required to make nvim-tree the default
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

---- NEOVIM GENERAL CONFIGURATION
vim.o.mouse="a"
vim.o.hlsearch=false
vim.o.number=true
vim.o.expandtab=true
vim.o.smartindent=true
vim.o.shiftwidth=2
vim.o.tabstop=2
vim.o.encoding="utf8"
vim.o.history=5000
vim.o.cursorline=true
vim.o.formatoptions="tcr"
vim.o.ttyfast=true
vim.o.lazyredraw=true

-- Enable highlight groups
vim.opt.termguicolors=true

---- LAZY SETUP

-- Install lazy.nvim if it's not already installed. 
-- With this, a fresh neovim install can be set up with plugins in seconds
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin manifest
require("lazy").setup({
-- Themes
  {'famiu/feline.nvim'}, -- Fast statusbar plugin
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 }, -- Lovely pastel theme

-- Syntax
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', opts={highlight={enable=true}}},

-- Quality of Life
  {'nvim-telescope/telescope.nvim', dependencies={'nvim-lua/plenary.nvim'}},
  {'windwp/nvim-autopairs'},
  {'gelguy/wilder.nvim', build = ":UpdateRemotePlugins"},
  {'nvim-tree/nvim-tree.lua', dependencies={'nvim-tree/nvim-web-devicons'}},
  {'tanvirtin/vgit.nvim', dependenceis={'nvim-lua/plenary.nvim'}}, -- Git visualising

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
          auto_start = true, -- if you want to start COQ at startup
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

require('lspconfig').pyright.setup({})

require('lspconfig').clangd.setup(require('coq').lsp_ensure_capabilities({
  cmd = {
    "clangd",
    "--suggest-missing-includes",
    '--query-driver=/usr/toolchains/arm-none-eabi/13/bin/arm-none-eabi-gcc',
    '--query-driver=/usr/toolchains/arm-none-eabi/13/bin/arm-none-eabi-g++',
    '--query-driver=/usr/bin/arm-none-eabi-gcc',
    '--query-driver=/usr/bin/arm-none-eabi-g++',
  }
}))
--require('lspconfig').ccls.setup({
--    lsp = {
--        codelens = {
--            enable = true,
--            events = {"BufWritePost", "InsertLeave"}
--        }
--    },
--    init_options = {
--        compilationDatabaseDirectory = "build";
--        index = {
--           threads = 0;
--        },
--        clang = {
--            excludeArgs = { "-frounding-math"} ;
--        },
--    },
--})

--require('lspconfig').ccls.setup(require('coq').lsp_ensure_capabilities())
--require('lspconfig').clangd.setup(require('coq').lsp_ensure_capabilities())

---- PLUGIN CONFIGURATION
require('nvim-autopairs').setup{}

require('feline').setup({})
require('feline').winbar.setup({})

require("catppuccin").setup({
  flavour="mocha",
  background = {
    light = "latte",
    dark = "mocha"
  },
  transparent_background = false,
  show_end_of_buffer=true,
  integrations = {
    nvimtree = true,
    treesitter = true,
  },
})

local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})
wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    highlighter = wilder.basic_highlighter(),
    min_width = '100%',
    highlights = {
      border = 'Normal', -- highlight to use for the border
    },
    reverse = 1,
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
    border = 'rounded',
  })
))
wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      -- sets the language to use, 'vim' and 'python' are supported
      language = 'python',
      -- 0 turns off fuzzy matching
      -- 1 turns on fuzzy matching
      -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
      fuzzy = 1,
    }),
    wilder.python_search_pipeline({
      -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
      pattern = wilder.python_fuzzy_pattern(),
      -- omit to get results in the order they appear in the buffer
      sorter = wilder.python_difflib_sorter(),
      -- can be set to 're2' for performance, requires pyre2 to be installed
      -- see :h wilder#python_search() for more details
      engine = 're',
    })
  ),
})

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require("nvim-treesitter.install").prefer_git = true

vim.o.updatetime = 300
vim.o.incsearch = false
vim.wo.signcolumn = 'yes'

require('vgit').setup({
      keymaps = {
        ['n <C-k>'] = function() require('vgit').hunk_up() end,
        ['n <C-j>'] = function() require('vgit').hunk_down() end,
        ['n <leader>gs'] = function() require('vgit').buffer_hunk_stage() end,
        ['n <leader>gr'] = function() require('vgit').buffer_hunk_reset() end,
        ['n <leader>gp'] = function() require('vgit').buffer_hunk_preview() end,
        ['n <leader>gb'] = function() require('vgit').buffer_blame_preview() end,
        ['n <leader>gf'] = function() require('vgit').buffer_diff_preview() end,
        ['n <leader>gh'] = function() require('vgit').buffer_history_preview() end,
        ['n <leader>gu'] = function() require('vgit').buffer_reset() end,
        ['n <leader>gg'] = function() require('vgit').buffer_gutter_blame_preview() end,
        ['n <leader>glu'] = function() require('vgit').buffer_hunks_preview() end,
        ['n <leader>gls'] = function() require('vgit').project_hunks_staged_preview() end,
        ['n <leader>gd'] = function() require('vgit').project_diff_preview() end,
        ['n <leader>gq'] = function() require('vgit').project_hunks_qf() end,
        ['n <leader>gx'] = function() require('vgit').toggle_diff_preference() end,
        ['n <leader>gc'] = function() require('vgit').project_commit_preview() end,
      }, }
);

---- KEYBINDS

-- Splitting 
vim.keymap.set('n', '_', '<cmd>split<cr>')
vim.keymap.set('n', [[|]], '<cmd>vsplit<cr>') -- Doesn't like | appearing in a normal string

-- nvim-tree
vim.keymap.set('n', '<Space>t', '<cmd>NvimTreeFocus<cr>')

-- Quick Buffer Switching
vim.keymap.set('n', 'gn', '<cmd>bnext<cr>')
vim.keymap.set('n', 'gp', '<cmd>bprev<cr>')

-- Telescope
vim.keymap.set('n', '<space>f', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<space>g', '<cmd>Telescope git_files<cr>')
vim.keymap.set('n', '<space>b', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<space>r', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<space>d', '<cmd>Telescope diagnostics<cr>')

-- POST-PLUGIN CONFIGURATIONS

vim.cmd.colorscheme "catppuccin"

-- Doxygen highlighting in C/C++
vim.api.nvim_create_autocmd({"BufEnter"}, {
  pattern = {"*.c", "*.h", "*.cc", "*.cpp", "*.hh", "*.hpp"},
  command = "set syntax=cpp.doxygen"
})

-- C/C++ Specific

vim.api.nvim_create_autocmd({"BufEnter"}, {
  pattern = {"*.c", "*.h", "*.cc", "*.cpp", "*.hh", "*.hpp"},
  group = vim.api.nvim_create_augroup('c_only_keymap', { clear = true }),
  callback = function()
    vim.keymap.set('n', 'gh', '<cmd>ClangdSwitchSourceHeader<CR>', {silent = true})
  end
})

vim.keymap.set('n', 'gr', vim.lsp.buf.references, {noremap = true})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {noremap = true})
vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol, {noremap = true})
vim.keymap.set('n', '<ctrl>k', vim.lsp.buf.hover, {noremap = true})
