# CLAUDE.md

This repository provisions a macOS Apple Silicon development environment with
mise. Ansible and asdf are no longer part of the setup.

## Architecture

1. `up` bootstraps Homebrew and mise, trusts the repository config, and runs the
   requested mise task (`setup` by default).
2. `mise.toml` is the provisioning entry point. It declares runtimes, developer
   tools, and the task graph.
3. `Brewfile` declares macOS applications and system-level packages.
4. `scripts/link-dotfiles` creates safe, idempotent symlinks and backs up existing
   destinations.
5. `scripts/setup-vim` installs dein.vim and Neovim plugins.
6. Shell activation lives in `shell/env.sh` and exposes the repository
   `mise.toml` as the global config for Bash and Zsh.

## Commands

```sh
./up                 # bootstrap and run the complete setup
./up link            # bootstrap, then run one task
mise run setup       # complete setup on an already-bootstrapped machine
mise run brew        # install Brewfile dependencies
mise run tools       # install mise-managed tools
mise run link        # create dotfile symlinks
mise run vim         # install/update Neovim plugins
mise run doctor      # inspect mise and Homebrew health
mise run test        # run tests
```

## Configuration

- Keep versioned runtimes and standalone developer tools in `mise.toml`.
- Keep macOS GUI applications, system libraries, and Homebrew-only tools in
  `Brewfile`.
- Keep link mappings in `scripts/link-dotfiles`.
- Use `mise.local.toml` for uncommitted machine-specific mise overrides.

The setup assumes macOS on Apple Silicon with Xcode Command Line Tools installed.
