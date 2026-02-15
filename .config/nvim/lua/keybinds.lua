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
vim.keymap.set('n', '<space><space>', '<cmd>Telescope<cr>')
vim.keymap.set('n', '<space>l', '<cmd>TodoTelescope<cr>')

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
vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, {noremap = true})
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format)

-- Toggle Whitespace
vim.keymap.set("n", "<leader>l", "<cmd>set list!<cr>")


-- Function to check if a floating dialog exists and if not
-- then check for diagnostics under the cursor
function OpenDiagnosticIfNoFloat()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_config(winid).zindex then
            return
        end
    end
    -- THIS IS FOR BUILTIN LSP
    vim.diagnostic.open_float(0, {
        scope = "cursor",
        focusable = false,
        close_events = {
            "CursorMoved",
            "CursorMovedI",
            "BufHidden",
            "InsertCharPre",
            "WinLeave",
        },
    })
end
-- Show diagnostics under the cursor when holding position
vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    command = "lua OpenDiagnosticIfNoFloat()",
    group = "lsp_diagnostics_hold",
})


vim.diagnostic.enable(false)
vim.g["diagnostics_active"] = false
function Toggle_diagnostics()
    if vim.g.diagnostics_active then
        vim.g.diagnostics_active = false
        vim.diagnostic.enable(false)
    else
        vim.g.diagnostics_active = true
        vim.diagnostic.enable(true)
    end
end

vim.keymap.set('n', '<leader>xd', Toggle_diagnostics, { noremap = true, silent = true, desc = "Toggle vim diagnostics" })
