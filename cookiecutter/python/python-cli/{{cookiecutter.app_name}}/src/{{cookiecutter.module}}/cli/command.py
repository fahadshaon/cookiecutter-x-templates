import logging

from ..core import cli


@cli.command(name="hello", help="Initial test command")
def hello_cmd():
    logging.info("Hello from the {{cookiecutter.app_name}}")
