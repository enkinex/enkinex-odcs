#!/usr/bin/env bash
# Vendors the official ODCS corpus (positive examples and negative tests) from a
# tagged checkout of bitol-io/open-data-contract-standard, byte for byte.
#
#   test/conformance/sync.sh <odcs-checkout> <tag>           copy into odcs-<tag>/
#   test/conformance/sync.sh <odcs-checkout> <tag> --check   prove the copy is unmodified
#
# Sources, read from the tag (not the working tree):
#   docs/examples/**/*.odcs.yaml          -> odcs-<tag>/examples/
#   src/script/negative-tests/*.odcs.yaml -> odcs-<tag>/negative/
set -euo pipefail

if [ $# -lt 2 ]; then
    echo "usage: $0 <odcs-checkout> <tag> [--check]" >&2
    exit 2
fi
src=$1
tag=$2
mode=${3:-}
here=$(cd "$(dirname "$0")" && pwd)
dest="$here/odcs-$tag"

git -C "$src" rev-parse -q --verify "refs/tags/$tag" >/dev/null || {
    echo "tag '$tag' not found in $src" >&2
    exit 2
}

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

git -C "$src" ls-tree -r --name-only "$tag" -- docs/examples src/script/negative-tests |
    grep '\.odcs\.yaml$' |
    while read -r path; do
        case $path in
        docs/examples/*) out="$tmp/examples/${path#docs/examples/}" ;;
        src/script/negative-tests/*) out="$tmp/negative/${path#src/script/negative-tests/}" ;;
        esac
        mkdir -p "$(dirname "$out")"
        git -C "$src" show "$tag:$path" >"$out"
    done

if [ "$mode" = "--check" ]; then
    if diff -r "$tmp" "$dest" >/dev/null; then
        echo "odcs-$tag matches tag $tag ($(find "$tmp" -name '*.odcs.yaml' | wc -l) files)"
    else
        diff -rq "$tmp" "$dest" >&2 || true
        echo "odcs-$tag differs from tag $tag: re-run without --check" >&2
        exit 1
    fi
else
    rm -rf "$dest"
    mkdir -p "$dest"
    cp -R "$tmp/." "$dest/"
    echo "vendored $(find "$dest" -name '*.odcs.yaml' | wc -l) files from tag $tag into ${dest#"$PWD"/}"
fi
