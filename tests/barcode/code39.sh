#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'Code 39 barcode' \
    '\x1d\x68\x50\x1d\x77\x02\x1d\x48\x02\x1d\x6b\x45\x05\x41\x31\x32\x33\x34' \
    none '' "$root/escpos" barcode A1234
