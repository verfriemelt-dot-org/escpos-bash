#!/usr/bin/env bash
set -euo pipefail

tests_dir=$(cd -- "${BASH_SOURCE[0]%/*}" && pwd)
suite_failed=0

run_test() {
    local description=$1 path=$2
    printf 'Testing %s...' "$description"
    if bash "$tests_dir/$path"; then
        printf '  PASS\n'
    else
        printf '  FAIL\n' >&2
        suite_failed=1
    fi
}

run_test 'print from arguments' print/argument_text.sh
run_test 'print from stdin' print/stdin_text.sh
run_test 'print with feed-before' print/feed_before.sh
run_test 'print with feed-after' print/feed_after.sh
run_test 'print with cut' print/cut_after.sh
run_test 'print with initialization' print/init_before.sh
run_test 'raw byte output from arguments' raw/argument_bytes.sh
run_test 'raw byte output from stdin' raw/stdin_bytes.sh
run_test 'ESC/POS control-token translation' command/control_tokens.sh
run_test 'line feed' feed/feed_lines.sh
run_test 'font selection' font/font_selection.sh
run_test 'paper cut' cut/paper_cut.sh
run_test 'printer initialization' init/printer_initialization.sh
run_test 'printer status print' status/status_report.sh
run_test 'global option order around print' global-options/print_option_order.sh
run_test 'global option order around raw' global-options/raw_option_order.sh

if ((suite_failed)); then
    printf 'ESC/POS test suite failed.\n' >&2
    exit 1
fi

printf 'All ESC/POS command tests passed.\n'
