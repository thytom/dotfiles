-- lsp-config Setups
--
-- Language-server specific configurations once neovim/lsp-config has been set
-- up.

-- C/C++
require('lspconfig').clangd.setup(require('coq').lsp_ensure_capabilities({
  -- query-driver 
  cmd = {
    "clangd",
    "--suggest-missing-includes",
    '--query-driver=/usr/toolchains/arm-none-eabi/13/bin/arm-none-eabi-gcc',
    '--query-driver=/usr/toolchains/arm-none-eabi/13/bin/arm-none-eabi-g++',
    '--query-driver=/usr/bin/arm-none-eabi-gcc',
    '--query-driver=/usr/bin/arm-none-eabi-g++',
  },
}))

require('lspconfig').pylsp.setup(require('coq').lsp_ensure_capabilities({
  on_attach=on_attach,
  filetypes={'python'},
  settings = {
    configurationSources = {"flake8"},
    formatCommand = {"ruff"},
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
      }
    }
  }
}))

require('lspconfig').clojure_lsp.setup(require('coq').lsp_ensure_capabilities({}))
