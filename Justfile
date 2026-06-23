#!/usr/bin/env just --justfile

docs:
    kcl doc generate

test:
  kcl vet test/contract/contract.yaml odcs.k --format yaml --schema DataContract