import subprocess
import sys
import os
import unittest

SCRIPTS_DIR = os.path.join(os.path.dirname(__file__), '..', 'scripts')
TESTS_DIR = os.path.dirname(__file__)

class TestScripts(unittest.TestCase):
    def test_upper(self):
        output = subprocess.check_output([sys.executable, os.path.join(SCRIPTS_DIR, 'upper.py'), 'hello'])
        self.assertEqual(output.decode().strip(), 'HELLO')

    def test_lower(self):
        output = subprocess.check_output([sys.executable, os.path.join(SCRIPTS_DIR, 'lower.py'), 'HELLO'])
        self.assertEqual(output.decode().strip(), 'hello')

class TestNeovimSetup(unittest.TestCase):
    """Test Neovim development environment setup."""
    
    def test_nvim_check_script_runs(self):
        """Test that the Neovim check script runs without errors."""
        check_script = os.path.join(TESTS_DIR, 'check_nvim.sh')
        result = subprocess.run(['bash', check_script], capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, f"Neovim check script failed: {result.stderr}")
        
        # Check that essential components are present in output
        self.assertIn('NVIM v', result.stdout, "Neovim version not found")
        self.assertIn('ripgrep:', result.stdout, "ripgrep check not found")
        self.assertIn('Startup:', result.stdout, "Startup check not found")
    
    def test_nvim_starts_successfully(self):
        """Test that Neovim starts without critical errors."""
        try:
            result = subprocess.run(
                ['nvim', '--headless', '-c', 'echo "Test successful"', '-c', 'qall'],
                capture_output=True, text=True, timeout=10
            )
            self.assertEqual(result.returncode, 0, f"Neovim failed to start: {result.stderr}")
            # Check that nvim ran without fatal errors (return code 0 is sufficient)
            # Output might go to different streams depending on configuration
        except subprocess.TimeoutExpired:
            self.fail("Neovim startup timed out")
    
    def test_ripgrep_available(self):
        """Test that ripgrep is available for Telescope."""
        result = subprocess.run(['which', 'rg'], capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, "ripgrep not found in PATH")
        
        # Test ripgrep version
        result = subprocess.run(['rg', '--version'], capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, "ripgrep not working")
        self.assertIn('ripgrep', result.stdout)

if __name__ == '__main__':
    unittest.main()
