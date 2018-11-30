#init rbenv
set -x RBENV_ROOT "$HOME/.anyenv/envs/rbenv"
set -x PATH $PATH "$RBENV_ROOT/bin"
set -gx PATH "$RBENV_ROOT/shims" $PATH
set -gx RBENV_SHELL fish
source "$RBENV_ROOT/libexec/../completions/rbenv.fish"
command rbenv rehash 2>/dev/null

#init pyenv
set -x PYENV_ROOT "$HOME/.anyenv/envs/pyenv"
set -x PATH $PATH "$PYENV_ROOT/bin"
set -gx PATH "$PYENV_ROOT/shims" $PATH
set -gx PYENV_SHELL fish
source "$PYENV_ROOT/libexec/../completions/pyenv.fish"
command pyenv rehash 2>/dev/null

#init ndenv
set -x NDENV_ROOT "$HOME/.anyenv/envs/ndenv"
set -x PATH $PATH "$NDENV_ROOT/bin"
set -gx PATH "$NDENV_ROOT/shims" $PATH
set -gx NDENV_SHELL fish
command ndenv rehash 2>/dev/null

#init jenv
set -x JENV_ROOT "$HOME/.anyenv/envs/jenv"
set -x PATH $PATH "$JENV_ROOT/bin"
set -gx PATH "$JENV_ROOT/shims" $PATH
set -gx JENV_SHELL fish
set -x JENV_LOADED 1
command jenv rehash 2>/dev/null
