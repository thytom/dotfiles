-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {'vim-airline/vim-airline'},
  {'vim-airline/vim-airline-themes'},
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', opts={highlight={enable=true}}},
  {'ibhagwan/fzf-lua'
  , dependencies = {'nvim-tree/nvim-web-devicons'}
  , config = function()
    require("fzf-lua").setup({})
  end
  },
  {'windwp/nvim-autopairs'},
  {'gelguy/wilder.nvim', build = ":UpdateRemotePlugins"},
  {'oneslash/helix-nvim', version = "*"},
  {'Mofiqul/dracula.nvim'},
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {'nvim-tree/nvim-tree.lua'},
  {'nvim-tree/nvim-web-devicons'},
  {'NLKNguyen/papercolor-theme'},
  {'pocco81/true-zen.nvim'},
  {"neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
    lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
    dependencies = {
      -- main one
      { "ms-jpq/coq_nvim", branch = "coq" },

      -- 9000+ Snippets
      { "ms-jpq/coq.artifacts", branch = "artifacts" },

      -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
      -- Need to **configure separately**
      { 'ms-jpq/coq.thirdparty', branch = "3p" }
      -- - shell repl
      -- - nvim lua api
      -- - scientific calculator
      -- - comment banner
      -- - etc
    },
    init = function()
      vim.g.coq_settings = {
          auto_start = true, -- if you want to start COQ at startup
          -- Your COQ settings here
      }
    end,
    config = function()
      -- Your LSP settings here
    end,
  },
  {'ranjithshegde/ccls.nvim'},
  {'nvim-lua/plenary.nvim'},
  {'joechrisellis/lsp-format-modifications.nvim'},
}, opts)

require('lspconfig').ccls.setup({
    lsp = {
        codelens = {
            enable = true,
            events = {"BufWritePost", "InsertLeave"}
        }
    }
})

require('lspconfig').ccls.setup(require('coq').lsp_ensure_capabilities())

vim.cmd([[
set mouse=a
set nohlsearch
set number
set hidden
set expandtab
set autoindent
set smartindent
set shiftwidth=2
set tabstop=2
set encoding=utf8
set history=5000
set cursorline
let g:airline_theme='catppuccin'
set formatoptions=tcr
]])

--[[
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('neoclide/coc.nvim', {branch = 'release'})
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
Plug 'junegunn/fzf.vim'
Plug 'windwp/nvim-autopairs'

vim.call('plug#end')
--]]
--
--
require('nvim-autopairs').setup{}

local wilder = require('wilder')

vim.g.mapleader=','

wilder.setup({modes = {':', '/', '?'}})

wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    highlighter = wilder.basic_highlighter(),
    min_width = '100%',
    highlights = {
      border = 'Normal', -- highlight to use for the border
    },
    reverse = 1,
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
    border = 'rounded',
  })
))

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      -- sets the language to use, 'vim' and 'python' are supported
      language = 'python',
      -- 0 turns off fuzzy matching
      -- 1 turns on fuzzy matching
      -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
      fuzzy = 1,
    }),
    wilder.python_search_pipeline({
      -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
      pattern = wilder.python_fuzzy_pattern(),
      -- omit to get results in the order they appear in the buffer
      sorter = wilder.python_difflib_sorter(),
      -- can be set to 're2' for performance, requires pyre2 to be installed
      -- see :h wilder#python_search() for more details
      engine = 're',
    })
  ),
})

vim.keymap.set('n', '_', '<cmd>split<cr>')
vim.keymap.set('n', '<space>f', '<cmd>FzfLua files<cr>')
vim.keymap.set('n', '<space>g', '<cmd>FzfLua git_files<cr>')
vim.keymap.set('n', '<space>b', '<cmd>FzfLua buffers<cr>')

vim.keymap.set('n', '<space>bk', '<cmd>lua require\'dap\'.toggle_breakpoint()<cr>')


-- nnoremap <silent> gd <Plug>(coc-definition)
-- nnoremap <silent> gy <Plug>(coc-type-definition)
-- nnoremap <silent> gr <Plug>(coc-references)
-- nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
-- nnoremap <silent> ]g <Plug>(coc-diagnostic-next)


--nmap <leader>do <Plug>(coc-codeaction)
--
--nmap <leader>rn <Plug>(coc-rename)

vim.cmd([[
nmap \| <cmd>vsplit<cr>

nnoremap <silent> <leader>gy :TZAtaraxis<CR>

nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>

nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

command! BufOnly execute '%bdelete|edit#|bdelete#'

nnoremap <silent> <space>o :BufOnly<CR>

let g:airline#extensions#tabline#enabled = 1

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.colnr = ':'
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = ' '

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap gn <cmd>bnext<cr>
nnoremap gp <cmd>bprev<cr>

nnoremap <space>t <cmd>NvimTreeToggle<cr>
]])

--[[

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <c-space> coc#refresh()
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
--]]

--]]
--
---- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require("nvim-treesitter.install").prefer_git = true

require("catppuccin").setup({
  flavour="mocha",
  background = {
    light = "latte",
    dark = "mocha"
  },
  transparent_background = false,
  show_end_of_buffer=true,
  integrations = {
    nvimtree = true,
    treesitter = true,
  },
})

vim.cmd.colorscheme "catppuccin"

vim.api.nvim_create_autocmd({"BufEnter"}, {
  pattern = {"*.c", "*.h", "*.cc", "*.cpp", "*.hh", "*.hpp"},
  command = "set syntax=cpp.doxygen"
})
