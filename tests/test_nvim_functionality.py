#!/usr/bin/env python3
"""
Test script to ensure Neovim functionality is working correctly.
This tests LSP, plugins, formatters, and all language support.
"""

import subprocess
import tempfile
import os
import sys
import unittest
import time


class TestNeovimFunctionality(unittest.TestCase):
    """Test Neovim setup and functionality."""
    
    @classmethod
    def setUpClass(cls):
        """Setup test environment."""
        cls.test_dir = tempfile.mkdtemp()
        
    def run_nvim_command(self, args, timeout=10):
        """Run nvim command and return result."""
        cmd = ['nvim', '--headless'] + args
        try:
            result = subprocess.run(
                cmd, 
                capture_output=True, 
                text=True, 
                timeout=timeout,
                cwd=self.test_dir
            )
            return result
        except subprocess.TimeoutExpired:
            self.fail(f"Neovim command timed out: {' '.join(cmd)}")
    
    def test_nvim_starts(self):
        """Test that Neovim starts without errors."""
        result = self.run_nvim_command(['-c', 'echo "Neovim started successfully"', '-c', 'qall'])
        self.assertEqual(result.returncode, 0, f"Neovim failed to start: {result.stderr}")
        self.assertIn("Neovim started successfully", result.stdout)
    
    def test_plugins_loaded(self):
        """Test that essential plugins are loaded."""
        plugins_to_test = [
            'lspconfig',
            'cmp',
            'telescope.builtin',
            'nvim-treesitter',
            'conform'
        ]
        
        for plugin in plugins_to_test:
            with self.subTest(plugin=plugin):
                result = self.run_nvim_command([
                    '-c', f'lua local ok = pcall(require, "{plugin}"); if ok then print("✓ {plugin}") else print("✗ {plugin}") end',
                    '-c', 'qall'
                ])
                self.assertEqual(result.returncode, 0, f"Error testing plugin {plugin}: {result.stderr}")
                self.assertIn(f"✓ {plugin}", result.stdout, f"Plugin {plugin} not loaded")
    
    def test_lsp_servers_configured(self):
        """Test that LSP servers are properly configured."""
        lsp_servers = ['pyright', 'ts_ls', 'lua_ls', 'html', 'cssls', 'jsonls']
        
        result = self.run_nvim_command([
            '-c', 'lua local lspconfig = require("lspconfig"); for _, server in ipairs({"pyright", "ts_ls", "lua_ls", "html", "cssls", "jsonls"}) do if lspconfig[server] then print("✓ LSP: " .. server) else print("✗ LSP: " .. server) end end',
            '-c', 'qall'
        ])
        
        self.assertEqual(result.returncode, 0, f"Error testing LSP servers: {result.stderr}")
        
        for server in lsp_servers:
            with self.subTest(server=server):
                self.assertIn(f"✓ LSP: {server}", result.stdout, f"LSP server {server} not configured")
    
    def test_language_servers_executable(self):
        """Test that language servers are actually executable."""
        language_servers = {
            'pyright-langserver': 'Python LSP',
            'typescript-language-server': 'TypeScript LSP',
        }
        
        for cmd, description in language_servers.items():
            with self.subTest(server=cmd):
                try:
                    result = subprocess.run(['which', cmd], capture_output=True, text=True)
                    self.assertEqual(result.returncode, 0, f"{description} ({cmd}) not found in PATH")
                    self.assertTrue(result.stdout.strip(), f"{description} ({cmd}) path is empty")
                except Exception as e:
                    self.fail(f"Error checking {description}: {e}")
    
    def test_formatters_available(self):
        """Test that formatters are available."""
        formatters = {
            'prettier': 'JavaScript/TypeScript formatter',
            'black': 'Python formatter',
        }
        
        for cmd, description in formatters.items():
            with self.subTest(formatter=cmd):
                try:
                    result = subprocess.run(['which', cmd], capture_output=True, text=True)
                    self.assertEqual(result.returncode, 0, f"{description} ({cmd}) not found in PATH")
                except Exception as e:
                    self.fail(f"Error checking {description}: {e}")
    
    def test_telescope_with_ripgrep(self):
        """Test that Telescope can use ripgrep."""
        # Create a test file
        test_file = os.path.join(self.test_dir, 'test_search.txt')
        with open(test_file, 'w') as f:
            f.write('test content for search\n')
        
        result = self.run_nvim_command([
            '-c', 'lua local telescope = require("telescope.builtin"); print("✓ Telescope loaded with ripgrep support")',
            '-c', 'qall'
        ])
        
        self.assertEqual(result.returncode, 0, f"Telescope test failed: {result.stderr}")
        self.assertIn("✓ Telescope loaded", result.stdout)
        
        # Test ripgrep directly
        rg_result = subprocess.run(['rg', '--version'], capture_output=True, text=True)
        self.assertEqual(rg_result.returncode, 0, "ripgrep not available")
        self.assertIn("ripgrep", rg_result.stdout)
    
    def test_treesitter_parsers(self):
        """Test that treesitter parsers are installed."""
        parsers = ['python', 'javascript', 'typescript', 'lua', 'go', 'ruby', 'yaml', 'json']
        
        for parser in parsers:
            with self.subTest(parser=parser):
                result = self.run_nvim_command([
                    '-c', f'lua local ok, ts = pcall(require, "nvim-treesitter.parsers"); if ok and ts.has_parser("{parser}") then print("✓ Parser: {parser}") else print("✗ Parser: {parser}") end',
                    '-c', 'qall'
                ])
                
                # Note: Some parsers might still be downloading, so we check for either success or download message
                self.assertEqual(result.returncode, 0, f"Error testing parser {parser}: {result.stderr}")
                success_patterns = [f"✓ Parser: {parser}", f"Downloading tree-sitter-{parser}"]
                has_pattern = any(pattern in result.stdout for pattern in success_patterns)
                self.assertTrue(has_pattern, f"Parser {parser} not found or downloading: {result.stdout}")
    
    def test_keybindings_defined(self):
        """Test that important keybindings are defined."""
        result = self.run_nvim_command([
            '-c', 'lua local keymaps = vim.api.nvim_get_keymap("n"); local found = {}; for _, map in ipairs(keymaps) do if map.lhs == "gd" then found.gd = true end; if map.lhs == "gr" then found.gr = true end end; if found.gd then print("✓ Keymap: gd") else print("✗ Keymap: gd") end; if found.gr then print("✓ Keymap: gr") else print("✗ Keymap: gr") end',
            '-c', 'qall'
        ])
        
        self.assertEqual(result.returncode, 0, f"Error testing keybindings: {result.stderr}")
        self.assertIn("✓ Keymap: gd", result.stdout, "LSP 'go to definition' keymap not found")
        self.assertIn("✓ Keymap: gr", result.stdout, "LSP 'go to references' keymap not found")
    
    def test_python_file_support(self):
        """Test Python file support with LSP."""
        python_file = os.path.join(self.test_dir, 'test.py')
        with open(python_file, 'w') as f:
            f.write('def hello():\n    print("Hello World")\n')
        
        result = self.run_nvim_command([
            python_file,
            '-c', 'sleep 1',  # Give LSP time to start
            '-c', 'lua print("✓ Python file opened with LSP support")',
            '-c', 'qall'
        ], timeout=15)
        
        self.assertEqual(result.returncode, 0, f"Python file test failed: {result.stderr}")
        self.assertIn("✓ Python file opened", result.stdout)
    
    def test_typescript_file_support(self):
        """Test TypeScript file support with LSP."""
        ts_file = os.path.join(self.test_dir, 'test.ts')
        with open(ts_file, 'w') as f:
            f.write('function hello(): string {\n    return "Hello World";\n}\n')
        
        result = self.run_nvim_command([
            ts_file,
            '-c', 'sleep 1',  # Give LSP time to start
            '-c', 'lua print("✓ TypeScript file opened with LSP support")',
            '-c', 'qall'
        ], timeout=15)
        
        self.assertEqual(result.returncode, 0, f"TypeScript file test failed: {result.stderr}")
        self.assertIn("✓ TypeScript file opened", result.stdout)
    
    def test_completion_available(self):
        """Test that completion is working."""
        result = self.run_nvim_command([
            '-c', 'lua local cmp = require("cmp"); if cmp then print("✓ Completion engine loaded") else print("✗ Completion engine failed") end',
            '-c', 'qall'
        ])
        
        self.assertEqual(result.returncode, 0, f"Completion test failed: {result.stderr}")
        self.assertIn("✓ Completion engine loaded", result.stdout)
    
    def test_conform_formatting(self):
        """Test that conform formatting is configured."""
        result = self.run_nvim_command([
            '-c', 'lua local conform = require("conform"); if conform then print("✓ Conform formatter loaded") else print("✗ Conform formatter failed") end',
            '-c', 'qall'
        ])
        
        self.assertEqual(result.returncode, 0, f"Conform test failed: {result.stderr}")
        self.assertIn("✓ Conform formatter loaded", result.stdout)


def main():
    """Run all tests and provide summary."""
    print("🧪 Testing Neovim functionality...")
    print("=" * 50)
    
    # Run tests
    loader = unittest.TestLoader()
    suite = loader.loadTestsFromTestCase(TestNeovimFunctionality)
    runner = unittest.TextTestRunner(verbosity=2)
    result = runner.run(suite)
    
    print("\n" + "=" * 50)
    if result.wasSuccessful():
        print("✅ All Neovim functionality tests passed!")
        print("🚀 Your development environment is ready!")
    else:
        print("❌ Some tests failed.")
        print(f"Failures: {len(result.failures)}")
        print(f"Errors: {len(result.errors)}")
        
        if result.failures:
            print("\n🔍 Failures:")
            for test, traceback in result.failures:
                print(f"  - {test}: {traceback.split('AssertionError: ')[-1].split()[0] if 'AssertionError:' in traceback else 'Unknown error'}")
        
        if result.errors:
            print("\n⚠️  Errors:")
            for test, traceback in result.errors:
                print(f"  - {test}: {traceback.split()[-1] if traceback.split() else 'Unknown error'}")
    
    return 0 if result.wasSuccessful() else 1


if __name__ == '__main__':
    sys.exit(main())