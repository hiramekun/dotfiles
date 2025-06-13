[ -f ~/.bashrc ] && source ~/.bashrc

# Load dotfiles environment
if [ -f "$HOME/dotfiles/shell/env.sh" ]; then
  source "$HOME/dotfiles/shell/env.sh"
fi
