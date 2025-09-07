return {
    "folke/zen-mode.nvim",
    opts = {
        window = {
            width = 80,
            options = {
                number = false,
                relativenumber = false,
            },
        }
    },
    config = function()
        require('zen-mode').setup()
        
        vim.keymap.set('n', "<leader>zm", "<cmd>ZenMode<cr>")
    end,
}
