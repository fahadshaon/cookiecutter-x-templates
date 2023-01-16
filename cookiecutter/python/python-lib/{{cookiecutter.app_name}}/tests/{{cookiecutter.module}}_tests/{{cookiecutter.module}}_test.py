from unittest.case import TestCase

from {{cookiecutter.module}}.{{cookiecutter.module}} import hello


class CommandTest(TestCase):

    def test_hello(self):
        self.assertEqual("Hello world", hello())
