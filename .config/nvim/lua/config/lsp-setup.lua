-- lsp-config Setups
--
-- Language-server specific configurations once neovim/lsp-config has been set
-- up.
local coq = require('coq')

-- C/C++
vim.lsp.config('clangd', coq.lsp_ensure_capabilities({
  -- query-driver 
  flags = {
      debounce_text_changes = 150,
      on_type_formatting = false,
  },
  cmd = {
    "clangd",
    "--suggest-missing-includes",
    '--query-driver=/usr/toolchains/arm-none-eabi/13/bin/arm-none-eabi-gcc',
    '--query-driver=/usr/toolchains/arm-none-eabi/13/bin/arm-none-eabi-g++',
    '--query-driver=/usr/bin/arm-none-eabi-gcc',
    '--query-driver=/usr/bin/arm-none-eabi-g++',
    '--query-driver=/run/current-system/sw/bin/avr-gcc',
    '--query-driver=/run/current-system/sw/bin/avr-g++',
    '--query-driver=/run/current-system/sw/bin/arm-none-eabi-gcc',
    '--query-driver=/run/current-system/sw/bin/arm-none-eabi-g++',
    '--query-driver=/Users/archie/.platformio/packages/**'
  },   
}))
vim.lsp.config('clangd', coq.lsp_ensure_capabilities({}))
vim.lsp.enable('clangd')

vim.lsp.config('pylsp', require('coq').lsp_ensure_capabilities({
  on_attach=on_attach,
  filetypes={'python'},
  settings = {
    configurationSources = {"flake8"},
    pylsp = {
      plugins = {
        pylint = {args = {'--ignore=F405,E501,E231', '-'}, enabled=true, debounce=200},
        pycodestyle={
          enabled=false,
        },
        flake8 = {
          enabled=true,
          extendIgnore = {'F405'},
          maxLineLength=120,
        },
        pyflakes={
          enabled=false,
        },
        black={
          enabled=false,
        },
      }
    }
  }
}))

vim.lsp.config('clojure_lsp', require('coq').lsp_ensure_capabilities({}))


vim.lsp.config('nil_ls', require('coq').lsp_ensure_capabilities({
    settings = {
        nil_ls = {
            formatter = { command = {"nixpkgs-fmt"}}
        }
    }
}))

