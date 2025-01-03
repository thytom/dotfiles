return {
    'folke/todo-comments.nvim',
    event = 'VimEnter', -- if you want lazy load, see below
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("todo-comments").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    end
}
