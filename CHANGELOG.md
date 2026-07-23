# Changelog

This document tracks the history and evolution of the **Enkinex ODCS Library** for the **Open Data Contract Standard**.

## v3.1.0 - First Stable Release

* Schemas
    * Add the missing `zen` server discrimination check to `Server`
    * Restrict `timezone`/`defaultTimezone` type options to `timestamp`/`time` logical types
    * Add nested `properties` to `SchemaProperty` (required iff `logicalType: object`)
    * Make array `items` a full property descriptor via the `SchemaItemProperty` type alias (replaces `SchemaPropertyItems`)
    * Correct the swapped `items`/`properties` check failure messages
    * Fix the `DatetimeOptions` docstring examples to use inline dict options (per-type option schemas are not assignable to `logicalTypeOptions`)
* Documentation
    * Fix the README backward-compatibility disclaimer rendering and release badge
    * Update `docs/schemas/*` — catalog item/object rules and divergences, quality operator semantics, server `zen` rule
    * Regenerate the `docs/library/odcs.md` schema reference
    * Align `CONTRIBUTING.md` with the `test/odcs.*.yaml` fixture naming
    * Add `CODE_OF_CONDUCT.md` and `SECURITY.md`
* Validation
    * Add one happy-path fixture per module: `test/odcs.module.{catalog,common,contract,iam,quality,server}.yaml`
    * Rename the full example to `test/odcs.full.example.yaml`
* CI/CD
    * Update `kcl.mod` version to `3.1.0`

## v3.1.0-rc1 - First v3.1.0 Release Candidate

* Schemas
    * StableIdObject schema renamed to StableId
* Documentation
    * Update `README.md`
    * Update `AUTHORS.md`
    * Update `CONTRIBUTING.md`
    * Update `docs/schemas/*.md`
* Sample Project
    * Move to a new repository at `enkinex-odcs-tutorial`
* Validation
    * Add validation test case for ODCS full example
* CI/CD
    * Update `kcl.mod` version
    * Update `Justfile` commands
    * Add `.github` test workflow and configuration

## v3.1.0-draft - Initial v3.1.0 Draft

* Schemas
    * Catalog Schemas
    * Common Schemas
    * Contract Fundamentals Schemas
    * IAM Schemas
    * Quality Schemas
    * Server Schemas
* Documentation
    * `README.md`
    * Schema Mapping and Architectural Decisions
    * Reference documentation generated from KCL
    * Tutorial
* Sample Project
    * ODCS Data Contract full example implemented as a KCL modular project
* Validation
    * Validate DataContract schema
