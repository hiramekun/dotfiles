#!/usr/bin/env bash

set -euo pipefail

# One-line bootstrap for a fresh macOS machine:
#
#   curl -fsSL https://raw.githubusercontent.com/hiramekun/dotfiles/main/install.sh | bash
#
# Homebrew is installed first because its installer also installs the Xcode
# Command Line Tools (and therefore git), which are then used to clone this
# repository and hand off to `up` for the full setup.

REPO_URL="${DOTFILES_REPO_URL:-https://github.com/hiramekun/dotfiles.git}"
DOTFILES_PATH="${DOTFILES_PATH:-$HOME/dotfiles}"

require_apple_silicon_macos() {
  if [ "$(uname -s)" != "Darwin" ] || [ "$(uname -m)" != "arm64" ]; then
    printf 'This setup supports macOS on Apple Silicon only.\n' >&2
    exit 1
  fi
}

install_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    printf 'Installing Homebrew (this also installs the Xcode Command Line Tools and git)...\n'
    # The Homebrew installer installs the Command Line Tools when missing, which
    # provides git for the clone below. NONINTERACTIVE skips its confirmation
    # prompt so the `curl | bash` bootstrap does not stall on stdin.
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  eval "$(/opt/homebrew/bin/brew shellenv)"
}

clone_or_update_repo() {
  if [ -d "$DOTFILES_PATH/.git" ]; then
    printf 'Updating existing dotfiles at %s...\n' "$DOTFILES_PATH"
    git -C "$DOTFILES_PATH" pull --ff-only \
      || printf 'Could not fast-forward; using the existing checkout.\n' >&2
  else
    printf 'Cloning dotfiles into %s...\n' "$DOTFILES_PATH"
    git clone "$REPO_URL" "$DOTFILES_PATH"
  fi
}

main() {
  require_apple_silicon_macos
  install_homebrew
  clone_or_update_repo
  exec "$DOTFILES_PATH/up"
}

main "$@"
