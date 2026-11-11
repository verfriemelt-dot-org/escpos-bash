#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'print with feed-before' '\033d\002receipt\n' none '' "$root/escpos" --feed-before 2 print receipt
