vim.g.mapleader=',' -- Must be defined at the top
vim.g.maplocalleader=',' -- Must be defined at the top

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
