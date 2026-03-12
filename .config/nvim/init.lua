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

require "keybinds"

-- POST-PLUGIN CONFIGURATIONS

-- Doxygen highlighting in C/C++
vim.api.nvim_create_autocmd({"BufEnter"}, {
  pattern = {"*.c", "*.h", "*.cc", "*.cpp", "*.hh", "*.hpp"},
  command = "set syntax=cpp.doxygen"
})
