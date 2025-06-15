export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export LSCOLORS=cxfxcxdxbxegedabagacad

# asdf
export ASDF_DIR="$HOME/.asdf"
if [ -f "$ASDF_DIR/asdf.sh" ]; then
  source "$ASDF_DIR/asdf.sh"
fi

# Add Go and Python tools to PATH for Neovim LSP
if [ -d "$HOME/.asdf/installs/golang" ]; then
  # Find the latest Go version and add its bin to PATH
  GO_VERSION=$(ls "$HOME/.asdf/installs/golang" | sort -V | tail -1)
  if [ -n "$GO_VERSION" ] && [ -d "$HOME/.asdf/installs/golang/$GO_VERSION/packages/bin" ]; then
    export PATH="$HOME/.asdf/installs/golang/$GO_VERSION/packages/bin:$PATH"
  fi
fi

if [ -d "$HOME/.asdf/installs/python" ]; then
  # Find the latest Python version and add its bin to PATH
  PYTHON_VERSION=$(ls "$HOME/.asdf/installs/python" | sort -V | tail -1)
  if [ -n "$PYTHON_VERSION" ] && [ -d "$HOME/.asdf/installs/python/$PYTHON_VERSION/bin" ]; then
    export PATH="$HOME/.asdf/installs/python/$PYTHON_VERSION/bin:$PATH"
  fi
fi

# direnv (works well with asdf)
if command -v direnv >/dev/null 2>&1; then
  # Detect current shell and use appropriate hook
  if [ -n "${ZSH_VERSION:-}" ]; then
    eval "$(direnv hook zsh)"
  elif [ -n "${BASH_VERSION:-}" ]; then
    eval "$(direnv hook bash)"
  fi
fi

export GOPATH=$(go env GOPATH 2>/dev/null || echo "$HOME/go")
export PATH="$PATH:$GOPATH/bin"

