#!/usr/bin/env bash
set -euo pipefail

if [[ ! -t 0 ]]; then
    printf 'Run this script in a terminal so it can read keys interactively.\n' >&2
    exit 1
fi

source "$(dirname "$0")"/../escpos

saved_stty=$(stty -g)
restore_terminal() {
    stty "$saved_stty"
}
trap restore_terminal EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

stty -icanon -echo min 1 time 0
printf 'Type to print; press Ctrl-D to quit.\n' >&2

char=
while IFS= read -r -N 1 char; do
    if [[ $char == $'\004' ]]; then
        escpos cut 8
        break
    elif [[ $char == $'\n' ]]; then
        escpos command LF
    else
        escpos raw "$char"
    fi
done
