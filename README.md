## dotfiles
![image](https://github.com/hiramekun/dotfiles/assets/20180425/e869714e-6180-46a0-ba8c-3e8106309f78)


Inspired by this repository.   
[creasty/dotfiles](https://github.com/creasty/dotfiles)

**For macOS, Apple Silicon only**.
First, get Xcode build tools.  
Then follow below.

 ```
 $ git clone https://github.com/hiramekun/dotfiles.git
 $ cd dotfiles
 $ sh up
 ``` 
 
  - zsh
 - vim, nvim (with nvim-cmp, LSP, and Telescope)
  - karabiner settings
  - tmux
  - install apps and packages by homebrew
  - asdf for version management (Node.js, Python, Ruby, etc.)

## Neovim Extension System

This dotfiles configuration provides a comprehensive Neovim development environment with modern plugins and language support.

### Plugin Management with dein.vim

Plugins are managed using [dein.vim](https://github.com/Shougo/dein.vim), a dark-powered Vim/Neovim plugin manager. The plugin configuration is defined in `nvim/init.vim` and automatically installed during provisioning.

**Manual plugin installation:**
```vim
:call dein#install()
```

**Plugin location:** `~/dotfiles/vim/dein/repos/github.com/`

### Core Extensions

#### Language Server Protocol (LSP) Support
- **nvim-lspconfig**: Provides native LSP client configuration
- **Supported languages**: Python (pyright), TypeScript/JavaScript (ts_ls), Go (gopls), Lua (lua_ls), Rust (rust-analyzer), Terraform (terraformls), HTML, CSS, JSON, YAML, Shell
- **Enhanced Go LSP**: Configured with staticcheck, gofumpt, and unused parameter analysis
- **Auto-setup**: LSP servers start automatically when opening supported files
- **Key mappings**:
  - `gd` - Go to definition
  - `gr` - Go to references  
  - `K` - Hover documentation
  - `<leader>rn` - Rename symbol
  - `<leader>ca` - Code actions
  - `<leader>f` - Format buffer
  - `<leader>d` - Show diagnostics
  - `[d` / `]d` - Navigate diagnostics

#### Intelligent Completion
- **nvim-cmp**: Modern completion engine with LSP integration
- **cmp-cmdline**: Command-line completion
- **friendly-snippets**: Collection of common code snippets
- **Sources**: LSP, buffer text, file paths, code snippets
- **Enhanced keybindings**: Tab/Shift-Tab for navigation, improved snippet jumping
- **Usage**: Type to trigger completion, `<CR>` to confirm

#### File Navigation & Search
- **telescope.nvim**: Fuzzy finder and picker with preview
- **telescope-fzf-native**: Native FZF sorter for better performance
- **Key mappings**:
  - `<leader>ff` - Find files
  - `<leader>fg` - Live grep search
  - `<leader>fb` - List open buffers
  - `<leader>fh` - Search help tags
  - `<leader>fr` - LSP references
  - `<leader>fs` - Document symbols

#### File Explorer & Navigation
- **nvim-tree.lua**: Modern file explorer with Git integration
- **nvim-web-devicons**: File type icons
- **vim-tmux-navigator**: Seamless navigation between Vim and tmux panes
- **Key mappings**:
  - `<leader>e` - Toggle file explorer

#### Syntax Highlighting & Parsing
- **nvim-treesitter**: Advanced syntax highlighting using Tree-sitter parsers
- **nvim-treesitter-textobjects**: Smart text objects for functions and classes
- **Languages**: Python, JavaScript, TypeScript, Lua, Go, Ruby, YAML, JSON, HTML, CSS, Bash, Rust, Terraform, Dockerfile, Helm
- **Features**: Better syntax highlighting, smart indentation, intelligent text objects

#### Code Formatting & Linting
- **conform.nvim**: Modern formatting plugin with auto-format on save
- **nvim-lint**: Asynchronous linting engine
- **Formatters**: prettier/prettierd (JS/TS/CSS/HTML/JSON/YAML), black (Python), goimports+gofmt (Go), stylua (Lua), shfmt (Shell), rustfmt (Rust), terraform_fmt (Terraform)
- **Linters**: golangci-lint (Go), flake8 (Python), eslint (JS/TS)

#### Enhanced Go Development
- **vim-go**: Comprehensive Go tooling and syntax
- **go.nvim**: Modern Go development with enhanced features
- **Enhanced formatting**: goimports + gofumpt for optimal code style
- **Go-specific keybindings**:
  - `<leader>gr` - Go run
  - `<leader>gt` - Go test
  - `<leader>gtf` - Go test function
  - `<leader>gc` - Go coverage
  - `<leader>gi` - Go import
  - `<leader>gf` - Go format

#### Debugging Support
- **nvim-dap**: Debug Adapter Protocol client
- **nvim-dap-go**: Go debugging adapter
- **nvim-dap-ui**: Modern debugging UI
- **nvim-dap-virtual-text**: Inline variable values during debugging
- **Debug keybindings**:
  - `<F5>` - Start/Continue debugging
  - `<F1>/<F2>/<F3>` - Step into/over/out
  - `<leader>b` - Toggle breakpoint
  - `<F7>` - Toggle debug UI

#### Testing Framework
- **neotest**: Modern testing framework with live results
- **neotest-go**: Go test adapter
- **neotest-python**: Python test adapter
- **Test keybindings**:
  - `<leader>tn` - Test nearest
  - `<leader>tf` - Test file
  - `<leader>ts` - Test summary
  - `<leader>to` - Test output

#### Git Integration
- **gitsigns.nvim**: Git decorations and hunk management
- **vim-fugitive**: Comprehensive Git integration
- **vim-rhubarb**: GitHub integration for fugitive
- **Git keybindings**:
  - `]c` / `[c` - Navigate hunks
  - `<leader>hs` - Stage hunk
  - `<leader>hr` - Reset hunk
  - `<leader>hp` - Preview hunk
  - `<leader>hb` - Blame line

#### UI & Visual Enhancements
- **tokyonight.nvim**: Modern colorscheme with multiple variants
- **catppuccin/nvim**: Pastel colorscheme
- **gruvbox.nvim**: Classic retro colorscheme
- **lualine.nvim**: Modern statusline
- **bufferline.nvim**: Enhanced buffer/tab line with LSP diagnostics
- **which-key.nvim**: Popup showing available keybindings
- **noice.nvim**: Enhanced UI for messages and command line
- **nvim-notify**: Beautiful notification system

#### Code Navigation & Editing
- **trouble.nvim**: Diagnostics and quickfix list with preview
- **nvim-ufo**: Advanced code folding with Treesitter
- **nvim-surround**: Manipulate surrounding characters (quotes, brackets, etc.)
- **nvim-autopairs**: Auto-close brackets and quotes
- **Comment.nvim**: Smart commenting with language awareness
- **Navigation keybindings**:
  - `<leader>xx` - Open trouble diagnostics
  - `zR` / `zM` - Open/close all folds
  - `gcc` - Toggle line comment
  - `gc` + motion - Comment motion

#### Productivity & Movement
- **todo-comments.nvim**: Highlight and search TODO comments
- **hop.nvim**: Fast cursor movement to any character/word
- **toggleterm.nvim**: Floating terminal integration
- **Movement keybindings**:
  - `f` - Hop to character
  - `t` - Hop to word  
  - `<C-\>` - Toggle floating terminal

#### Language-Specific Extensions
- **kotlin-vim**: Kotlin syntax highlighting
- **vim-ruby**: Ruby language support and syntax
- **vim-javascript**: Enhanced JavaScript syntax
- **typescript-vim**: TypeScript language support
- **rust.vim**: Rust language support
- **vim-terraform**: Terraform syntax and tools
- **vim-helm**: Helm chart template support
- **stan-vim**: Stan statistical modeling language
- **markdown-preview.nvim**: Live markdown preview in browser

### Installation & Dependencies

The provisioning system automatically:

1. **Installs Neovim** via Homebrew (`nvim` package)
2. **Clones dein.vim** plugin manager to `~/dotfiles/vim/dein/repos/github.com/Shougo/dein.vim`
3. **Installs all plugins** by running `nvim --headless -c "call dein#install()" -c "qall"`
4. **Installs LSP servers and tools**:
   - **Via Homebrew**: `lua-language-server`, `rust-analyzer`, `terraform-ls`, `shellcheck`, `shfmt`, `stylua`
   - **Via npm**: `pyright`, `typescript-language-server`, `vscode-langservers-extracted`, `yaml-language-server`, `bash-language-server`, `prettier`, `eslint`, `prettierd`
   - **Via Python pip**: `black`, `flake8`, `isort`
   - **Via Go install**: `gopls`, `golangci-lint`, `goimports`, `gofumpt`, `dlv` (Go debugger)
5. **Builds Node.js dependencies** for markdown-preview plugin
6. **Compiles native extensions** like telescope-fzf-native for optimal performance

### Configuration Structure

```
nvim/
├── init.vim              # Main configuration file
vim/
├── common.vim           # Shared Vim/Neovim settings and keymaps
├── local.vim            # Local customizations (empty by default)
└── dein/
    ├── repos/           # Plugin installation directory
    ├── state_nvim.vim   # Dein state file
    └── .cache/          # Plugin cache
```

### Safe Loading & Error Handling

The configuration uses a `safe_require()` function in Lua to gracefully handle missing dependencies:
- Plugins that fail to load show warnings but don't break the entire configuration
- LSP servers, completion, and other features degrade gracefully if dependencies are missing
- This allows partial functionality even during initial setup or if some tools aren't installed

### Extending the Configuration

To add new plugins:
1. Add `call dein#add('plugin/name')` to the dein configuration in `nvim/init.vim`
2. Add any necessary Lua configuration in the `lua << EOF` block
3. Run `:call dein#install()` in Neovim to install the new plugin

The modular design makes it easy to extend language support, add new tools, or customize the development environment.

### Summary of Enhancements

This enhanced Neovim configuration transforms your editor into a full-featured IDE with:

**🚀 Go Development Excellence**:
- Enhanced LSP with gopls, staticcheck, and gofumpt
- Integrated testing with neotest-go
- Full debugging support with DAP and Delve
- Comprehensive tooling via vim-go and go.nvim

**🔧 Modern Development Tools**:
- 40+ carefully selected plugins for maximum productivity
- Support for 15+ programming languages
- Advanced debugging, testing, and formatting capabilities
- Beautiful UI with multiple colorscheme options

**⚡ Performance & Usability**:
- Fast file navigation with Telescope + FZF
- Smart code folding and text objects
- Efficient movement with Hop
- Integrated terminal and Git workflows

**🛡️ Robust & Reliable**:
- Safe plugin loading with graceful error handling
- Automatic dependency management
- Comprehensive key mapping documentation
- Easy extensibility for future needs

The configuration provides an IDE-like experience while maintaining Neovim's speed and flexibility, making it perfect for Go development and general programming tasks.
