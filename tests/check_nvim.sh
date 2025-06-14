#!/bin/bash
# Simple Neovim functionality checker

echo "=== Neovim Development Environment Check ==="

# Basic checks
echo "1. Neovim version:"
nvim --version | head -1

echo -e "\n2. Essential tools:"
echo -n "  ripgrep: "
if command -v rg >/dev/null; then echo "✓ Available"; else echo "✗ Missing"; fi

echo -n "  git: "
if command -v git >/dev/null; then echo "✓ Available"; else echo "✗ Missing"; fi

echo -e "\n3. Language servers:"
echo -n "  pyright: "
if command -v pyright-langserver >/dev/null; then echo "✓ Available"; else echo "✗ Missing"; fi

echo -n "  typescript-language-server: "
if command -v typescript-language-server >/dev/null; then echo "✓ Available"; else echo "✗ Missing"; fi

echo -e "\n4. Formatters:"
echo -n "  prettier: "
if command -v prettier >/dev/null; then echo "✓ Available"; else echo "✗ Missing"; fi

echo -n "  black: "
if command -v black >/dev/null; then echo "✓ Available"; else echo "✗ Missing"; fi

echo -e "\n5. Plugin system:"
if [ -d "$HOME/dotfiles/vim/dein" ]; then
    echo "  dein.vim: ✓ Installed"
else
    echo "  dein.vim: ✗ Missing"
fi

echo -e "\n6. Neovim startup test:"
if nvim --headless -c 'echo "Startup OK"' -c 'qall' 2>/dev/null; then
    echo "  Startup: ✓ Success"
else
    echo "  Startup: ✗ Failed"
fi

echo -e "\n7. Plugin loading test:"
if nvim --headless -c 'lua if pcall(require, "lspconfig") then print("LSP_OK") end' -c 'qall' 2>/dev/null | grep -q "LSP_OK"; then
    echo "  LSP plugin: ✓ Loaded"
else
    echo "  LSP plugin: ⚠ Not loaded (may need installation)"
fi

if nvim --headless -c 'lua if pcall(require, "telescope") then print("TELESCOPE_OK") end' -c 'qall' 2>/dev/null | grep -q "TELESCOPE_OK"; then
    echo "  Telescope: ✓ Loaded"
else
    echo "  Telescope: ⚠ Not loaded (may need installation)"
fi

echo -e "\n=== Summary ==="
echo "✓ = Working correctly"
echo "⚠ = Needs attention but functional"  
echo "✗ = Missing or broken"

echo -e "\nTo install missing components, run: sh up"
echo "For manual installation:"
echo "  npm install -g pyright typescript-language-server prettier"
echo "  pip3 install black"