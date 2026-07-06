# Enkinex ODCS — a KCL library for the Open Data Contract Standard

[![Standard](https://img.shields.io/badge/ODCS-v3.1.0-blue)](https://github.com/bitol-io/open-data-contract-standard/tree/v3.1.0)
[![KCL](https://img.shields.io/badge/KCL-%E2%89%A5%200.12.4-7B68EE)](https://www.kcl-lang.io/)
[![Version](https://img.shields.io/badge/version-v3.1.0--draft-orange)](./CHANGELOG.md)
[![License](https://img.shields.io/badge/license-Apache--2.0-green)](./LICENSE)

> A modular [KCL](https://www.kcl-lang.io/) implementation of the
> [Open Data Contract Standard (ODCS) v3.1.0](https://github.com/bitol-io/open-data-contract-standard/tree/v3.1.0),
> built to author, type-check, and validate data contracts as
> **Governance-as-Code**.

## Project Summary

The Open Data Contract Standard (ODCS) is a well-designed, community-driven standard, distributed as a YAML/JSON
document.
YAML is an excellent format for serializing and sharing a contract.
As organizations adopt ODCS across many domains and begin treating contracts as **governed**, **versioned code**, they
naturally reach for software-engineering affordances that a serialization format was never meant to provide on its own:
modularity, typing, and reuse. Plain YAML lacks modules and packages, so shared logic tends to be copied and pasted
across contracts, and mistakes tend to surface at runtime rather than during authoring.

**Enkinex ODCS complements the standard by expressing it as a modular KCL
schema library**. It defines an engineering layer on top of ODCS that keeps the standard
intact while adding code-level ergonomics.
KCL is "an open-source, constraint-based record and functional language" for configuration and policy whose stability
rests on "a static type system, strong immutability, and constraints", with
"schema-centric configuration types and modular abstraction with logic and
policy" ([kcl-lang.io](https://www.kcl-lang.io/)). Concretely, that gives a data contract:

- **Modularity & reuse** — schemas, imports and packages instead of copy-paste
  YAML.
- **Type safety & constraints** — invalid contracts fail at compile time, not
  in production.
- **Two-way validation** — validate existing ODCS YAML *and* author new
  contracts in typed KCL.
- **Living documentation** — a schema reference generated straight from the
  code.

Each of these is expanded in the sections below.

> [!IMPORTANT]
> **Version disclaimer.** This is the KCL **`v3.1.0-draft`** implementation,
> tracking the current **ODCS v3.1.0**. It does **not** aim to provide earlier
> ODCS versions, nor backward compatibility with deprecated fields. Deprecated
> constructs from the standard (e.g. `dataProduct`, `slaDefaultElement`) are
> intentionally omitted.

## Table of Contents

- [Why KCL as a Governance-as-Code DSL](#why-kcl-as-a-governance-as-code-dsl)
- [How the ODCS standard was mapped to KCL schemas](#how-the-odcs-standard-was-mapped-to-kcl-schemas)
- [How to use the Enkinex ODCS KCL library](#how-to-use-the-enkinex-odcs-kcl-library)
- [Getting Started with Enkinex ODCS](#getting-started-with-enkinex-odcs)
- [ODCS KCL Schema Reference](#odcs-kcl-schema-reference)
- [External References and Resources](#external-references-and-resources)
- [What's Next](#whats-next)
- [Contributing](#contributing)
- [License](#license)

## Why KCL as a Governance-as-Code DSL

This library grew out of a concrete problem: building **data mesh** projects
with many domains, where each domain owns dozens of data contracts. **YAML does
not scale** to that — and, being pure data, it offers **no computational
governance** out of the box. Tools such as the excellent
[Data Contract CLI](https://cli.datacontract.com/) validate and integrate ODCS
very well, but they do not give you the scalability of keeping
**governance-as-code in the repository**, written in a DSL designed for exactly
that purpose.

The insight came from a prior experience using KCL to model Kubernetes
applications deployed with Crossplane and Argo CD: KCL behaved for
configuration and policy the way HCL does for infrastructure-as-code. Applied
to data contracts, KCL opens up possibilities that flat YAML cannot:

- **Reusable domain libraries** — factor data-quality rules, PII/privacy
  policies, and ownership rules into shared schemas that many contracts import
  and specialize.
- **Reusable server catalogs** — define organization-wide, domain-specific, and
  environment-restricted server configurations (sources and targets) once, and
  reference them across contracts.
- **Enterprise conventions enforced in CI/CD** — apply custom parameters and
  `check` rules to enforce naming conventions and establish standardized,
  hierarchical, machine-readable identifiers for IT resources, applications,
  and data models (IDs, catalogs, tables, rules, …).
- **Export to the wider toolchain** — emit dynamically generated governance
  parameters to Terraform, Argo CD, or Crossplane, reducing IaC complexity and
  removing the need for intermediate parsers and bespoke CLIs.
- **Better AI & spec-driven workflows** — a well-typed, well-documented KCL
  schema adds a layer of declarative semantics that materially improves AI code
  assistants, spec-driven design, and overall project-lifecycle management.

## How the ODCS standard was mapped to KCL schemas

The upstream ODCS JSON Schema already organizes its `$defs` into logical
groups (fundamentals, schema/catalog, servers, quality, roles/teams, SLAs,
…). Enkinex ODCS keeps that grouping, but treats it as an **opinionated
software-engineering decision**: the KCL port is designed as a **library**
where **modularity and maintainability are first-class requirements**, so each
group becomes a KCL **module** (a directory of related schemas) that other
modules import.

The library is composed of six modules plus a root contract:

| Module                | Purpose                                                                                                                                                                                               | Detailed docs                                        |
|-----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| **`common`**          | Cross-cutting building blocks reused everywhere: the stable `id`, `customProperties`, `authoritativeDefinitions`, `tags`. Most code-reuse decisions live here and are inherited by the other modules. | [docs/schemas/common.md](docs/schemas/common.md)     |
| **`catalog`**         | The dataset shape: schema objects (tables, topics, files), their properties (columns/fields), per-logical-type options, and relationships (foreign keys).                                             | [docs/schemas/catalog.md](docs/schemas/catalog.md)   |
| **`contract`**        | Contract-level metadata: `Description`, `Pricing`, `ServiceLevelAgreement`, and support channels.                                                                                                     | [docs/schemas/contract.md](docs/schemas/contract.md) |
| **`iam`**             | Access and ownership: `Role`, `Team`, and `TeamMember`.                                                                                                                                               | [docs/schemas/iam.md](docs/schemas/iam.md)           |
| **`quality`**         | Data-quality rules (`library` / `sql` / `text` / `custom`) and their comparison operators.                                                                                                            | [docs/schemas/quality.md](docs/schemas/quality.md)   |
| **`server`**          | Connection details: a shared `ServerObject` base plus 30+ typed server schemas (postgres, bigquery, snowflake, kafka, s3, …).                                                                         | [docs/schemas/server.md](docs/schemas/server.md)     |
| **`odcs.k`** *(root)* | The root **`DataContract`** schema. It imports from every module and composes them into the final ODCS contract definition.                                                                           | [docs/schemas/odcs.md](docs/schemas/odcs.md)         |

The root `DataContract` in [`odcs.k`](odcs.k) pins `apiVersion = "v3.1.0"` and
`kind = "DataContract"`, closes `status` to a fixed set, and wires in the
module schemas (`servers`, `schema`, `description`, `support`, `price`,
`team`, `roles`, `slaProperties`) — while inheriting the shared `tags`,
`authoritativeDefinitions`, and `customProperties` blocks from the `common`
module.

> The **design decisions and trade-offs** behind each module are
> documented per module under [`docs/schemas/`](docs/schemas/).

## How to use the Enkinex ODCS KCL library

### Install / import via `kcl.mod`

Add the package to your KCL module's `kcl.mod` dependencies (Git or OCI source,
per your setup), then import the schemas you need:

```kcl
import enkinex_odcs as odcs

contract = odcs.DataContract {
    id = "53581432-6c55-4ba2-a65f-72344a91553a"
    name = "seller_payments_v1"
    version = "1.1.0"
    status = "active"
    domain = "seller"
}
```

### Validate an existing YAML contract

You do not have to rewrite anything to get validation — point `kcl vet` at an
existing ODCS YAML file and the root schema:

```bash
kcl vet path/to/contract.yaml odcs.k --format yaml --schema DataContract
```

The YAML is coerced into the typed schemas, so per-type server rules, the
data-quality `oneOf` operator rule, and the stable-`id` pattern all fire on the
validation path.

### Justfile targets

Common tasks are wrapped in the [`Justfile`](Justfile):

```bash
just test      # kcl vet the contract + catalog fixtures against the schemas
just example   # kcl test the sample DataContract in test/contract/
just docs      # regenerate docs/enkinex-odcs.md from the schema docstrings
```

## Getting Started with Enkinex ODCS

A hands-on quick-start — porting the canonical ODCS **full example** contract
into an equivalent KCL project, section by section — lives in
**[docs/tutorial.md](docs/tutorial.md)**.

> The tutorial content is delivered by a separate backlog item (the
> "sample-project quick tutorial" issue); this page is the placeholder it will
> fill.

## ODCS KCL Schema Reference

The complete, per-schema API reference is **auto-generated by the KCL CLI**
from the schema docstrings and property definitions:

**➡ [docs/enkinex-odcs.md](docs/enkinex-odcs.md)**

Regenerate it after any schema change with:

```bash
just docs      # runs: kcl doc generate --escape-html
```

## External References and Resources

- **Open Data Contract Standard (ODCS) v3.1.0** — the upstream standard this
  library mirrors:
  <https://github.com/bitol-io/open-data-contract-standard/tree/v3.1.0>
    - ODCS documentation: <https://github.com/bitol-io/open-data-contract-standard/tree/main/docs>
    - Source JSON Schema mirrored here: [`odcs-json-schema-v3.1.0.json`](odcs-json-schema-v3.1.0.json)
- **KCL language** — the configuration & policy DSL used for the
  implementation: <https://www.kcl-lang.io/>
- **Data Contract CLI** — complementary validation/integration tooling:
  <https://cli.datacontract.com/>

## What's Next

- **Published module distribution** — cut the final **`v3.1.0`** release (from
  this `v3.1.0-draft`) once the draft has been reviewed, and publish it as an
  installable KCL module.
- **Expanded examples** — a broader gallery of contract examples beyond the
  full-example port.
- **CI validation** — automated `kcl vet` / `kcl test` checks on every change
  to keep the library and the standard in lockstep.

## Contributing

Contributions are welcome — see [CONTRIBUTING.md](CONTRIBUTING.md) and the
contributor list in [AUTHORS.md](AUTHORS.md).

## License

Licensed under the terms in [LICENSE](LICENSE).
