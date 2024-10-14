---- GENERAL KEYBINDS 
---
--- Additional keybinds may be defined in lang/, but those might only be
--- enabled when the language is enabled.

vim.keymap.set('n', '<ctrl>t', '<cmd>tabnew<cr>')

-- Splitting 
vim.keymap.set('n', '_', '<cmd>split<cr>')
vim.keymap.set('n', [[|]], '<cmd>vsplit<cr>') -- Doesn't like | appearing in a normal string

-- nvim-tree
vim.keymap.set('n', '<Space>t', '<cmd>NvimTreeFocus<cr>')

-- voldikss/vim-floaterm
vim.keymap.set('n', '<leader>t', '<cmd>FloatermToggle<cr>')

-- Quick Buffer Switching
vim.keymap.set('n', 'gn', '<cmd>bnext<cr>')
vim.keymap.set('n', 'gp', '<cmd>bprev<cr>')

-- fugitive
-- vim.keymap.set('n', '<leader>cfl', '<cmd>Gvdiffsplit!<cr>')
-- vim.keymap.set('n', 'gdh', '<cmd>diffget //2<cr>')
-- vim.keymap.set('n', 'gdl', '<cmd>diffget //3<cr>')

-- Telescope
vim.keymap.set('n', '<space>f', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<space>g', '<cmd>Telescope git_files<cr>')
vim.keymap.set('n', '<space>b', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<space>r', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<space>d', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<space>s', '<cmd>Telescope lsp_document_symbols<cr>')

-- Tabby
vim.keymap.set('n', '<shift><tab>', '<cmd>Tabby jump_to_tab<cr>')

-- Persistence
-- load the session for the current directory
vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end)

-- select a session to load
vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end)

-- load the last session
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end)

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end)

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
