return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  opts = {
    enable_autocmd = false,
  },
  config = function()
    vim.g.skip_ts_context_commentstring_module = true
    require('ts_context_commentstring').setup({ enable_autocmd = false })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'vue',
      callback = function()
        vim.bo.commentstring = '<!-- %s -->' -- fallback
      end,
    })
  end
}
