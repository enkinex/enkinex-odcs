#!/usr/bin/env bash
# Library negatives: every test/negative/*.yaml must be rejected, and the
# rejection must contain the fragment its "# expect: <fragment>" header names.
# One file per invariant, so deleting a rule fails a test.
set -uo pipefail

cd "$(dirname "$0")/.."
source test/lib.sh

errors=0
count=0
for f in test/negative/*.yaml; do
    count=$((count + 1))
    expect=$(sed -n 's/^# expect: //p' "$f" | head -1)
    if [ -z "$expect" ]; then
        echo "  ✗ $f has no '# expect:' header"
        errors=$((errors + 1))
        continue
    fi
    out=$(vet "$f")
    if [ $? -eq 0 ]; then
        echo "  ✗ $f is ACCEPTED; it must be rejected with '$expect'"
        errors=$((errors + 1))
    elif ! grep -qF -- "$expect" <<<"$out"; then
        echo "  ✗ $f is rejected, but not for '$expect': $(first_error <<<"$out")"
        errors=$((errors + 1))
    fi
done
echo "negative fixtures: $((count - errors)) / $count rejected for their stated reason"
[ $errors -eq 0 ]
