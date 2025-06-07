import subprocess
import os
import unittest

class TestUpScript(unittest.TestCase):
    def test_up_dry_run(self):
        env = os.environ.copy()
        env['UP_DRY_RUN'] = '1'
        env['DOTFILES_PATH'] = os.path.dirname(os.path.dirname(__file__))
        result = subprocess.run(
            ['bash', 'up'],
            env=env,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            check=True,
        )
        output = result.stdout
        branch = subprocess.check_output(
            ['git', 'rev-parse', '--abbrev-ref', 'HEAD'],
            cwd=env['DOTFILES_PATH'],
            text=True,
        ).strip()
        if branch != 'master':
            self.assertIn('skip (working on a non-master branch)', output)
        else:
            self.assertNotIn('skip (working on a non-master branch)', output)
        self.assertIn('skip (xcrun not found)', output)
        self.assertIn('Provisioning...', output)
        self.assertTrue(
            'skip (ansible-playbook not found)' in output or
            'DRYRUN: ansible-playbook --syntax-check' in output
        )
        self.assertNotIn('DRYRUN: skip loading env', output)

if __name__ == '__main__':
    unittest.main()
