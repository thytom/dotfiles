return {
  'echasnovski/mini.nvim',
  version   = '*',
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  config = function()
      require('mini.ai').setup()
      require('mini.surround').setup()
      require('mini.pairs').setup()
      require('mini.indentscope').setup()
      require('mini.completion').setup()
      require('mini.cmdline').setup()
      require('mini.tabline').setup()
      require('mini.git').setup()
      require('mini.diff').setup()
      require('mini.icons').setup()
      require('mini.statusline').setup()
      require('mini.splitjoin').setup()
      require('mini.align').setup()
      hipatterns = require('mini.hipatterns')
      hipatterns.setup({
            highlighters = {
                -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
                todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
                note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

                -- Highlight hex color strings (`#rrggbb`) using that color
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
      })
  end,
}
