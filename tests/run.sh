#!/usr/bin/env bash
set -euo pipefail

tests_dir=$(cd -- "${BASH_SOURCE[0]%/*}" && pwd)
suite_failed=0

run_test() {
    local path=$1
    if ! ESC_POS_TEST_RUNNER=1 bash "$tests_dir/$path"; then
        printf 'Failed test: %s\n' "$path" >&2
        suite_failed=1
    fi
}

run_test print/argument_text.sh
run_test print/stdin_text.sh
run_test print/feed_before.sh
run_test print/feed_after.sh
run_test print/cut_after.sh
run_test print/init_before.sh
run_test raw/argument_bytes.sh
run_test raw/stdin_bytes.sh
run_test command/control_tokens.sh
run_test feed/feed_lines.sh
run_test font/font_selection.sh
run_test speed/speed_selection.sh
run_test speed/slowest_speed.sh
run_test speed/default_speed.sh
run_test emphasize/disable.sh
run_test emphasize/enable.sh
run_test italic/disable.sh
run_test italic/enable.sh
run_test underline/disable.sh
run_test underline/single.sh
run_test underline/double.sh
run_test align/alignment.sh
run_test barcode/code39.sh
run_test qrcode/model2.sh
run_test cut/paper_cut.sh
run_test cut/paper_cut_custom_feed.sh
run_test init/printer_initialization.sh
run_test status/status_report.sh
run_test global-options/print_option_order.sh
run_test global-options/raw_option_order.sh
run_test global-options/align_before.sh
run_test global-options/align_after.sh
run_test global-options/emphasize_before.sh
run_test global-options/emphasize_after.sh
run_test global-options/italic_before.sh
run_test global-options/italic_after.sh
run_test global-options/underline_before.sh
run_test global-options/underline_after.sh

if ((suite_failed)); then
    exit 1
fi
