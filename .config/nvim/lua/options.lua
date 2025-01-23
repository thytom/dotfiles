-- OPTIONS
--
-- Contains all vim.o settings
--
---- NEOVIM GENERAL CONFIGURATION
vim.o.mouse="a"
vim.o.hlsearch=false
vim.o.number=true
vim.o.expandtab=true
vim.o.smartindent=true
vim.o.shiftwidth=4
vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.encoding="utf8"
vim.o.history=5000
vim.o.cursorline=true
vim.o.formatoptions="tcr"
vim.o.ttyfast=true
vim.o.lazyredraw=true
vim.o.showtabline = 2
vim.o.relativenumber = true
vim.o.listchars="tab:>-,trail:~,space:•"
vim.opt.foldmethod="syntax"
vim.opt.foldlevel=99

-- Nicer indentation for case statements
vim.o.cinoptions="l1"

-- Enable highlight groups
vim.opt.termguicolors=true

vim.o.updatetime = 300
vim.o.incsearch = false
vim.wo.signcolumn = 'yes'
