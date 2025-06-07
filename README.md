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

TODO: use asdf

## Neovim plugins

Plugins are managed with [dein.vim](https://github.com/Shougo/dein.vim). After cloning the repository, start Neovim and run:

```vim
:call dein#install()
```

This installs the plugins declared in `nvim/init.vim` under `~/dotfiles/vim/dein`.

### Plugin usage

- **nvim-lspconfig** provides LSP servers. Opening a supported file automatically starts the language server (Python uses `pyright`).
- **nvim-cmp** offers completion integrated with LSP. Use `<CR>` to confirm suggestions.
- **telescope.nvim** is a fuzzy finder. Key mappings are set in `vim/common.vim`:
  - `<Space>ff` find files
  - `<Space>fg` live grep
  - `<Space>fb` list buffers
