#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

python3 - "$REPO_ROOT/mise.toml" <<'PY'
import pathlib
import sys
import tomllib

config_path = pathlib.Path(sys.argv[1])
with config_path.open("rb") as config_file:
    config = tomllib.load(config_file)

required_tools = {"node", "python", "ruby", "java", "go", "terraform", "uv"}
missing_tools = required_tools - config["tools"].keys()
assert not missing_tools, f"missing mise tools: {sorted(missing_tools)}"

assert config["settings"]["ruby"]["compile"] is False
for tool in ("pipx:black", "pipx:flake8", "pipx:isort"):
    assert config["tools"][tool]["depends"] == ["uv"]

required_tasks = {"setup", "brew", "tools", "agents", "link", "defaults", "vim", "test", "doctor"}
missing_tasks = required_tasks - config["tasks"].keys()
assert not missing_tasks, f"missing mise tasks: {sorted(missing_tasks)}"
assert "--no-upgrade" in config["tasks"]["brew"]["run"]

agent_installers = config["tasks"]["agents"]["run"]
assert agent_installers == [
    "curl -fsSL https://claude.ai/install.sh | bash",
    "curl -fsSL https://chatgpt.com/codex/install.sh | sh",
]
setup_tasks = {step["task"] for step in config["tasks"]["setup"]["run"]}
assert "agents" in setup_tasks

# The link/defaults tasks delegate to the declarative `mise bootstrap` sections.
assert "bootstrap dotfiles apply" in config["tasks"]["link"]["run"]
assert any("bootstrap user apply" in step for step in config["tasks"]["defaults"]["run"])

# Core dotfile mappings live in the [dotfiles] table with sources in the repo.
dotfiles = config["dotfiles"]
assert dotfiles["~/.zshrc"]["source"] == "zsh/.zshrc"
assert dotfiles["~/.config/nvim"]["source"] == "nvim"
assert all(entry["mode"] == "symlink" for entry in dotfiles.values())

assert config["bootstrap"]["user"]["login_shell"] == "/bin/zsh"
PY

grep -q 'brew "mise"' "$REPO_ROOT/Brewfile"
if grep -q '^brew "docker"$' "$REPO_ROOT/Brewfile"; then
  printf 'Docker CLI formula conflicts with the Docker Desktop cask\n' >&2
  exit 1
fi
grep -q 'MISE_GLOBAL_CONFIG_FILE' "$REPO_ROOT/shell/env.sh"
grep -q 'MISE_CEILING_PATHS' "$REPO_ROOT/shell/env.sh"
grep -q 'MISE_CEILING_PATHS' "$REPO_ROOT/up"
grep -q 'HOMEBREW_NO_ASK=1 brew install mise' "$REPO_ROOT/up"
grep -q 'HOMEBREW_NO_ASK=1 brew upgrade mise' "$REPO_ROOT/up"
if find "$REPO_ROOT/provisioning" -type f -print -quit 2>/dev/null | grep -q .; then
  printf 'legacy provisioning files still exist\n' >&2
  exit 1
fi

bash -n "$REPO_ROOT/up"
bash -n "$REPO_ROOT/install.sh"
bash -n "$REPO_ROOT/scripts/setup-vim"
grep -q 'dein#check_install()' "$REPO_ROOT/scripts/setup-vim"
if grep -q 'max_line_len' "$REPO_ROOT/nvim/init.vim"; then
  printf 'go.nvim max_line_len requires the golines formatter\n' >&2
  exit 1
fi

# The declarative [dotfiles] table is applied through `mise bootstrap`, so the
# functional checks below need mise on PATH. Skip them gracefully otherwise.
if command -v mise >/dev/null 2>&1; then
  TEST_ROOT="$(mktemp -d)"
  trap 'rm -rf "$TEST_ROOT"' EXIT

  # A fresh $HOME with no conflicts: every entry is symlinked, and re-running is
  # idempotent.
  FRESH_HOME="$TEST_ROOT/fresh"
  mkdir -p "$FRESH_HOME"
  HOME="$FRESH_HOME" mise bootstrap dotfiles apply --yes >/dev/null
  [ -L "$FRESH_HOME/.zshrc" ]
  [ "$(readlink "$FRESH_HOME/.zshrc")" = "$REPO_ROOT/zsh/.zshrc" ]
  [ -L "$FRESH_HOME/.config/nvim" ]
  HOME="$FRESH_HOME" mise bootstrap dotfiles apply --yes >/dev/null

  # An existing real file is never clobbered without --force: the apply aborts
  # and leaves the original untouched (mise does not back up like the old
  # scripts/link-dotfiles did).
  CONFLICT_HOME="$TEST_ROOT/conflict"
  mkdir -p "$CONFLICT_HOME"
  printf 'existing config\n' > "$CONFLICT_HOME/.gitconfig"
  if HOME="$CONFLICT_HOME" mise bootstrap dotfiles apply --yes >/dev/null 2>&1; then
    printf 'dotfiles apply must refuse to overwrite existing files\n' >&2
    exit 1
  fi
  grep -q 'existing config' "$CONFLICT_HOME/.gitconfig"
else
  printf 'mise not found; skipping dotfiles apply checks\n' >&2
fi

printf 'mise setup tests passed\n'
