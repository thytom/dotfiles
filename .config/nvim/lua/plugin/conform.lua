return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      nix = { "nixfmt" },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)

    -- function to format a range of lines
    function _G.format_range()
      local start_pos = vim.api.nvim_buf_get_mark(0, "<") -- start of visual or operator selection
      local end_pos = vim.api.nvim_buf_get_mark(0, ">") -- end of visual or operator selection

      require("conform").format({
        async = true,
        lsp_fallback = true,
        range = {
          start = { start_pos[1], 0 },
          ["end"] = { end_pos[1], 0 },
        },
      })
    end

    -- visual mode keymap
    vim.keymap.set("v", "<leader>cf", format_range, { desc = "Format selection with Conform" })

    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
