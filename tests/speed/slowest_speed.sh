#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'select slowest print speed' '\035(K\002\000\062\001' none '' "$root/escpos" speed 1
