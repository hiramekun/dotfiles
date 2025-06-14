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
        " treesitter for better syntax highlighting
        call dein#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})
        " formatting (using conform.nvim instead of deprecated null-ls)
        call dein#add('stevearc/conform.nvim')
        " language support
        call dein#add('fatih/vim-go')
        call dein#add('vim-ruby/vim-ruby')
        call dein#add('pangloss/vim-javascript')
        call dein#add('leafgarland/typescript-vim')
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
-- Safe require function
local function safe_require(module)
  local ok, result = pcall(require, module)
  if ok then
    return result
  else
    vim.notify("Failed to load " .. module .. ": " .. result, vim.log.levels.WARN)
    return nil
  end
end

-- Setup LSP servers
local lspconfig = safe_require('lspconfig')
if lspconfig then
  -- Python
  lspconfig.pyright.setup{}
  
  -- TypeScript/JavaScript  
  lspconfig.ts_ls.setup{}
  
  -- HTML, CSS, JSON
  lspconfig.html.setup{}
  lspconfig.cssls.setup{}
  lspconfig.jsonls.setup{}
  
  -- YAML
  lspconfig.yamlls.setup{}
  
  -- Lua
  lspconfig.lua_ls.setup{
    settings = {
      Lua = {
        diagnostics = {
          globals = {'vim'}
        }
      }
    }
  }
  
  -- Go
  lspconfig.gopls.setup{}
  
  -- Shell
  lspconfig.bashls.setup{}
end

-- Setup completion
local cmp = safe_require('cmp')
local luasnip = safe_require('luasnip')

if cmp and luasnip then
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
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
end

-- Setup Telescope keybindings
local telescope = safe_require('telescope.builtin')
if telescope then
  vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Find files' })
  vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'Live grep' })
  vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = 'Find buffers' })
  vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = 'Help tags' })
end

-- Setup Treesitter
local treesitter = safe_require('nvim-treesitter.configs')
if treesitter then
  treesitter.setup {
    ensure_installed = { "python", "javascript", "typescript", "lua", "go", "ruby", "yaml", "json", "html", "css", "bash" },
    highlight = { enable = true },
    indent = { enable = true }
  }
end

-- Setup formatting with conform.nvim
local conform = safe_require('conform')
if conform then
  conform.setup({
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      python = { "black" },
      go = { "gofmt" },
      lua = { "stylua" },
      sh = { "shfmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  })
end

-- LSP keybindings
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
EOF

