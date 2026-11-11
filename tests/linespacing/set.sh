#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'set line spacing' '\033\063\036' none '' "$root/escpos" linespacing 30
