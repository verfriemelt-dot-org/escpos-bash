#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'global underline after command' '\033-\002receipt\n' none '' \
    "$root/escpos" print receipt --underline 2
