if !exists('g:vscode')
	call plug#begin('.local/share/nvim/site/autoload/plug.vim')

		Plug 'itchyny/lightline.vim'

	call plug#end()
endif

set textwidth=80
set wrap
set nolist
set linebreak
