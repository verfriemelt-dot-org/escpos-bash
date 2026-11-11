#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'global emphasis after command' '\033E\000receipt\n' none '' \
    "$root/escpos" print receipt --emphasize 0
