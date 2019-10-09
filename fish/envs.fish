#init goenv
set -x GOENV_ROOT "$HOME/.anyenv/envs/goenv"
set -x PATH $PATH "$HOME/.anyenv/envs/goenv/bin"
set -gx PATH "$HOME/.anyenv/envs/goenv/shims" $PATH
set -gx GOENV_SHELL fish
source "$GOENV_ROOT/libexec/../completions/goenv.fish" 

#init rbenv
set -x RBENV_ROOT "$HOME/.anyenv/envs/rbenv"
set -x PATH $PATH "$RBENV_ROOT/bin"
set -gx PATH "$RBENV_ROOT/shims" $PATH
set -gx RBENV_SHELL fish
source "$RBENV_ROOT/libexec/../completions/rbenv.fish"

#init pyenv
set -x PYENV_ROOT "$HOME/.anyenv/envs/pyenv"
set -x PATH $PATH "$PYENV_ROOT/bin"
set -gx PATH "$PYENV_ROOT/shims" $PATH
set -gx PYENV_SHELL fish
source "$PYENV_ROOT/libexec/../completions/pyenv.fish"

#init ndenv
set -x NDENV_ROOT "$HOME/.anyenv/envs/ndenv"
set -x PATH $PATH "$NDENV_ROOT/bin"
set -gx PATH "$NDENV_ROOT/shims" $PATH
set -gx NDENV_SHELL fish

#init jenv
set -x JENV_ROOT "$HOME/.anyenv/envs/jenv"
set -x PATH $PATH "$JENV_ROOT/bin"
set -gx PATH "$JENV_ROOT/shims" $PATH
set -gx JENV_SHELL fish
set -x JENV_LOADED 1

#init swiftenv
set -x SWIFTENV_ROOT "$HOME/.anyenv/envs/swiftenv"
set -gx PATH "$SWIFTENV_ROOT/bin" $PATH
if which swiftenv > /dev/null; status --is-interactive; and source (swiftenv init -|psub); end
