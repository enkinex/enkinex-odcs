#!/usr/bin/env bash
# Measures the library against the official ODCS corpus vendored by sync.sh.
#
#   test/conformance/run.sh            the gate: exits non-zero on any surprise
#   test/conformance/run.sh --report   prints every example and test with its outcome
#
# Positive examples (odcs-v3.2.0/examples) must validate, or carry a ledger entry
# (ledger.yaml). An entry without `normalize` means "rejected as published": with
# `expect`, for that reason only. An entry with `normalize` means the published
# document is rejected, and the copy rewritten by those steps must validate, so
# the rest of its content is still checked. A stale entry fails the gate.
#
# Negative tests (odcs-v3.2.0/negative) must be rejected with the message
# fragment negative.yaml names. A `pending` entry tolerates another reason until
# its task lands, and fails the gate once the fragment matches.
set -uo pipefail

cd "$(dirname "$0")/../.."
source test/lib.sh

corpus=test/conformance/odcs-v3.2.0
ledger=test/conformance/ledger.yaml
negmap=test/conformance/negative.yaml
report=false
[ "${1:-}" = "--report" ] && report=true

reason_ok='^(D[0-9]+|ODCS-[0-9]+|upstream-kcl)([^A-Za-z0-9]|$)'
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
errors=0
problem() {
    echo "  ✗ $*"
    errors=$((errors + 1))
}

# normalize <steps> <in> <out>: rewrites a copy of an example.
#   apiVersion   any published version becomes v3.2.0 (D2: the library accepts v3.2.0 only)
#   dataProduct  the deprecated root field is dropped (D5)
#   team         the deprecated array form becomes {members: [...]} (D5)
normalize() {
    local steps=$1 in=$2 out=$3 step
    cp "$in" "$out"
    for step in ${steps//,/ }; do
        case $step in
        apiVersion) sed -i.bak -E 's/^apiVersion:.*/apiVersion: v3.2.0/' "$out" ;;
        dataProduct) sed -i.bak -E '/^dataProduct:/d' "$out" ;;
        team)
            awk '/^team:[[:space:]]*$/ {print; print "  members:"; t=1; next}
                 t && /^[^[:space:]#]/ {t=0}
                 t {print "  " $0; next}
                 {print}' "$out" >"$out.tmp" && mv "$out.tmp" "$out"
            ;;
        *)
            echo "unknown normalize step '$step'" >&2
            return 2
            ;;
        esac
    done
    rm -f "$out.bak"
}

ledger_rows=$(records "$ledger" example reason normalize expect) || exit 2
neg_rows=$(records "$negmap" test expect pending) || exit 2

echo "## positive examples ($corpus/examples)"
pass=0
ledgered=0
while IFS=$'\x1f' read -r ex reason steps expect; do
    [ -n "$ex$reason" ] || continue
    [ -f "$corpus/examples/$ex" ] || problem "ledger names a missing example: $ex"
    [[ $reason =~ $reason_ok ]] || problem "ledger entry for $ex must name a decision, a task or upstream-kcl: '$reason'"
done <<<"$ledger_rows"
while IFS= read -r file; do
    ex=${file#"$corpus/examples/"}
    row=$(printf '%s\n' "$ledger_rows" | awk -F'\037' -v e="$ex" '$1 == e')
    out=$(vet "$file")
    rc=$?
    if [ -z "$row" ]; then
        if [ $rc -eq 0 ]; then
            pass=$((pass + 1))
            $report && echo "  ✓ $ex"
        else
            problem "$ex is rejected and has no ledger entry: $(first_error <<<"$out")"
        fi
        continue
    fi
    IFS=$'\x1f' read -r _ reason steps expect <<<"$row"
    if [ $rc -eq 0 ]; then
        problem "$ex validates as published: remove its ledger entry ($reason)"
        continue
    fi
    if [ -z "$steps" ]; then
        if [ -n "$expect" ] && ! grep -qF -- "$expect" <<<"$out"; then
            problem "$ex is rejected, but not for '$expect': $(first_error <<<"$out")"
        else
            ledgered=$((ledgered + 1))
            $report && echo "  ~ $ex  [$reason] $(first_error <<<"$out")"
        fi
        continue
    fi
    normalize "$steps" "$file" "$tmp/normalized.yaml" || exit 2
    out2=$(vet "$tmp/normalized.yaml")
    if [ $? -eq 0 ]; then
        ledgered=$((ledgered + 1))
        $report && echo "  ≈ $ex  [$reason] validates after normalize: $steps"
    else
        problem "$ex is still rejected after normalize [$steps]: $(first_error <<<"$out2")"
    fi
done < <(find "$corpus/examples" -name '*.odcs.yaml' | LC_ALL=C sort)

echo "## negative tests ($corpus/negative)"
matched=0
pending=0
while IFS=$'\x1f' read -r t expect task; do
    [ -n "$t$expect" ] || continue
    [ -f "$corpus/negative/$t" ] || problem "negative.yaml names a missing test: $t"
    [ -n "$expect" ] || problem "negative.yaml entry for $t has no 'expect' fragment"
    [ -z "$task" ] || [[ $task =~ $reason_ok ]] || problem "pending entry for $t must name a task: '$task'"
done <<<"$neg_rows"
while IFS= read -r file; do
    t=${file#"$corpus/negative/"}
    row=$(printf '%s\n' "$neg_rows" | awk -F'\037' -v e="$t" '$1 == e')
    out=$(vet "$file")
    rc=$?
    if [ -z "$row" ]; then
        problem "$t has no entry in negative.yaml: $(first_error <<<"$out")"
        continue
    fi
    IFS=$'\x1f' read -r _ expect task <<<"$row"
    if [ $rc -eq 0 ]; then
        problem "$t is ACCEPTED; it must be rejected with '$expect'"
        continue
    fi
    if grep -qF -- "$expect" <<<"$out"; then
        if [ -n "$task" ]; then
            problem "$t now matches '$expect': drop its 'pending: $task'"
        else
            matched=$((matched + 1))
            $report && echo "  ✓ $t"
        fi
    elif [ -n "$task" ]; then
        pending=$((pending + 1))
        $report && echo "  ~ $t  [pending $task] $(first_error <<<"$out")"
    else
        problem "$t is rejected, but not for '$expect': $(first_error <<<"$out")"
    fi
done < <(find "$corpus/negative" -name '*.odcs.yaml' | LC_ALL=C sort)

echo "positive: $pass pass, $ledgered ledgered · negative: $matched matched, $pending pending · problems: $errors"
[ $errors -eq 0 ]
