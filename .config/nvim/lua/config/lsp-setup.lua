-- lsp-config Setups
--
-- Language-server specific configurations once neovim/lsp-config has been set
-- up.

-- C/C++
require('lspconfig').clangd.setup(require('coq').lsp_ensure_capabilities({
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

require('lspconfig').pylsp.setup(require('coq').lsp_ensure_capabilities({
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

require('lspconfig').clojure_lsp.setup(require('coq').lsp_ensure_capabilities({}))


require'lspconfig'.nil_ls.setup(require('coq').lsp_ensure_capabilities({
    settings = {
        nil_ls = {
            formatter = { command = {"nixpkgs-fmt"}}
        }
    }
}))

