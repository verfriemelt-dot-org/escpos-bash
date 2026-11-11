#!/usr/bin/env bash

run_output_command() {
    local input_mode=$1 input_data=$2
    shift 2
    if [[ $input_mode == stdin ]]; then
        printf '%b' "$input_data" | PRINTER=/dev/stdout "$@"
    else
        PRINTER=/dev/stdout "$@"
    fi
}

assert_output() {
    local description=$1 expected=$2 input_mode=$3 input_data=$4
    local failed=0
    shift 4

    printf 'Testing %s...' "$description"
    if run_output_command "$input_mode" "$input_data" "$@" |
        cmp <(printf '%b' "$expected") - >/dev/null 2>&1; then
        printf '  PASS\n'
    else
        printf '  FAIL\n' >&2
        failed=1
    fi

    if ((failed)) || [[ ${ESC_POS_TEST_RUNNER:-0} != 1 ]]; then
        printf 'Expected bytes (hex and character view):\n' >&2
        printf '%b' "$expected" | od -An -tx1c >&2
        printf 'Actual bytes (hex and character view):\n' >&2
        run_output_command "$input_mode" "$input_data" "$@" | od -An -tx1c >&2
    fi
    return "$failed"
}
