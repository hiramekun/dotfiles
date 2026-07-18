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

required_tasks = {"setup", "brew", "tools", "link", "vim", "test", "doctor"}
missing_tasks = required_tasks - config["tasks"].keys()
assert not missing_tasks, f"missing mise tasks: {sorted(missing_tasks)}"
assert "--no-upgrade" in config["tasks"]["brew"]["run"]
PY

grep -q 'brew "mise"' "$REPO_ROOT/Brewfile"
if grep -q '^brew "docker"$' "$REPO_ROOT/Brewfile"; then
  printf 'Docker CLI formula conflicts with the Docker Desktop cask\n' >&2
  exit 1
fi
grep -q 'MISE_GLOBAL_CONFIG_FILE' "$REPO_ROOT/shell/env.sh"
grep -q 'MISE_CEILING_PATHS' "$REPO_ROOT/shell/env.sh"
grep -q 'MISE_CEILING_PATHS' "$REPO_ROOT/up"
if find "$REPO_ROOT/provisioning" -type f -print -quit 2>/dev/null | grep -q .; then
  printf 'legacy provisioning files still exist\n' >&2
  exit 1
fi

bash -n "$REPO_ROOT/up"
bash -n "$REPO_ROOT/scripts/link-dotfiles"
bash -n "$REPO_ROOT/scripts/setup-vim"

TEST_ROOT="$(mktemp -d)"
trap 'rm -rf "$TEST_ROOT"' EXIT
TEST_HOME="$TEST_ROOT/home"
mkdir -p "$TEST_HOME"
printf 'existing config\n' > "$TEST_HOME/.gitconfig"

DOTFILES_PATH="$REPO_ROOT" DOTFILES_HOME="$TEST_HOME" "$REPO_ROOT/scripts/link-dotfiles" >/dev/null

[ -L "$TEST_HOME/.zshrc" ]
[ "$(readlink "$TEST_HOME/.zshrc")" = "$REPO_ROOT/zsh/.zshrc" ]
[ -L "$TEST_HOME/.gitconfig" ]
[ -f "$TEST_HOME/.gitconfig.bak" ]
grep -q 'existing config' "$TEST_HOME/.gitconfig.bak"

# A second run must be idempotent and must not create another backup.
DOTFILES_PATH="$REPO_ROOT" DOTFILES_HOME="$TEST_HOME" "$REPO_ROOT/scripts/link-dotfiles" >/dev/null
[ ! -e "$TEST_HOME/.gitconfig.bak.1" ]

printf 'mise setup tests passed\n'
