source ~/common.bash
source ~/local.bash

# Load dotfiles environment (includes asdf and homebrew setup)
if [ -f "$HOME/dotfiles/shell/env.sh" ]; then
  source "$HOME/dotfiles/shell/env.sh"
fi
