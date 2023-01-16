#!/usr/bin/env bash

set -euo pipefail
{% raw %}
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONF_PATH="${SCRIPT_PATH}/.env"
# shellcheck source=.env
test -f "${CONF_PATH}" && source "${CONF_PATH}"

function usage {
{% endraw %}
    CMD="{{ filename }}"
{% raw %}
    cat <<EOT
<Description>

Usage:
    ${CMD} help         Print this message and quit
    ${CMD} command      <Description>
EOT
}

function cmd-command() {
    echo "Command"
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

${command} "${@:2}"
{% endraw %}
