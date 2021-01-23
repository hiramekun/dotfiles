if &shell =~# 'fish$'
    set shell=sh
endif

if &compatible
  set nocompatible
endif

set runtimepath+=~/dotfiles/vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/dotfiles/vim/dein')
	call dein#begin('~/dotfiles/vim/dein')
	call dein#add('~/dotfiles/vim/dein/repos/github.com/Shougo/dein.vim')

	call dein#add('udalov/kotlin-vim')
	call dein#add('Shougo/deoplete.nvim')
	if !has('nvim') 
		call dein#add('roxma/nvim-yarp')
		call dein#add('roxma/vim-hug-neovim-rpc')
	endif

	call dein#add('Shougo/neosnippet.vim')
	call dein#add('Shougo/neosnippet-snippets')
	call dein#add('davidhalter/jedi-vim')
	call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
					\ 'build': 'sh -c "cd app && yarn install"' })
	call dein#add('eigenfoo/stan-vim')

	call dein#end()
	call dein#save_state()
endif
filetype plugin indent on
syntax enable

source ~/dotfiles/vim/common.vim
source ~/dotfiles/vim/local.vim
set clipboard+=unnamed
syntax on

augroup texfile
  autocmd BufRead,BufNewFile *.tex set filetype=tex
  let md_to_latex  = "pandoc --from=markdown --to=latex"
  autocmd Filetype tex let &formatprg=md_to_latex
augroup END

let g:slimv_lisp = 'ros run'
let g:silmv_impl = 'sbcl'
nnoremap <silent> ,cl :VimShellInteractive ros -s swank -e '(swank:create-server :port 4005 :dont-close t)' wait<CR>

"jedi-vim
autocmd FileType python setlocal completeopt-=preview

"deoplete
let g:deoplete#enable_at_startup = 1

imap <C-l>     <Plug>(neosnippet_expand_or_jump)
smap <C-l>     <Plug>(neosnippet_expand_or_jump)
xmap <C-l>     <Plug>(neosnippet_expand_target)
