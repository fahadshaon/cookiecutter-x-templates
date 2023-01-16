import click
import logging
{% if coloredlogs %}
import coloredlogs
{% endif %}

CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])
cli = click.Group(name='cli-app-name', help="...Update ...", context_settings=CONTEXT_SETTINGS)


@cli.command(help='Deploy flask application, using built-in web server')
@click.option('--host', default='localhost', help='Bind host')
@click.option('--port', default=2700, type=click.INT, help='Bind port')
@click.option('--debug', default=True, type=click.BOOL, help='Debug mode')
def deploy(host='localhost', port=2700, debug=True):
    app.debug = debug
    app.run(host=host, port=port)


if __name__ == '__main__':
    logging_format = '[%(asctime)s] %(levelname)s: %(message)s'
    {% if coloredlogs %}
    coloredlogs.install(level='INFO', logger=logging.getLogger(), fmt=logging_format)
    {% else %}
    logging.basicConfig(format=logging_format, level=logging.INFO)
    {% endif %}

    cli()

