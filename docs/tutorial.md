# Enkinex ODCS Tutorial

This tutorial is a hands-on quick start for **Enkinex ODCS**. It walks you
through porting the canonical ODCS **full example** contract into an equivalent,
modular KCL project — the same one that lives under
[`examples/full`](../examples/full) — and then parsing and exporting it back to
YAML.

By the end you will have installed the KCL toolchain, created your own contract
module that depends on the `enkinex-odcs` library, authored the contract in typed
KCL split across small reusable files, and generated a validated
`contract.yaml`.

You will learn how to:

1. [Installing KCL](#1-installing-kcl) — get the KCL CLI on your machine.
2. [Creating the Contract Project Module](#2-creating-the-contract-project-module)
   — initialize a KCL module, depend on `enkinex-odcs`, and lay out a modular
   project.
3. [Declare the Contract KCL Code](#3-declare-the-contract-kcl-code) — author
   the contract as small, reusable typed KCL sources.
4. [Parse and Export to YAML](#4-parse-and-export-to-yaml) — validate, print,
   and export the contract to YAML or JSON.

---

## 1. Installing KCL

Enkinex ODCS is a KCL library, so the only prerequisite is the **KCL command-line
tool**. KCL can be installed in several ways depending on your platform and
preferences:

- **Installation scripts** for macOS, Linux, and Windows.
- **Package managers** — Homebrew (macOS), Scoop (Windows), Nix, or `go install`
  (Go 1.22+).
- **Container image** via Docker.
- **Binary releases** downloaded from GitHub and added to your `PATH`.

Because these steps are platform-specific and change over time, follow the
official, always-up-to-date guide rather than reproducing it here:

**➡ [KCL — Install](https://www.kcl-lang.io/docs/user_docs/getting-started/install)**

Once installed, confirm the CLI is on your `PATH`:

```bash
kcl --help
```

---

## 2. Creating the Contract Project Module

A contract project is just a **KCL module**: a directory with a `kcl.mod`
manifest that declares the module's identity and its dependencies. This section
creates that module, wires in the `enkinex-odcs` library, and organizes the
sources.

### Initialize the module

Use [`kcl mod init`](https://www.kcl-lang.io/docs/tools/cli/package-management/command-reference/init)
to scaffold a new module. It creates the `kcl.mod` manifest, a `kcl.mod.lock`
lockfile, and an initial `main.k`:

```bash
kcl mod init full-example --version 3.1.0-draft
```

Running it without a name initializes the **current** directory as a module;
passing a name (as above) creates a subdirectory for it.

### Add the `enkinex-odcs` dependency

Use [`kcl mod add`](https://www.kcl-lang.io/docs/tools/cli/package-management/command-reference/add)
to add the Enkinex ODCS library straight from its GitHub repository. Pin it to a
specific commit (or `--tag` / `--branch`) so builds stay reproducible:

```bash
kcl mod add --git https://github.com/enkinex/enkinex-odcs --branch main
```

This records the dependency under `[dependencies]` in your `kcl.mod`.

### Update the module after configuration changes

Whenever you edit `kcl.mod` — bumping the dependency's commit/tag, or otherwise
changing the module configuration — resync the lockfile with
[`kcl mod update`](https://www.kcl-lang.io/docs/tools/cli/package-management/command-reference/update):

```bash
kcl mod update
```

It refreshes the dependencies listed in `kcl.mod.lock` based on `kcl.mod`.

### The resulting module manifest

The example's [`examples/full/kcl.mod`](../examples/full/kcl.mod) is exactly what
the commands above produce:

```toml
[package]
name = "enkinex-odcs-full-example"
edition = "0.12.4"
version = "3.1.0-draft"
description = "Enkinex KCL implementation for ODCS full example"

[dependencies]
enkinex_odcs = { git = "https://github.com/enkinex/enkinex-odcs", branch = "main" }
```

### Structuring a modular project

The whole point of authoring contracts in KCL is **modularity and reuse**, so
the example does not cram everything into one file. It follows the **same library
structure standard** that Enkinex ODCS itself uses — one directory per logical
group of the standard — so a contract project reads like a small, organized
codebase rather than one giant document.

The `catalog/`, `contract/`, `iam/`, and `server/` directories mirror the
modules of the `enkinex-odcs` library, and the root `contract.k` composes them
into the final `DataContract`:

```text
examples/full/
├── kcl.mod                 # module manifest + enkinex-odcs dependency
├── kcl.mod.lock            # resolved dependency lockfile
├── contract.k              # root: composes every part into a DataContract
├── contract.yaml           # exported ODCS YAML (generated)
├── catalog/                # dataset shape: schema objects & properties
│   ├── payment.k
│   └── receiver.k
├── contract/               # contract-level metadata
│   ├── authoritative.k
│   ├── description.k
│   ├── price.k
│   ├── properties.k
│   ├── sla.k
│   └── support.k
├── iam/                    # access & ownership
│   ├── member.k
│   └── role.k
└── server/                 # connection details
    └── postgres.k
```

---

## 3. Declare the Contract KCL Code

With the module in place, each part of the contract is declared as a **typed KCL
value** in its own file and then referenced from the root `contract.k`. Below are
a few representative pieces — browse
[`examples/full`](../examples/full) for the complete set.

### The contract description

The `description` block is authored in
[`contract/description.k`](../examples/full/contract/description.k). It imports
the `Description` schema from the library and fills it in — including a nested
`AuthoritativeDefinition` — as a named value the root contract can reuse:

```kcl
import enkinex_odcs.contract.description
import enkinex_odcs.common.authoritative

SampleContractDescription = description.Description {
    purpose = "Views built on top of the seller tables."
    limitations = "Data based on seller perspective, no buyer information"
    usage = "Predict sales over time"
    authoritativeDefinitions = [
        authoritative.AuthoritativeDefinition {
            $type = "privacy-statement"
            url = "https://example.com/gdpr.pdf"
        }
    ]
}
```

### An IAM role

Access roles live in [`iam/role.k`](../examples/full/iam/role.k). Each is a
`Role` value; here is one of them:

```kcl
import enkinex_odcs.iam.role

StrategyReader = role.Role {
    role = "microstrategy_user_opr"
    access = "read"
    firstLevelApprovers = "Reporting Manager"
    secondLevelApprovers = "mandolorian"
}
```

### A schema object (table)

Dataset tables are declared as `SchemaObject` values. The **Receivers Master
Data** table is defined in
[`catalog/receiver.k`](../examples/full/catalog/receiver.k). In its short form,
the table wires together a handful of properties:

```kcl
ReceiversMasterDataTable = schema_object.SchemaObject {
    id = "receivers_obj"
    name = "receivers"
    physicalName = "receivers_master"
    physicalType = "table"
    businessName = "Receivers Master Data"
    description = "Master data for all receivers"
    tags: ["master-data", "receivers"]
    properties = [
        ReceiverId
        ReceiverCountry
        ReceiverName
        ReceiverType
    ]
}
```

Notice that `ReceiversMasterDataTable` **reuses code declared in the same file**:
`ReceiverId`, `ReceiverCountry`, `ReceiverName`, and `ReceiverType` are each
`SchemaProperty` variables defined above it. This is the modularity payoff — a
column is written once as a typed value and referenced by name. Open the full
[`catalog/receiver.k`](../examples/full/catalog/receiver.k) to see how those
properties are declared, and how **relationships** (foreign keys) and
**quality rules** are attached to them.

### The full DataContract

With every part authored in its own file, the root
[`contract.k`](../examples/full/contract.k) simply **imports and composes** them
into a single `DataContract`. This is the whole file, as-is:

```kcl
import enkinex_odcs.odcs
import enkinex_odcs.iam.team

import .catalog.payment
import .catalog.receiver
import .contract.authoritative as contract_authoritative
import .contract.description as contract_description
import .contract.price as contract_price
import .contract.properties as contract_properties
import .contract.sla as contract_sla
import .contract.support as contract_support
import .iam.role as contract_role
import .iam.member as contract_member
import .server.postgres as server_postgres

odcs.DataContract {
    domain = "seller"
    version = "1.1.0"
    status = "active"
    id = "53581432-6c55-4ba2-a65f-72344a91553a"
    authoritativeDefinitions = [
        contract_authoritative.SampleAuthoritativeDefinition
    ]
    description = contract_description.SampleContractDescription
    tenant = "ClimateQuantumInc"
    servers= [
        server_postgres.LocalPostgresServer
    ]
    $schema = [
        payment.PaymentMetricsTable
        receiver.ReceiversMasterDataTable
    ]
    price = contract_price.MegabyteUSD
    team = team.Team {
        name = "my-team"
        description = "The team owning the data contract"
        members = [
            contract_member.CeastWoodMember
            contract_member.MHopperMember
            contract_member.DaustinMember
        ]
    }
    roles = [
        contract_role.StrategyReader
        contract_role.QueryReader
        contract_role.RiskReader
        contract_role.BQWriter
    ]
    slaProperties = [
        contract_sla.LatencySla
        contract_sla.GeneralAvailabilitySla
        contract_sla.EndOfSupportSla
        contract_sla.EndOfLifeSla
        contract_sla.RetentionSla
        contract_sla.FrequencySla
        contract_sla.RegulatoryTimeOfAvailabilitySla
        contract_sla.AnalyticsTimeOfAvailabilitySla
    ]
    support = [
        contract_support.SlackSupport
        contract_support.EmailSupport
        contract_support.FeedbackSupport
        contract_support.TeamsSupport
    ]
    tags = ["transactions"]
    customProperties = [
        contract_properties.RulesetProperty
        contract_properties.SomeProperty
        contract_properties.DataprocClusterProperty
    ]
    contractCreatedTs = "2022-11-15T02:59:43+00:00"
}
```

The root contract reads like a **table of contents**: every field points at a
named, typed value declared elsewhere. Compare that to the equivalent
single-file
[`full-example-odcs.yaml`](https://github.com/bitol-io/open-data-contract-standard/blob/main/docs/examples/all/full-example.odcs.yaml) — hundreds of
deeply nested lines with no types, no reuse, and no compile-time checks. The KCL
version is smaller at each layer, its pieces are reusable across contracts, and
the whole code is validated the moment you build it.

---

## 4. Parse and Export to YAML

KCL is both a validator and a renderer, so the same source drives type-checking
and serialization.

**Validate** an existing ODCS YAML file against the schema:

```bash
kcl vet contract.yaml odcs.k --format yaml --schema DataContract
```

**Parse / print** the composed contract to standard output — this is where type
errors and failed constraints surface:

```bash
kcl run contract.k
```

**Export** the contract to YAML (or JSON) by choosing the output format:

```bash
kcl contract.k --format yaml > contract.yaml   # YAML
kcl contract.k --format json > contract.json   # JSON
```

### The `just example` shortcut

In this repository the export step is wrapped in the [`Justfile`](../Justfile).
Running:

```bash
just example
```

parses [`examples/full/contract.k`](../examples/full/contract.k) and writes the
result to [`examples/full/contract.yaml`](../examples/full/contract.yaml) — the
final ODCS document, generated from your typed KCL contract.
