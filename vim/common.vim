
"--------------------------------------------------------------------------
"common.vim
"--------------------------------------------------------------------------

"keymap{{{
"insert-move
inoremap <C-b> <Left>
inoremap <C-k> <Left>
inoremap <C-f> <Right>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-e> <End>
inoremap <C-a> <Home>
"insert-delete
inoremap <C-d> <Del>
inoremap <C-u>l <esc>lc$
inoremap <C-u>h <C-u>
"insert-escape
map <C-j> <esc>
map! <C-j> <esc>
"insert-prediction
inoremap <C-l> <C-p>
inoremap <C-g> <C-n>
"insert-parenthesis
inoremap {<CR> {<CR>}<esc>O inoremap ( ()<Left>
inoremap () ()
inoremap (( (
inoremap " ""<Left>
inoremap "" ""

"normal-move
noremap j gj
noremap k gk
noremap <C-j> <C-y>
noremap <C-K> <C-e>
noremap gh 0
noremap gj L
noremap gk H
noremap gl $
noremap gm M
noremap gJ zb
noremap gK zt
noremap gM zz
noremap tj G
noremap tk gg
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

"normal-command
nnoremap <Space>s q:a%s/
vnoremap <Space>s q:as/
nnoremap ; q:a
nnoremap : ;
nnoremap * ,
nnoremap / q/a
nnoremap ? q?a
nnoremap q :<C-u>q<CR>
nnoremap Q q
noremap <C-u> u

"normal-tab
nnoremap th gT
nnoremap tl gt
noremap tth :tabnew<CR>:tabm-1<CR>
noremap ttl :tabnew<CR>

"normal-split
nnoremap s <C-w>
nnoremap ssh :vsplit<CR>
nnoremap ssj :split<CR><C-w>j
nnoremap ssk :split<CR>
nnoremap ssl :vsplit<CR><C-w>l
nnoremap <Left> <C-w><
nnoremap <Right> <C-w>>
nnoremap <Down> <C-w>+
nnoremap <Up> <C-w>-

"}}}

"format
set number
set ruler
set tabstop=4
set shiftwidth=4
set noexpandtab
set cursorline

"indent
set autoindent
set smartindent
set backspace=indent,eol,start

"search
set ignorecase
set smartcase
set wrapscan
set showmatch
set wildmenu
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap <silent> <C-L> :noh<C-L><CR>

"encoding
set encoding=utf-8

"colorscheme
syntax on
set background=dark
colorscheme hybrid
hi MatchParen cterm=bold ctermbg=none ctermfg=cyan
hi Normal ctermbg=none
set cursorline

" lightline
set laststatus=2
set t_Co=256
let g:line={
  \ 'colorscheme': 'jellybeans'
  \}

" emmet
autocmd FileType html imap <buffer><expr><tab>
  \ emmet#isExpandable() ? "\<plug>(emmet-expand-abbr)" : "\<tab>"
autocmd FileType css imap <buffer><expr><tab>
  \ emmet#isExpandable() ? "\<plug>(emmet-expand-abbr)" : "\<tab>"

"cursor
"let &t_ti.="\e[1 q"
"let &t_SI.="\e[5 q"
"let &t_EI.="\e[1 q"
"let &t_te.="\e[0 q"

""F5 compile{{{
command! Run call s:Run()
nnoremap <F5> :w<CR>:Run<CR>
function! s:Run()
	let e = expand("%:e")	
	if e == ".*vim.*"
		:Vim
	endif
	if e == "vim"
		:Vim
	endif
	if e == "c"
		:Gcc
	endif
	if e == "java"
		:Java
	endif
	if e == "tex"
		:TeX
	endif
	if e == "data" || e == "gp"
		:Gplt
	endif
	if e == 'v'
		:Vrlg
	endif
	if e == "lisp" || e == "cl"
		:CLisp
	endif
endfunction

command! Vim call s:Vim()
function! s:Vim()
	:source %
endfunction

command! Gcc call s:Gcc()
function! s:Gcc()
	:!gcc % -o %:r -g -lm &&  %:p:r
endfunction

command! Java call s:Java()
function! s:Java()
	:!javac % && java %:r
endfunction

command! TeX call s:TeX()
function! s:TeX()
	:!platex % && dvipdfm %:r.dvi && open %:r.pdf
endfunction

command! Gplt call s:Gplt()
function! s:Gplt()
	:! (cd %:h; (cat %:t:r.gp; echo "pause 100") | gnuplot)
endfunction

command! Vrlg call s:Vrlg()
function! s:Vrlg()
	:!iverilog % && ./a.out
endfunction

command! CLisp call s:CLisp()
function! s:CLisp()
	:!clisp %
endfunction
""}}}

"" unite.vim{{{
" prefix key
nnoremap [unite] <Nop>
nnoremap u <Nop>
nmap <Space>u [unite]


"keymap
nnoremap  [unite]u :<C-u>VimFiler<CR>
nnoremap  [unite]i :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
nnoremap  [unite]g :<C-u>Unite<Space>grep<CR>
nnoremap  [unite]f :<C-u>Unite<Space>buffer<CR>
nnoremap  [unite]b :<C-u>Unite<Space>bookmark<CR>
nnoremap  [unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap  [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap  [unite]h :<C-u>Unite<Space>history/yank<CR>
nnoremap  [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap  [unite]c :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"vimfiler
"call unite#custom_default_action('source/bookmark/directory', 'vimfiler')
let g:vimfiler_as_default_explorer = 1

""}}}

" autosave
let g:auto_save = 1
" nerdtree
let NERDTreeShowHidden=1
