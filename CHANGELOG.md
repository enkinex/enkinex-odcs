# Changelog

This document tracks the history and evolution of the **Enkinex ODCS Library** for the **Open Data Contract Standard**.

## v3.2.0-rc1 - First v3.2.0 Release Candidate

Implements **ODCS v3.2.0** on **KCL 0.13.1**. One release implements one ODCS version: this one carries no compatibility
with ODCS v3.1.0 documents, which the `v3.1.0` release tag keeps serving.

* Breaking changes (upgrading from v3.1.0)
    * `apiVersion` accepts `v3.2.0` only. A v3.1.0 document is rejected: keep using tag `v3.1.0` for it, or change its
      `apiVersion` line, since every v3.1.0 structure the library models is valid v3.2.0
    * `status` is an optional, open `str` (was a required closed union); narrow it to `StatusType` in a subschema to keep
      the closed set
    * `port` is `int | str` on every server, so KCL code that reads `server.port` as an integer must handle a string
    * Exported YAML gains the spec defaults `semanticType: column` on every property, `deprecated: false` on every schema
      element, and `encoding: UTF-8` on typed file and stream servers built in KCL
    * Exported YAML lists `authoritativeDefinitions` before `tags` on id-bearing elements (key order only)
    * A property without `name` inside a `properties` list now fails at the container, with
      `every entry of 'properties' requires 'name'`
    * The vendored JSON schema is renamed `odcs-json-schema-v3.2.0.json`
    * The KCL CLI floor is 0.13.1 (the design relies on subschema narrowing and on `check` messages built in scope)
* Schemas
    * Pin `apiVersion` to `v3.2.0`; make `status` optional and open, keeping `StatusType` for narrowing
    * Follow the RFC-0026a `StableId` denylist (namespaced ids such as `fdir:ISU:TAD` validate), and the widened shorthand
      (hyphens, any depth) and fully-qualified reference patterns
    * Add a stable `id` to relationships (RFC 0047), enforced as a StableId
    * Add `StableIdAuthoritativeCustomizable` to the `common` chain; SLA entries gain `customProperties` and
      `authoritativeDefinitions` (RFC 0046); custom properties gain `vendor` (RFC 0035)
    * Add `common/variable.k` (`variableReferencePattern`, `isVariable`, `hasVariable`, `variable`) for `${VAR}` tokens
      (RFC 0050); `contractCreatedTs` and team dates accept a whole variable reference
    * Add `enum` with `EnumValue` (RFC 0033): non-empty, unique by value, each value compatible with `logicalType`
    * Add `semanticType` (RFC 0034), `synonyms` with `Synonym` (RFC 0041), `deprecated` (RFC 0051), and the AI `context`
      block with `Context`, `VerifiedStatement` and `ContextConstraint` on the contract and schema objects (RFC 0038)
    * Add the `map` logical type (`$map`, `MapDefinition`, RFC 0030) and the `vector` logical type with `VectorOptions`
      (RFC 0042); a vector requires `dimensions`
    * Replace the 17 hand-written option-placement rules with one table, `optionLogicalTypes`, and one check that names
      every misplaced option
    * Servers: `port` as `int | str` (digits or a variable reference), `encoding` (RFC 0043), Athena `workgroup` with
      `stagingDir` optional; `workgroup`, `catalogUrl` and `namespace` are scoped to their server type
    * Add the `exasol`, `hana`, `iceberg`, `ingres`, `poet`, `teradata`, `vectorwise` and `versant` servers and the
      `btrieve` (zen) and `fastobjects` (poet) synonyms
    * Fix: `primaryKey: true` without a position is valid (positions are checked only when set); `items` and `properties`
      are no longer required on arrays and objects; item descriptors need no `name`; a custom property `value` may be
      null
    * Fix: a missing relationship `from` or `to` reports the missing attribute instead of failing inside a check
* Documentation
    * Update `docs/schemas/*`: the version rule, the open `status`, the stable id denylist, the symmetric `common`
      chains, variables, the 3.2.0 catalog semantics, `map` and `vector`, and the server superset (`docs/schemas/server.md`)
    * Add `Examples` to every typed server; README sections on versions, conformance and variables
    * Regenerate the `docs/library/odcs.md` schema reference
* Validation
    * Vendor the official ODCS v3.2.0 corpus (42 examples, 44 negative tests) under `test/conformance/`, with a ledger and
      a negative map: every negative test is rejected by the rule it targets, and the examples the library does not
      accept as published are listed with their reason (an older `apiVersion`, a deprecated structure, or the upstream
      KCL defect loading YAML floats such as `1.0`)
    * Add `test/negative/`, one contract per invariant, each rejected for the reason it names
    * Add KCL unit tests (`*_test.k`, `test/unit/`)
    * Move every fixture to `apiVersion: v3.2.0` and cover each 3.2.0 feature
* CI/CD
    * Pin KCL 0.13.1 in CI; `kcl.mod` edition `0.13.1`, version `3.2.0-rc1`
    * `just check` runs fmt, lint, `test`, `unit` and `conformance`; `just lint` is one `kcl lint ./...`
    * Add a root `.editorconfig`, which `kcl fmt` honours since 0.13

## v3.1.0 - First Stable Release

* Schemas
    * Add the missing `zen` server discrimination check to `Server`
    * Restrict `timezone`/`defaultTimezone` type options to `timestamp`/`time` logical types
    * Add nested `properties` to `SchemaProperty` (required iff `logicalType: object`)
    * Make array `items` a full property descriptor via the `SchemaItemProperty` type alias (replaces `SchemaPropertyItems`)
    * Correct the swapped `items`/`properties` check failure messages
    * Refactor the per-type option schemas to extend `TypeOptions` (server-module design), making their instances assignable to `logicalTypeOptions`
    * Replace `DatetimeOptions` with `DateOptions`, `TimestampOptions`, and `TimeOptions`, matching the ODCS JSON schema `date` and `timestamp`/`time` branches
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
