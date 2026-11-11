#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'restore default print speed' '\035(K\002\000\062\000' none '' "$root/escpos" speed 0
