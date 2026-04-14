return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      c = { "clang-format" },
      cpp = { "clang-format" },
      lua = { "stylua" },
      nix = { "nixfmt" },
      rust = { "rustfmt" }
    },

    default_format_opts = {
      lsp_format = "fallback",
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

    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        local formatters = require("conform").list_formatters_for_buffer()
        if #formatters == 0 then
          vim.bo.formatexpr = ""
        end
      end,
    })
  end,
}
