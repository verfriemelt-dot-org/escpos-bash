#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'global alignment after command' '\x1b\x61\x02receipt\n' none '' \
    "$root/escpos" print receipt --align right
