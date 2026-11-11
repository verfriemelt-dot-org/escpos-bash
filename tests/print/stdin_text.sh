#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'print stdin' 'stdin text\n' stdin 'stdin text\n' "$root/escpos" print
