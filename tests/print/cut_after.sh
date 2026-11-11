#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'print with cut' 'receipt\n\035V\000' none '' "$root/escpos" print receipt --cut
