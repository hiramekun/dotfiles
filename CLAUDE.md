# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a macOS-focused dotfiles repository using Ansible for automated provisioning. The main setup process:

1. `up` script - Entry point that handles repository cloning/updating, Xcode license, and environment setup
2. Ansible playbook system in `provisioning/` - Handles application installation and configuration linking
3. Shell configuration in `bash/`, `zsh/`, and `shell/` - Environment variables and shell customization
4. Application configs in dedicated directories - Vim/Neovim, Karabiner, tmux, git, etc.

## Key Commands

**Setup/Installation:**
```bash
./up                    # Full dotfiles setup and provisioning
```

**Provisioning:**
```bash
./provisioning/run.sh   # Run Ansible playbook directly
ansible-playbook -i 'localhost,' --extra-vars='@config.yml' playbook.yml
```

**Development:**
The repository uses Ansible roles in `provisioning/roles/`:
- `homebrew` - Package and application installation
- `link` - Symlink creation for config files  
- `vim` - Vim/Neovim setup
- `asdf` - Version manager setup

## Configuration Structure

- `provisioning/config.yml` - Central configuration for homebrew packages, applications, and symlink mappings
- `provisioning/playbook.yml` - Ansible playbook defining role execution order
- Config files are organized by application (git/, vim/, karabiner/, etc.)
- Shell configs use modular approach with separate files for different purposes

## Environment Setup

The setup assumes:
- macOS with Apple Silicon
- Xcode command line tools installed
- Git available for repository cloning
- Target audience: developers needing comprehensive dev environment

Key environment variables are set in `shell/env.sh` including Homebrew paths, GOPATH, and development tool paths.