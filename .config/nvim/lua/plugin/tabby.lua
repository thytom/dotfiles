local theme = {
  fill = 'TabLineFill',       -- tabline background
  head = 'TabLine',           -- head element highlight
  current_tab = 'TabLineSel', -- current tab label highlight
  tab = 'TabLine',            -- other tab label highlight
  win = 'TabLine',            -- window highlight
  tail = 'TabLine',           -- tail element highlight
}

return {
  'nanozuki/tabby.nvim',
   event = 'VimEnter', -- if you want lazy load, see below
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('tabby').setup({
      line = function(line)
        return {
          {
            { '  ', hl = theme.head },
            line.sep('', theme.head, theme.fill),
          },
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
              line.sep('', hl, theme.fill),
              tab.is_current() and '' or '󰆣',
              tab.number(),
              tab.name(),
              tab.close_btn(''),
              line.sep('', hl, theme.fill),
              hl = hl,
              margin = ' ',
            }
          end),
          line.spacer(),
          line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            return {
              line.sep('', theme.win, theme.fill),
              win.is_current() and '' or '',
              win.buf_name(),
              line.sep('', theme.win, theme.fill),
              hl = theme.win,
              margin = ' ',
            }
          end),
          {
            line.sep('', theme.tail, theme.fill),
            { '  ', hl = theme.tail },
          },
          hl = theme.fill,
        }
    end,
    })

    -- Tabby
    vim.keymap.set('n', '<c-t>', '<cmd>tabnew<cr>')
  end,
}
