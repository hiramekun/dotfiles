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
        " modern completion and LSP support
        call dein#add('neovim/nvim-lspconfig')
        call dein#add('hrsh7th/nvim-cmp')
        call dein#add('hrsh7th/cmp-nvim-lsp')
        call dein#add('hrsh7th/cmp-buffer')
        call dein#add('hrsh7th/cmp-path')
        call dein#add('L3MON4D3/LuaSnip')
        call dein#add('saadparwaiz1/cmp_luasnip')
        " telescope for fuzzy finding
        call dein#add('nvim-lua/plenary.nvim')
        call dein#add('nvim-telescope/telescope.nvim')
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
let g:slimv_impl = 'sbcl'
nnoremap <silent> ,cl :VimShellInteractive ros -s swank -e '(swank:create-server :port 4005 :dont-close t)' wait<CR>

lua << EOF
local lspconfig = require('lspconfig')
lspconfig.pyright.setup{}

local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  })
})
EOF

