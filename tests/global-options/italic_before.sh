#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'global italic before command' '\033\064receipt\n' none '' \
    "$root/escpos" --italic 1 print receipt
