export SPACESHIP_CONFIG="$HOME/.config/spaceship/.spaceship.zsh"
export DOTFILES_PATH="$HOME/dotfiles"

if [-f $DOTFILES_PATH/env.sh ]; then
  source $DOTFILES_PATH/env.sh
fi
