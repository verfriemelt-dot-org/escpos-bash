#!/usr/bin/env bash
set -euo pipefail

tests_dir=$(cd -- "${BASH_SOURCE[0]%/*}" && pwd)
suite_failed=0

run_test() {
    local test_file=$1
    if ! ESC_POS_TEST_RUNNER=1 bash "$test_file"; then
        printf 'Failed test: %s\n' "${test_file#"$tests_dir"/}" >&2
        suite_failed=1
    fi
}

cd "$tests_dir"
for test in **/*.sh; do
    run_test "$test"
done

if ((suite_failed)); then
    exit 1
fi
