#!/usr/bin/env just --justfile

docs:
    kcl doc generate --escape-html

example:
    kcl test/contract/contract.k

test:
    kcl vet test/contract/contract.yaml odcs.k --format yaml --schema DataContract
    kcl vet test/catalog/schema.yaml odcs.k --format yaml --schema DataContract
    kcl vet test/catalog/property.yaml catalog/property.k --format yaml --schema SchemaProperty
