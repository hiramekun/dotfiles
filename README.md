# dotfiles

![Terminal screenshot](https://github.com/hiramekun/dotfiles/assets/20180425/e869714e-6180-46a0-ba8c-3e8106309f78)

Personal development environment for **macOS on Apple Silicon**. It includes:

- Shell, Git, tmux, Vim/Neovim, Karabiner, and iTerm2 settings
- Homebrew formulae and applications
- Runtimes and development tools managed by [mise](https://mise.jdx.dev/)
- A Neovim environment with LSP, completion, formatting, linting, debugging, and testing

Inspired by [creasty/dotfiles](https://github.com/creasty/dotfiles).

## Setup

Install the Xcode Command Line Tools first:

```sh
xcode-select --install
```

Then clone and provision the environment:

```sh
git clone https://github.com/hiramekun/dotfiles.git ~/dotfiles
cd ~/dotfiles
./up
```

`up` installs Homebrew and mise when needed, then runs the complete setup.

## Commands

After the initial setup, each area can be updated independently:

| Command | Purpose |
| --- | --- |
| `mise run setup` | Run the complete setup |
| `mise run brew` | Install missing Homebrew dependencies |
| `mise run tools` | Install runtimes and development tools |
| `mise run link` | Symlink dotfiles from the `[dotfiles]` table |
| `mise run defaults` | Apply the login shell and macOS defaults |
| `mise run vim` | Install dein.vim and Neovim plugins |
| `mise run doctor` | Check the mise and Homebrew environment |
| `mise run test` | Run the test suite |

`mise run brew` does not upgrade installed packages. To upgrade every Brewfile
entry explicitly, run:

```sh
brew bundle upgrade --file Brewfile
```

## Runtime management

[mise.toml](mise.toml) manages Node.js, Python, Ruby, Java, Go, Terraform, and
editor tooling such as language servers, formatters, linters, and debuggers.

The shell configuration uses this repository's `mise.toml` as the global mise
configuration. Project-level `mise.toml` files can override its versions, while
the legacy `~/.tool-versions` is excluded from discovery.

## Dotfiles and macOS defaults

Symlinks, the login shell, and macOS preferences are declared directly in
[mise.toml](mise.toml) and applied with [`mise bootstrap`](https://mise.jdx.dev/cli/bootstrap.html):

- `[dotfiles]` maps each `$HOME` target to a source in this repository and is
  applied by `mise run link` (`mise bootstrap dotfiles apply`). mise refuses to
  overwrite an existing real file without `--force` and does not create `.bak`
  backups, so move any conflicting file aside before the first run.
- `[bootstrap.user]` keeps zsh as the login shell.
- `[bootstrap.macos.*]` captures keyboard, Dock, Finder, and appearance
  preferences; `mise run defaults` applies them.

## Neovim

[dein.vim](https://github.com/Shougo/dein.vim) installs the plugins declared in
[nvim/init.vim](nvim/init.vim). The setup provides:

- LSP and completion for commonly used languages
- Telescope search, Tree-sitter highlighting, and a file explorer
- Automatic formatting and linting
- Git, debugger, and test integrations
- Shared Vim/Neovim settings from [vim/common.vim](vim/common.vim)

Frequently used mappings:

| Mapping | Action |
| --- | --- |
| `<leader>ff` / `<leader>fg` | Find files / search text |
| `<leader>e` | Toggle the file explorer |
| `gd` / `gr` | Go to definition / references |
| `K` | Show hover documentation |
| `<leader>rn` / `<leader>ca` | Rename / code action |
| `<leader>f` | Format the current buffer |
| `[d` / `]d` | Move between diagnostics |
| `<leader>tn` / `<leader>tf` | Test the nearest case / current file |
| `<F5>` | Start or continue debugging |

To install newly added plugins manually, run this inside Neovim:

```vim
:call dein#install()
```

## Repository structure

```text
.
├── Brewfile           # Homebrew dependencies
├── mise.toml          # Runtimes, tools, dotfiles, macOS defaults, and tasks
├── up                 # Bootstrap entry point
├── scripts/           # Provisioning and utility scripts
├── nvim/ and vim/     # Neovim and Vim configuration
├── zsh/ and bash/     # Shell configuration
├── git/ and tmux/     # Git and tmux configuration
├── karabiner/         # Keyboard customization
└── tests/             # Setup and configuration tests
```

To add a Neovim plugin, declare it with `dein#add()` in
[nvim/init.vim](nvim/init.vim), add its configuration there, and run
`:call dein#install()`.
