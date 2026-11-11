#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'global options around raw' '\033@\033d\001\033M\002A\033d\002\033d\006\035V\000' none '' \
    "$root/escpos" raw $'\101' --init --feed-before 1 --font 2 --feed-after 2 --cut
