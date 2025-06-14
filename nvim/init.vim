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

        " LSP and completion
        call dein#add('neovim/nvim-lspconfig')
        call dein#add('hrsh7th/nvim-cmp')
        call dein#add('hrsh7th/cmp-nvim-lsp')
        call dein#add('hrsh7th/cmp-buffer')
        call dein#add('hrsh7th/cmp-path')
        call dein#add('hrsh7th/cmp-cmdline')
        call dein#add('L3MON4D3/LuaSnip')
        call dein#add('saadparwaiz1/cmp_luasnip')
        call dein#add('rafamadriz/friendly-snippets')
        
        " telescope for fuzzy finding
        call dein#add('nvim-lua/plenary.nvim')
        call dein#add('nvim-telescope/telescope.nvim')
        call dein#add('nvim-telescope/telescope-fzf-native.nvim', {'build': 'make'})
        
        " treesitter for better syntax highlighting
        call dein#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})
        call dein#add('nvim-treesitter/nvim-treesitter-textobjects')
        
        " formatting and linting
        call dein#add('stevearc/conform.nvim')
        call dein#add('mfussenegger/nvim-lint')
        
        " Git integration
        call dein#add('lewis6991/gitsigns.nvim')
        call dein#add('tpope/vim-fugitive')
        call dein#add('tpope/vim-rhubarb')
        
        " File explorer and navigation
        call dein#add('nvim-tree/nvim-tree.lua')
        call dein#add('nvim-tree/nvim-web-devicons')
        call dein#add('christoomey/vim-tmux-navigator')
        
        " Enhanced Go development
        call dein#add('fatih/vim-go')
        call dein#add('ray-x/go.nvim')
        call dein#add('ray-x/guihua.lua')
        
        " Debugging support
        call dein#add('mfussenegger/nvim-dap')
        call dein#add('leoluz/nvim-dap-go')
        call dein#add('rcarriga/nvim-dap-ui')
        call dein#add('theHamsta/nvim-dap-virtual-text')
        
        " Testing
        call dein#add('nvim-neotest/neotest')
        call dein#add('nvim-neotest/neotest-go')
        call dein#add('nvim-neotest/neotest-python')
        
        " Code navigation and editing
        call dein#add('folke/trouble.nvim')
        call dein#add('kevinhwang91/nvim-ufo')
        call dein#add('kevinhwang91/promise-async')
        call dein#add('kylechui/nvim-surround')
        call dein#add('windwp/nvim-autopairs')
        call dein#add('numToStr/Comment.nvim')
        
        " UI enhancements
        call dein#add('nvim-lualine/lualine.nvim')
        call dein#add('akinsho/bufferline.nvim')
        call dein#add('folke/which-key.nvim')
        call dein#add('folke/noice.nvim')
        call dein#add('MunifTanjim/nui.nvim')
        call dein#add('rcarriga/nvim-notify')
        
        " Colorschemes
        call dein#add('folke/tokyonight.nvim')
        call dein#add('catppuccin/nvim', {'name': 'catppuccin'})
        call dein#add('ellisonleao/gruvbox.nvim')
        
        " Language support
        call dein#add('udalov/kotlin-vim')
        call dein#add('vim-ruby/vim-ruby')
        call dein#add('pangloss/vim-javascript')
        call dein#add('leafgarland/typescript-vim')
        call dein#add('rust-lang/rust.vim')
        call dein#add('hashivim/vim-terraform')
        call dein#add('towolf/vim-helm')
        
        " Markdown and documentation
        call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
                                        \ 'build': 'sh -c "cd app && yarn install"' })
        call dein#add('eigenfoo/stan-vim')
        
        " Productivity
        call dein#add('folke/todo-comments.nvim')
        call dein#add('phaazon/hop.nvim')
        call dein#add('akinsho/toggleterm.nvim')

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

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Basic settings
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.foldenable = false
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Setup colorscheme
local tokyonight = safe_require('tokyonight')
if tokyonight then
  tokyonight.setup({
    style = "night",
    transparent = false,
  })
  vim.cmd('colorscheme tokyonight')
end

-- Setup LSP servers
local lspconfig = safe_require('lspconfig')
if lspconfig then
  -- Enhanced Go LSP setup
  lspconfig.gopls.setup{
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true,
      },
    },
  }
  
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
  
  -- Rust
  lspconfig.rust_analyzer.setup{}
  
  -- Terraform
  lspconfig.terraformls.setup{}
  
  -- Shell
  lspconfig.bashls.setup{}
end

-- Setup enhanced completion
local cmp = safe_require('cmp')
local luasnip = safe_require('luasnip')

if cmp and luasnip then
  -- Load friendly snippets
  require("luasnip.loaders.from_vscode").lazy_load()
  
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    })
  })

  -- Command line completion
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' },
      { name = 'cmdline' }
    })
  })
end

-- Enhanced Telescope setup
local telescope = safe_require('telescope')
if telescope then
  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ['<C-j>'] = 'move_selection_next',
          ['<C-k>'] = 'move_selection_previous',
        }
      }
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
      }
    }
  })
  
  pcall(telescope.load_extension, 'fzf')
  
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
  vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'LSP references' })
  vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Document symbols' })
end

-- Enhanced Treesitter setup
local treesitter = safe_require('nvim-treesitter.configs')
if treesitter then
  treesitter.setup {
    ensure_installed = { 
      "python", "javascript", "typescript", "lua", "go", "ruby", "yaml", "json", 
      "html", "css", "bash", "rust", "terraform", "dockerfile", "helm"
    },
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
  }
end

-- Enhanced formatting and linting
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
      go = { "goimports", "gofmt" },
      lua = { "stylua" },
      sh = { "shfmt" },
      rust = { "rustfmt" },
      terraform = { "terraform_fmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  })
end

-- Setup nvim-lint
local lint = safe_require('lint')
if lint then
  lint.linters_by_ft = {
    go = {'golangcilint'},
    python = {'flake8'},
    javascript = {'eslint'},
    typescript = {'eslint'},
  }
  
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      lint.try_lint()
    end,
  })
end

-- Git integration
local gitsigns = safe_require('gitsigns')
if gitsigns then
  gitsigns.setup{
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
      
      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, {expr=true, desc="Next hunk"})
      
      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true, desc="Previous hunk"})
      
      -- Actions
      map('n', '<leader>hs', gs.stage_hunk, {desc="Stage hunk"})
      map('n', '<leader>hr', gs.reset_hunk, {desc="Reset hunk"})
      map('n', '<leader>hS', gs.stage_buffer, {desc="Stage buffer"})
      map('n', '<leader>hu', gs.undo_stage_hunk, {desc="Undo stage hunk"})
      map('n', '<leader>hR', gs.reset_buffer, {desc="Reset buffer"})
      map('n', '<leader>hp', gs.preview_hunk, {desc="Preview hunk"})
      map('n', '<leader>hb', function() gs.blame_line{full=true} end, {desc="Blame line"})
      map('n', '<leader>tb', gs.toggle_current_line_blame, {desc="Toggle line blame"})
      map('n', '<leader>hd', gs.diffthis, {desc="Diff this"})
      map('n', '<leader>hD', function() gs.diffthis('~') end, {desc="Diff this ~"})
      map('n', '<leader>td', gs.toggle_deleted, {desc="Toggle deleted"})
    end
  }
end

-- File explorer
local nvim_tree = safe_require('nvim-tree')
if nvim_tree then
  nvim_tree.setup({
    sort_by = "case_sensitive",
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false,
    },
  })
  
  vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
end

-- Enhanced Go development
local go_nvim = safe_require('go')
if go_nvim then
  go_nvim.setup({
    goimport = 'gopls',
    gofmt = 'gofumpt',
    max_line_len = 120,
    tag_transform = false,
    test_dir = '',
    comment_placeholder = '   ',
    lsp_cfg = false, -- handled by lspconfig
    lsp_gofumpt = true,
    lsp_on_attach = nil,
    dap_debug = true,
  })
  
  -- Go-specific keymaps
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
      vim.keymap.set('n', '<leader>gr', ':GoRun<CR>', { desc = 'Go run', buffer = true })
      vim.keymap.set('n', '<leader>gt', ':GoTest<CR>', { desc = 'Go test', buffer = true })
      vim.keymap.set('n', '<leader>gtf', ':GoTestFunc<CR>', { desc = 'Go test function', buffer = true })
      vim.keymap.set('n', '<leader>gc', ':GoCoverage<CR>', { desc = 'Go coverage', buffer = true })
      vim.keymap.set('n', '<leader>gi', ':GoImport<CR>', { desc = 'Go import', buffer = true })
      vim.keymap.set('n', '<leader>gf', ':GoFmt<CR>', { desc = 'Go format', buffer = true })
    end,
  })
end

-- Debugging setup
local dap = safe_require('dap')
local dap_go = safe_require('dap-go')
local dapui = safe_require('dapui')

if dap and dap_go and dapui then
  dap_go.setup()
  dapui.setup()
  
  -- DAP keymaps
  vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
  vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
  vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
  vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
  vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
  vim.keymap.set('n', '<leader>B', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  end, { desc = 'Debug: Set Breakpoint' })
  
  -- Toggle debug UI
  vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
  
  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close
end

-- Testing with neotest
local neotest = safe_require('neotest')
if neotest then
  neotest.setup({
    adapters = {
      require('neotest-go'),
      require('neotest-python'),
    },
  })
  
  vim.keymap.set('n', '<leader>tn', neotest.run.run, { desc = 'Test nearest' })
  vim.keymap.set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand('%')) end, { desc = 'Test file' })
  vim.keymap.set('n', '<leader>ts', neotest.summary.toggle, { desc = 'Test summary' })
  vim.keymap.set('n', '<leader>to', neotest.output.open, { desc = 'Test output' })
end

-- UI enhancements
local lualine = safe_require('lualine')
if lualine then
  lualine.setup({
    options = {
      theme = 'tokyonight',
      component_separators = '|',
      section_separators = '',
    },
  })
end

local bufferline = safe_require('bufferline')
if bufferline then
  bufferline.setup({
    options = {
      diagnostics = "nvim_lsp",
      separator_style = "slant",
    }
  })
  
  vim.keymap.set('n', '<leader>bp', ':BufferLinePick<CR>', { desc = 'Pick buffer' })
  vim.keymap.set('n', '<leader>bc', ':BufferLinePickClose<CR>', { desc = 'Pick close buffer' })
end

-- Which-key for keybinding help
local which_key = safe_require('which-key')
if which_key then
  which_key.setup()
end

-- Enhanced editing
local nvim_surround = safe_require('nvim-surround')
if nvim_surround then
  nvim_surround.setup()
end

local autopairs = safe_require('nvim-autopairs')
if autopairs then
  autopairs.setup()
end

local comment = safe_require('Comment')
if comment then
  comment.setup()
end

-- Trouble for diagnostics
local trouble = safe_require('trouble')
if trouble then
  trouble.setup()
  
  vim.keymap.set('n', '<leader>xx', ':Trouble<CR>', { desc = 'Open trouble' })
  vim.keymap.set('n', '<leader>xw', ':Trouble workspace_diagnostics<CR>', { desc = 'Workspace diagnostics' })
  vim.keymap.set('n', '<leader>xd', ':Trouble document_diagnostics<CR>', { desc = 'Document diagnostics' })
  vim.keymap.set('n', '<leader>xl', ':Trouble loclist<CR>', { desc = 'Location list' })
  vim.keymap.set('n', '<leader>xq', ':Trouble quickfix<CR>', { desc = 'Quickfix list' })
end

-- Code folding with UFO
local ufo = safe_require('ufo')
if ufo then
  vim.o.foldcolumn = '1'
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
  
  ufo.setup({
    provider_selector = function(bufnr, filetype, buftype)
      return {'treesitter', 'indent'}
    end
  })
  
  vim.keymap.set('n', 'zR', ufo.openAllFolds)
  vim.keymap.set('n', 'zM', ufo.closeAllFolds)
end

-- Productivity plugins
local todo_comments = safe_require('todo-comments')
if todo_comments then
  todo_comments.setup()
end

local hop = safe_require('hop')
if hop then
  hop.setup()
  
  vim.keymap.set('', 'f', ':HopChar2<CR>', { desc = 'Hop to char' })
  vim.keymap.set('', 't', ':HopWord<CR>', { desc = 'Hop to word' })
end

local toggleterm = safe_require('toggleterm')
if toggleterm then
  toggleterm.setup({
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = 'curved',
    },
  })
end

-- LSP keybindings
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = 'Format buffer' })

-- Diagnostic keybindings
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })
EOF

