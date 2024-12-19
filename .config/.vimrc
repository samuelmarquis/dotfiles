set nocompatible
set nu
set mouse=a
colo industry
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
	Plug 'lervag/vimtex'
	let g:tex_flavor='latex'
	let g:vimtex_view_method='zathura'
	let g:vimtex_quickfix_mode=0
	let g:vimtex_view_method = 'zathura'

	Plug 'sirver/ultisnips'
	let g:UltiSnipsSnippetDirectory = '/home/sam/.vim/UltiSnips'
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

	Plug 'tibabit/vim-templates'
call plug#end()
