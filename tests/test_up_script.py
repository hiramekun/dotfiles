import subprocess
import os
import unittest

class TestUpScript(unittest.TestCase):
    def test_up_dry_run(self):
        env = os.environ.copy()
        env['UP_DRY_RUN'] = '1'
        subprocess.check_call(['bash', 'up'], env=env)

if __name__ == '__main__':
    unittest.main()
