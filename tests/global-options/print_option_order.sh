#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "${BASH_SOURCE[0]%/*}/../.." && pwd)
source "$root/tests/assert_output.sh"

assert_output 'global options around print' '\033@\033d\002\033M\001receipt\n\033d\003\033d\006\035V\000' none '' \
    "$root/escpos" --init --feed-before 2 --font 1 print receipt --feed-after 3 --cut
