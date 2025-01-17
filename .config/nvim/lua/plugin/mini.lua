return {
  'echasnovski/mini.nvim',
  version   = '*',
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  config = function()
      require('mini.ai').setup()
  end,
}
