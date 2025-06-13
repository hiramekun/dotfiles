import subprocess
import sys
import os
import unittest

SCRIPTS_DIR = os.path.join(os.path.dirname(__file__), '..', 'scripts')

class TestScripts(unittest.TestCase):
    def test_upper(self):
        output = subprocess.check_output([sys.executable, os.path.join(SCRIPTS_DIR, 'upper.py'), 'hello'])
        self.assertEqual(output.decode().strip(), 'HELLO')

    def test_lower(self):
        output = subprocess.check_output([sys.executable, os.path.join(SCRIPTS_DIR, 'lower.py'), 'HELLO'])
        self.assertEqual(output.decode().strip(), 'hello')

if __name__ == '__main__':
    unittest.main()
