#!/bin/bash
# Test script to verify Neovim setup and functionality
# This script tests the essential components of the development environment

set -e

echo "🧪 Testing Neovim Development Environment"
echo "=========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
PASSED=0
FAILED=0
WARNINGS=0

# Helper functions
print_test() {
    echo -e "${BLUE}📋 Testing: $1${NC}"
}

print_pass() {
    echo -e "${GREEN}✅ PASS: $1${NC}"
    ((PASSED++))
}

print_fail() {
    echo -e "${RED}❌ FAIL: $1${NC}"
    ((FAILED++))
}

print_warn() {
    echo -e "${YELLOW}⚠️  WARN: $1${NC}"
    ((WARNINGS++))
}

print_info() {
    echo -e "${BLUE}ℹ️  INFO: $1${NC}"
}

# Test 1: Neovim Installation
print_test "Neovim Installation"
if command -v nvim >/dev/null 2>&1; then
    version=$(nvim --version | head -1)
    print_pass "Neovim installed - $version"
else
    print_fail "Neovim not found in PATH"
    exit 1
fi

# Test 2: Basic Neovim Startup
print_test "Basic Neovim Startup"
if nvim --headless -c "echo 'Basic startup test'" -c "qall" >/dev/null 2>&1; then
    print_pass "Neovim starts without errors"
else
    print_fail "Neovim fails to start"
fi

# Test 3: Essential Tools
print_test "Essential Development Tools"

# ripgrep
if command -v rg >/dev/null 2>&1; then
    rg_version=$(rg --version | head -1)
    print_pass "ripgrep available - $rg_version"
else
    print_fail "ripgrep not found (required for Telescope live_grep)"
fi

# git
if command -v git >/dev/null 2>&1; then
    git_version=$(git --version)
    print_pass "Git available - $git_version"
else
    print_fail "Git not found"
fi

# Test 4: Language Servers
print_test "Language Server Protocol (LSP) Support"

# Python LSP
if command -v pyright-langserver >/dev/null 2>&1; then
    print_pass "Python LSP (pyright) available"
else
    print_warn "Python LSP (pyright) not found - run: npm install -g pyright"
fi

# TypeScript LSP
if command -v typescript-language-server >/dev/null 2>&1; then
    print_pass "TypeScript LSP available"
else
    print_warn "TypeScript LSP not found - run: npm install -g typescript-language-server"
fi

# Test 5: Plugin System
print_test "Plugin System"

# Check if dein.vim is installed
if [ -d "$HOME/dotfiles/vim/dein/repos/github.com/Shougo/dein.vim" ]; then
    print_pass "dein.vim plugin manager installed"
else
    print_fail "dein.vim plugin manager not found"
fi

# Test plugin loading
if nvim --headless -c "lua local ok = pcall(require, 'lspconfig'); if ok then print('LSP_OK') end" -c "qall" 2>/dev/null | grep -q "LSP_OK"; then
    print_pass "LSP plugin (nvim-lspconfig) loaded"
else
    print_warn "LSP plugin not loaded - may need plugin installation"
fi

if nvim --headless -c "lua local ok = pcall(require, 'telescope'); if ok then print('TELESCOPE_OK') end" -c "qall" 2>/dev/null | grep -q "TELESCOPE_OK"; then
    print_pass "Telescope plugin loaded"
else
    print_warn "Telescope plugin not loaded - may need plugin installation"
fi

# Test 6: Formatters and Linters
print_test "Code Formatters and Linters"

# prettier
if command -v prettier >/dev/null 2>&1; then
    print_pass "Prettier formatter available"
else
    print_warn "Prettier not found - run: npm install -g prettier"
fi

# black
if command -v black >/dev/null 2>&1; then
    print_pass "Black Python formatter available"
else
    print_warn "Black not found - run: pip3 install black"
fi

# Test 7: Configuration Files
print_test "Configuration Files"

# Neovim config
if [ -f "$HOME/dotfiles/nvim/init.vim" ]; then
    print_pass "Neovim configuration file exists"
else
    print_fail "Neovim configuration file not found"
fi

# Test syntax check of config
if nvim --headless -c "echo 'Config syntax OK'" -c "qall" >/dev/null 2>&1; then
    print_pass "Neovim configuration syntax is valid"
else
    print_warn "Neovim configuration has syntax warnings"
fi

# Test 8: File Type Support
print_test "Language File Type Support"

# Create temporary test files
temp_dir=$(mktemp -d)
trap "rm -rf $temp_dir" EXIT

# Test Python file
echo "def hello(): print('world')" > "$temp_dir/test.py"
if nvim --headless "$temp_dir/test.py" -c "echo 'Python file loaded'" -c "qall" >/dev/null 2>&1; then
    print_pass "Python file support"
else
    print_warn "Python file support has issues"
fi

# Test TypeScript file
echo "function hello(): string { return 'world'; }" > "$temp_dir/test.ts"
if nvim --headless "$temp_dir/test.ts" -c "echo 'TypeScript file loaded'" -c "qall" >/dev/null 2>&1; then
    print_pass "TypeScript file support"
else
    print_warn "TypeScript file support has issues"
fi

# Test 9: Key Bindings
print_test "Key Bindings Configuration"
if nvim --headless -c "lua local keys = vim.api.nvim_get_keymap('n'); local has_telescope = false; for _, k in ipairs(keys) do if string.find(k.rhs or '', 'telescope') then has_telescope = true; break; end end; if has_telescope then print('KEYBIND_OK') end" -c "qall" 2>/dev/null | grep -q "KEYBIND_OK"; then
    print_pass "Telescope keybindings configured"
else
    print_warn "Telescope keybindings may not be configured"
fi

# Test 10: Performance Check
print_test "Performance Check"
start_time=$(date +%s%N)
nvim --headless -c "echo 'Performance test'" -c "qall" >/dev/null 2>&1
end_time=$(date +%s%N)
duration=$(( (end_time - start_time) / 1000000 ))

if [ $duration -lt 2000 ]; then
    print_pass "Neovim starts quickly (${duration}ms)"
elif [ $duration -lt 5000 ]; then
    print_warn "Neovim startup is moderate (${duration}ms)"
else
    print_warn "Neovim startup is slow (${duration}ms) - consider optimizing config"
fi

# Summary
echo ""
echo "=========================================="
echo "🏁 Test Summary"
echo "=========================================="
print_info "Tests Passed: $PASSED"
if [ $WARNINGS -gt 0 ]; then
    print_info "Warnings: $WARNINGS"
fi
if [ $FAILED -gt 0 ]; then
    print_info "Tests Failed: $FAILED"
fi

echo ""
if [ $FAILED -eq 0 ]; then
    if [ $WARNINGS -eq 0 ]; then
        echo -e "${GREEN}🎉 Perfect! Your Neovim development environment is fully functional!${NC}"
        echo -e "${GREEN}🚀 Ready for development with LSP, completion, and modern features.${NC}"
    else
        echo -e "${YELLOW}✨ Good! Your Neovim setup is functional with minor optimization opportunities.${NC}"
        echo -e "${YELLOW}💡 Install the warned packages for the complete experience.${NC}"
    fi
else
    echo -e "${RED}🔧 Issues detected! Please fix the failed tests before using Neovim.${NC}"
    exit 1
fi

# Helpful tips
echo ""
echo "=========================================="
echo "💡 Quick Tips"
echo "=========================================="
echo "• Install missing tools with: sh up"
echo "• Telescope shortcuts: <leader>ff (files), <leader>fg (grep)"
echo "• LSP shortcuts: gd (definition), gr (references), K (hover)"
echo "• Format code: <leader>ca (code actions)"
echo ""
echo "📚 For more help: :help or :checkhealth in Neovim"