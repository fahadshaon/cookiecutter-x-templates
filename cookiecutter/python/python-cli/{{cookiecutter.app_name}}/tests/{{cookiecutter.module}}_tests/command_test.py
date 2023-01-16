from click.testing import CliRunner
from unittest.case import TestCase

from {{cookiecutter.module}}.main import import_command_modules
from {{cookiecutter.module}}.core import cli

class CommandTest(TestCase):

    @classmethod
    def setUpClass(cls) -> None:
        import_command_modules()

    def test_hello_command_execution(self):
        runner = CliRunner()

        result = runner.invoke(cli, "hello")

        self.assertEqual(0, result.exit_code)
