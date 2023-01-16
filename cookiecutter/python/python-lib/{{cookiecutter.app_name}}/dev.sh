#!/usr/bin/env bash

set -euo pipefail
{% raw %}
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function usage() {
    CMD="dev.sh"

    cat <<EOT
Helper script for development

Usage:
    ${CMD} help             Print this message and quit
    ${CMD} install          Create virtualenv (venv) and install the project (editable)
    ${CMD} requirements     Generate the requirements from current venv
    ${CMD} test             Run unit tests
    ${CMD} coverage         Run coverages and generate html reports

    ${CMD} docs-install     Create virtualenv (docs/venv) and install doc generation dependencies
    ${CMD} docs-generate    Generate the doc

** All the commands run from project root
EOT
}

function py_bins_path() {
    if [[ ${1-} == "app" ]]; then
        venv="venv"
        requirements="requirements.txt"
    elif [[ ${1-} == "docs" ]]; then
        venv="docs/venv"
        requirements="docs/requirements.txt"
    else
        echo "Invalid virtualenv type"
        exit 1
    fi

    python_bin="${venv}/bin/python3"
    pip_bin="${venv}/bin/pip"
}

function create_virtual_env() {
    py_bins_path "$1"
{% endraw %}
    echo "Installing {{ cookiecutter.app_name }} for development"
{% raw %}
    if [[ -x $python_bin ]]; then
        echo "Python binary found inside the virtualenv directory"
    else
        echo "Creating virtualenv ${venv}"
        python3 -m venv "${venv}"
    fi

    echo "Updating pip and wheel"
    "${pip_bin}" install -U pip wheel

    if [[ ${2-} == '-r' ]]; then
        echo "Installing requirements ${requirements} in ${venv}"
        "${pip_bin}" install install -r "${requirements}"
    fi

    if [[ ${1-} == "app" ]]; then
        echo "Installing the application in editable mode with [test]"
        "${pip_bin}" install -e ".[test]"
    fi
}

function cmd-install() {
    create_virtual_env "app" "${@}"
}

function create_requirements() {
    py_bins_path "$1"

    echo "Creating requirements file"
{% endraw %}
    "$pip_bin" freeze | grep -e '#' -e "{{ cookiecutter.app_name }}" -e 'pkg-resources==0.0.0' -e "pkg_resources==0.0.0" -v >"$requirements"
{% raw %}
}

function cmd-requirements() {
    create_requirements "app"
}

function cmd-test() {
    echo "Running unittests"
    venv/bin/python3 -m unittest discover -s "tests" -v -p '*_test.py'
}

function cmd-coverage() {
    echo "Running coverage"
    venv/bin/coverage run -m unittest discover -s tests -v -p '*_test.py'

    echo 'Running coverage report'
    venv/bin/coverage report -m

    echo 'Generating coverage html report'
    venv/bin/coverage html

    venv/bin/python3 -m unittest discover -s "tests" -v -p '*_test.py'
}

function cmd-docs-install() {
    create_virtual_env "docs"
}

function cmd-docs-requirements() {
    create_requirements "docs"
}

function cmd-docs-generate() {
    pushd docs > /dev/null || exit 1

    make html

    popd  > /dev/null || exit 1
}

if [[ -z "$*" || "$1" == '-h' || "$1" == '--help' || "$1" == 'help' ]]; then
    usage
    exit 0
fi

command="cmd-${1}"

if [[ $(type -t "${command}") != "function" ]]; then
    echo "Error: No command found"
    usage
    exit 1
fi

# All the commands run from the project root\
pushd "$SCRIPT_PATH" >/dev/null || exit 1

${command} "${@:2}"

popd >/dev/null || exit 1
{% endraw %}
