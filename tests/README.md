# Neovim Development Environment Tests

This directory contains test scripts to ensure your Neovim development environment is properly configured and functional.

## Test Scripts

### 1. `check_nvim.sh` - Quick Environment Check
A fast, user-friendly script that provides an overview of your Neovim setup.

```bash
./tests/check_nvim.sh
```

**What it checks:**
- ✅ Neovim installation and version
- ✅ Essential tools (ripgrep, git)
- ✅ Language servers (pyright, typescript-language-server)
- ✅ Code formatters (prettier, black)
- ✅ Plugin system (dein.vim)
- ✅ Basic Neovim startup
- ✅ Plugin loading (LSP, Telescope)

**Output example:**
```
=== Neovim Development Environment Check ===
1. Neovim version:
NVIM v0.11.1

2. Essential tools:
  ripgrep: ✓ Available
  git: ✓ Available

3. Language servers:
  pyright: ✓ Available
  typescript-language-server: ✓ Available
```

### 2. `test_nvim_functionality.py` - Comprehensive Testing
A detailed Python test suite that thoroughly tests all aspects of the Neovim setup.

```bash
python3 tests/test_nvim_functionality.py
```

**What it tests:**
- 🔧 Plugin loading and configuration
- 🔧 LSP server configuration and availability
- 🔧 Language file support (Python, TypeScript, etc.)
- 🔧 Treesitter parser installation
- 🔧 Formatter and linter configuration
- 🔧 Keybinding setup
- 🔧 Telescope and ripgrep integration
- 🔧 Completion engine functionality

### 3. `test_scripts.py` - Unit Tests
Standard Python unittest suite for both dotfiles scripts and Neovim functionality.

```bash
python3 tests/test_scripts.py
```

**What it includes:**
- ✅ Existing script tests (upper.py, lower.py)
- ✅ Neovim startup tests
- ✅ Essential tool availability tests
- ✅ Basic functionality verification

## Running Tests

### Quick Check (Recommended)
For a fast overview of your setup:
```bash
./tests/check_nvim.sh
```

### Full Test Suite
For comprehensive testing:
```bash
python3 tests/test_scripts.py
python3 tests/test_nvim_functionality.py
```

### CI/Automated Testing
Add to your CI pipeline or automation scripts:
```bash
# Basic functionality check
bash tests/check_nvim.sh

# Unit tests
python3 tests/test_scripts.py
```

## Understanding Test Results

### Status Indicators
- **✓ Available/Success** - Component is working correctly
- **⚠ Warning** - Component has issues but may still function
- **✗ Missing/Failed** - Component is not available or broken

### Common Issues and Solutions

#### Missing Language Servers
```bash
# Install all mise-managed development tools
mise run tools

# Or run the full setup
./up
```

#### Missing Formatters
```bash
# Install all mise-managed formatters
mise run tools

# Or run the full setup
./up
```

#### Plugin Loading Issues
```bash
# Reinstall plugins
mise run vim

# Or run full setup
./up
```

#### Performance Issues
If startup is slow (>2000ms), consider:
- Reviewing plugin configuration
- Using lazy loading for plugins
- Checking for conflicting configurations

## Test Environment

### Requirements
- Neovim 0.8+ (tested with 0.11.1)
- Python 3.6+
- Bash shell
- Basic development tools (git, npm, pip3)

### Supported Languages
The tests verify support for:
- Python (LSP: pyright, Formatter: black)
- TypeScript/JavaScript (LSP: ts_ls, Formatter: prettier)
- HTML/CSS/JSON (LSP: vscode-langservers-extracted)
- YAML (LSP: yaml-language-server)
- Lua (LSP: lua-language-server)
- Go (LSP: gopls, Formatter: gofmt)
- Shell scripts (Linter: shellcheck, Formatter: shfmt)

## Adding New Tests

### Adding to Shell Script
Edit `check_nvim.sh` and add new checks in the appropriate section:

```bash
echo -n "  new-tool: "
if command -v new-tool >/dev/null; then echo "✓ Available"; else echo "✗ Missing"; fi
```

### Adding to Python Tests
Edit `test_nvim_functionality.py` and add new test methods:

```python
def test_new_functionality(self):
    """Test new functionality."""
    result = self.run_nvim_command(['-c', 'lua print("test")', '-c', 'qall'])
    self.assertEqual(result.returncode, 0)
    self.assertIn("test", result.stdout)
```

## Integration with Setup

These tests are designed to work with the automated setup system:

1. **After installation:** Run `./tests/check_nvim.sh` to verify setup
2. **During development:** Use tests to catch configuration issues
3. **Before commits:** Ensure tests pass to maintain functionality

## Troubleshooting

### Test Timeouts
If tests timeout, increase the timeout value or check for:
- Slow plugin loading
- Network issues during package installation
- Resource constraints

### False Positives
Some warnings are expected during initial setup:
- Treesitter parsers downloading
- Language servers not yet configured
- Formatters not installed

Run `./up` to complete the setup, then re-run tests.

### Getting Help
1. Check Neovim health: `:checkhealth` in Neovim
2. Review test output for specific error messages
3. Ensure all dependencies are installed via `./up`
4. Check the main dotfiles documentation in `CLAUDE.md`
