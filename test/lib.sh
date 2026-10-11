# Shared helpers for the test runners. Sourced, never executed.
# Needs bash, POSIX sed/awk and the kcl CLI: nothing CI does not already install.

# vet <file>: validates one YAML document against DataContract. Prints kcl's
# output without colour codes; returns kcl's exit status. Run from the repo root.
vet() {
    local out rc
    out=$(kcl vet "$1" odcs.k --format yaml -s DataContract 2>&1)
    rc=$?
    printf '%s\n' "$out" | sed $'s/\x1b\\[[0-9;]*m//g'
    return $rc
}

# first_error: reduces kcl's diagnostic (on stdin) to one line: the failed
# check's message when a check failed, else the error kind and its message.
first_error() {
    local out msg
    out=$(cat)
    msg=$(grep -m1 -o 'Check failed on the condition: .*' <<<"$out" | sed 's/^Check failed on the condition: /check: /')
    if [ -z "$msg" ]; then
        msg=$(grep -E 'error\[|\^ |Error|Failed|failed' <<<"$out" |
            sed -E 's/^[[:space:]]*[0-9]*[[:space:]]*\|[[:space:]]*\^*[[:space:]]*//' | head -2 | paste -sd ' ')
    fi
    printf '%s\n' "$msg" | cut -c1-200
}

# records <file> <field>...: reads a flat YAML list of maps ("- k: v" opens a
# record, "  k: v" continues it) and prints one line per record, fields split by
# the unit separator (\x1f, so empty fields survive "read"), in the order named.
# Values may be quoted;
# "[a, b]" becomes "a,b". Comments sit on their own lines. An unknown key is an
# error, so a typo cannot silently drop a field.
records() {
    local file=$1
    shift
    awk -v fields="$*" '
        function flush() {
            if (!open) return
            line = ""
            for (i = 1; i <= nf; i++) line = line (i > 1 ? "\037" : "") rec[f[i]]
            print line
            delete rec
        }
        function unquote(v) {
            sub(/^[[:space:]]+/, "", v); sub(/[[:space:]]+$/, "", v)
            if (v ~ /^".*"$/ || v ~ /^\x27.*\x27$/) v = substr(v, 2, length(v) - 2)
            if (v ~ /^\[.*\]$/) { v = substr(v, 2, length(v) - 2); gsub(/[[:space:]]*,[[:space:]]*/, ",", v); sub(/^[[:space:]]+/, "", v); sub(/[[:space:]]+$/, "", v) }
            return v
        }
        BEGIN { nf = split(fields, f, " "); for (i = 1; i <= nf; i++) known[f[i]] = 1 }
        /^[[:space:]]*(#.*)?$/ { next }
        /^- / { flush(); open = 1; sub(/^- /, "  ") }
        /^  [A-Za-z]+:/ {
            key = $0; sub(/^  /, "", key); sub(/:.*/, "", key)
            if (!(key in known)) { printf "unknown key \"%s\" in %s:%d\n", key, FILENAME, NR > "/dev/stderr"; bad = 1 }
            val = $0; sub(/^  [A-Za-z]+:/, "", val)
            rec[key] = unquote(val)
            next
        }
        { printf "unparsable line in %s:%d: %s\n", FILENAME, NR, $0 > "/dev/stderr"; bad = 1 }
        END { flush(); exit bad }
    ' "$file"
}
