#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'global italic after command' '\033\065receipt\n' none '' \
    "$root/escpos" print receipt --italic 0
