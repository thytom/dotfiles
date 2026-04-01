-- lsp-config Setups
--
-- Language-server specific configurations once neovim/lsp-config has been set
-- up.
-- C/C++
vim.lsp.config("clangd", {
  -- query-driver
  flags = {
    debounce_text_changes = 150,
    on_type_formatting = false,
  },
  cmd = {
    "clangd",
    "--suggest-missing-includes",
    "--query-driver=/usr/toolchains/arm-none-eabi/13/bin/arm-none-eabi-gcc",
    "--query-driver=/usr/toolchains/arm-none-eabi/13/bin/arm-none-eabi-g++",
    "--query-driver=/usr/bin/arm-none-eabi-gcc",
    "--query-driver=/usr/bin/arm-none-eabi-g++",
    "--query-driver=/run/current-system/sw/bin/avr-gcc",
    "--query-driver=/run/current-system/sw/bin/avr-g++",
    "--query-driver=/run/current-system/sw/bin/arm-none-eabi-gcc",
    "--query-driver=/run/current-system/sw/bin/arm-none-eabi-g++",
    "--query-driver=/Users/archie/.platformio/packages/**",
  },
})
vim.lsp.enable("clangd")

vim.lsp.config("pylsp", {
  on_attach = on_attach,
  filetypes = { "python" },
  settings = {
    configurationSources = { "flake8" },
    pylsp = {
      plugins = {
        pylint = { args = { "--ignore=F405,E501,E231", "-" }, enabled = true, debounce = 200 },
        pycodestyle = {
          enabled = false,
        },
        flake8 = {
          enabled = true,
          extendIgnore = { "F405" },
          maxLineLength = 120,
        },
        pyflakes = {
          enabled = false,
        },
        black = {
          enabled = false,
        },
      },
    },
  },
})

vim.lsp.config("clojure_lsp", {})

vim.lsp.config("rust-analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml" },
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
		},
	},
})

vim.lsp.enable("rust-analyzer")

vim.lsp.config("nil_ls", {
  settings = {
    nil_ls = {
      formatter = { command = { "nixpkgs-fmt" } },
    },
  },
})
