vim.g.mapleader=',' -- Must be defined at the top

require "options" -- vim.o configuration

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

require "plugins"

require "config/lsp-setup"

---- PLUGIN CONFIGURATION
require('nvim-autopairs').setup{}

require("conform").setup({
  formatters_by_ft = {
    python = { "isort" },
  },
})

vim.keymap.set("", "<leader>mp", function()
  require("conform").format({ async = true }, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
      end
    end
  end)
end, { desc = "Format code" })

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

require "keybinds"

-- POST-PLUGIN CONFIGURATIONS

-- Doxygen highlighting in C/C++
vim.api.nvim_create_autocmd({"BufEnter"}, {
  pattern = {"*.c", "*.h", "*.cc", "*.cpp", "*.hh", "*.hpp"},
  command = "set syntax=cpp.doxygen"
})
