import click

cli = click.Group(
    name='{{ cookiecutter.app_name | slugify }}', help="{{ cookiecutter.description }}",
    context_settings={'help_option_names': ['-h', '--help']}
)
