import importlib
import logging

import coloredlogs

from .core import cli


def import_command_modules():
    # Import the modules with @click commands
    # Not importing automatically, since these tends to be expensive
    importlib.import_module("..cli", __name__)


def main() -> None:
    logging_format = '[%(asctime)s] %(levelname)s: %(message)s'
    coloredlogs.install(level=logging.INFO, logger=logging.getLogger(), fmt=logging_format)

    import_command_modules()

    cli()
