import subprocess
import os
import unittest

class TestUpScript(unittest.TestCase):
    def test_up_dry_run(self):
        env = os.environ.copy()
        env['UP_DRY_RUN'] = '1'
        result = subprocess.run(
            ['bash', 'up'],
            env=env,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            check=True,
        )
        output = result.stdout
        self.assertIn('DRYRUN: skip cloning repository', output)
        self.assertIn('skip (xcrun not found)', output)
        self.assertNotIn('DRYRUN: skip loading env', output)

if __name__ == '__main__':
    unittest.main()
