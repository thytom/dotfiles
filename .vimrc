"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|

let mapleader =","

call plug#begin('~/.vim/plugged')
	Plug 'junegunn/goyo.vim'
	Plug 'tpope/vim-surround'
	Plug 'rstacruz/sparkup'
	Plug 'tomtom/tcomment_vim'
call plug#end()

" Some basics:
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber
set nohlsearch
set tabstop=4
" set softtabstop
set noexpandtab
set shiftwidth=4
set ignorecase
set smartcase
set wrap
set linebreak
set visualbell
set numberwidth=6

set vb
set t_vb=
" Disables automatic commenting on newline:
colorscheme ron
set background=dark
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin makes text more readable when writing prose:
map <leader>f :Goyo \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

map <SPACE><SPACE> /<++><CR>cw

" Better tablation
xnoremap > >gv
xnoremap < <gv

" Better Digraphs
inoremap <expr> <C-K>	BDG_GetDigraph()

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Readmes autowrap text:
autocmd BufRead,BufNewFile *.md set tw=79

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
vnoremap <C-c> "+y
map <C-p> "+P

" " Easily move lines up and down
" vnoremap <S-J> ddp
" vnoremap <S-K> ddkP

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %

let g:asmsyntax = 'nasm'


" Visual dragging
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 1

" Faster Quitting if no changes were made

nnoremap zz :q<CR>
