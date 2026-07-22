export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}"
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
export PATH="${PATH}:${HOME}/.krew/bin"
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
export LSCOLORS=cxfxcxdxbxegedabagacad

# Treat the repository config as the global mise config so its runtimes and
# editor tooling remain available outside the dotfiles directory.
export MISE_GLOBAL_CONFIG_FILE="${MISE_GLOBAL_CONFIG_FILE:-${DOTFILES_PATH:-$HOME/dotfiles}/mise.toml}"
export MISE_GLOBAL_CONFIG_ROOT="${MISE_GLOBAL_CONFIG_ROOT:-${DOTFILES_PATH:-$HOME/dotfiles}}"
# Ignore legacy global files such as ~/.tool-versions while continuing to
# discover project-level mise configuration below the home directory.
export MISE_CEILING_PATHS="${MISE_CEILING_PATHS:-$HOME}"

if command -v mise >/dev/null 2>&1 && [ -z "${MISE_SHELL:-}" ]; then
    if [ -n "${ZSH_VERSION:-}" ]; then
        eval "$(mise activate zsh)"
    elif [ -n "${BASH_VERSION:-}" ]; then
        eval "$(mise activate bash)"
    fi
fi

# direnv
if command -v direnv >/dev/null 2>&1; then
    # Detect current shell and use appropriate hook
    if [ -n "${ZSH_VERSION:-}" ]; then
        eval "$(direnv hook zsh)"
    elif [ -n "${BASH_VERSION:-}" ]; then
        eval "$(direnv hook bash)"
    fi
fi

export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
