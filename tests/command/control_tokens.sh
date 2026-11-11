#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'control token translation' '\033\035\034\020\000\016\017\012\015\014\011@' none '' \
    "$root/escpos" command ESC GS FS DLE NUL SO SI LF CR FF HT @
