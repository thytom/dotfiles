" Vim/nVim .vimrc
" Author: Archie Hilton
" Email	:	archie.hilton1@gmail.com

let mapleader=','

call plug#begin('~/.vim/plugged')
	Plug 'jiangmiao/auto-pairs'
	Plug 'tomtom/tcomment_vim'
	Plug 'tpope/vim-surround'
	Plug 'dracula/vim', { 'as': 'dracula' }
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'itchyny/lightline.vim'
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do' : ':TSUpdate'}
	Plug 'anuvyklack/pretty-fold.nvim'
	Plug 'sbdchd/neoformat'
	Plug 'antoinemadec/coc-fzf'
	" Plug 'gabrielelana/vim-markdown'
call plug#end()

let g:coc_disable_startup_warning=1

au filetype c,cpp nnoremap <leader>d :Dox<CR>

" Some basics:
set nocompatible
filetype plugin on
filetype indent on
syntax on
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set encoding=utf-8
set number relativenumber
set nohlsearch
set tabstop=4
" set softtabstop
set expandtab
set shiftwidth=0
set ignorecase
set smartcase
set wrap
set linebreak
set visualbell
set numberwidth=6
set foldlevelstart=99

nnoremap go :CocFzfList outline<cr>
" nnoremap gd :call CocActionAsync('jumpDefinition');<cr>
" nnoremap gD :call CocActionAsync('jumpDefinition', v:false);<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

colorscheme dracula
au BufEnter * hi Normal guibg=NONE ctermbg=NONE
set background=dark

au BufReadPost,FileReadPost * normal zR

nnoremap \| :vs<cr><c-W>l
nnoremap _ :split<cr><c-W>j

let g:fzf_layout= {'window' : {'width' : 0.9, 'height':0.9}}
let $FZF_DEFAULT_OPTS="--preview-window 'right:60%' --layout reverse --margin=1,4"

nnoremap <leader>e :Files<cr>
nnoremap <leader>f :Rg<cr>

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX)/
          \ containedin=.*Comment,vimCommentTitle
augroup END
hi MyTodo cterm=bold ctermfg=Cyan

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    --disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    --disable = function(lang, buf)
    --    local max_filesize = 100 * 1024 -- 100 KB
    --    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --    if ok and stats and stats.size > max_filesize then
    --        return true
    --    end
    --end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

