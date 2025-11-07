return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua",              -- optional
  },
  config = function()
      require('neogit').setup()
  end,
  keys = {
      {"<leader>git", "<cmd>Neogit<cr>", desc="Open neogit"}
  }
}
