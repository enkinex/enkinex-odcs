#!/usr/bin/env just --justfile

default:
    @just --list

init:
    kcl mod update

fmt:
    kcl fmt ./...

lint:
    kcl lint ./...

docs:
    kcl doc generate --escape-html --target docs/library
    mv docs/library/docs/enkinex-odcs.md docs/library/odcs.md
    rmdir docs/library/docs/

test:
    set -e; for f in test/*.yaml; do kcl vet "$f" odcs.k --format yaml -s DataContract; done
    test/negative.sh

conformance:
    test/conformance/run.sh

check:
    kcl fmt ./...
    git diff --exit-code -- '*.k' || (echo "Code is not formatted — run 'just fmt' and commit the result." && exit 1)
    just lint
    just test
    just conformance
