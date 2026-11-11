#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'source escpos and call its function' '\033E\001' none '' \
    bash -c 'source "$1"; PRINTER=/dev/stdout; escpos emphasize 1' _ "$root/escpos"
