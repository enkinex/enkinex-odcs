#!/usr/bin/env just --justfile

docs:
    kcl doc generate

example:
    kcl test/contract/contract.k

test:
    kcl vet test/contract/contract.yaml odcs.k --format yaml --schema DataContract
