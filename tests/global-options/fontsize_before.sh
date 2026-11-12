#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'global font size before print' '\035!\021receipt\n' none '' \
    "$root/escpos" --fontsize 2 print receipt
