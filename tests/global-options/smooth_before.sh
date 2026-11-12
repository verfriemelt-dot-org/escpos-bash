#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'global character smoothing before print' '\035b\001receipt\n' none '' \
    "$root/escpos" --smooth 1 print receipt
