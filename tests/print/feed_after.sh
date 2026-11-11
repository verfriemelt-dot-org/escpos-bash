#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'print with feed-after' 'receipt\n\033d\003' none '' "$root/escpos" print receipt --feed-after 3
