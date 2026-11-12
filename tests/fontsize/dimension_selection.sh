#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'separate font width and height' '\035!\041' none '' "$root/escpos" fontsize 2 3
