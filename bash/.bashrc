source ~/common.bash
source ~/local.bash

# Load dotfiles environment (includes asdf and homebrew setup)
# Ensure DOTFILES_PATH is defined, defaulting to $HOME/dotfiles
DOTFILES_PATH=${DOTFILES_PATH:-"$HOME/dotfiles"}

if [ -f "$DOTFILES_PATH/shell/env.sh" ]; then
  source "$DOTFILES_PATH/shell/env.sh"
fi
