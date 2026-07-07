#!/usr/bin/env just --justfile

init:
    kcl mod update
    (cd "{{justfile_directory()}}/examples/full" && kcl mod update)

docs:
    kcl doc generate --escape-html

example:
    (cd "{{justfile_directory()}}/examples/full" && kcl contract.k)

test:
    kcl vet test/contract/contract.yaml odcs.k --format yaml --schema DataContract
    kcl vet test/catalog/schema.yaml odcs.k --format yaml --schema DataContract
    kcl vet test/catalog/property.yaml catalog/property.k --format yaml --schema SchemaProperty
