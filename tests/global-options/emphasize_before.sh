#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'global emphasis before command' '\033E\001receipt\n' none '' \
    "$root/escpos" --emphasize 1 print receipt
