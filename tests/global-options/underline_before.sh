#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'global underline before command' '\033-\001receipt\n' none '' \
    "$root/escpos" --underline 1 print receipt
