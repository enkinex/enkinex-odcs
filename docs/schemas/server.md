# `server` module

Connection details for the servers where the datasets reside — sources and
targets. A shared `ServerObject` base carries the properties common to every
server, and 30+ thin per-type schemas add each backend's specific fields.

## Schema Mapping

| KCL schema                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ODCS JSON Schema entity                                                                                                |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| `ServerObject` (`server/base.k`)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | common server properties shared by every `$defs/ServerSource` branch (`server`, `description`, `environment`, `roles`) |
| `CustomServer` (`server/custom.k`)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | `$defs/ServerSource` → the `custom` branch (the permissive superset of every server field)                             |
| `Server` (`server/common.k`)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | `$defs/Server` (the `oneOf` over `$defs/ServerSource`, discriminated by `type`)                                        |
| `ApiServer`, `AthenaServer`, `AzureServer`, `BigQueryServer`, `ClickHouseServer`, `GoogleCloudSqlServer`, `DatabricksServer`, `IBMDB2Server`, `DenodoServer`, `DremioServer`, `DuckdbServer`, `GlueServer`, `HiveServer`, `ImpalaServer`, `InformixServer`, `KafkaServer`, `KinesisServer`, `LocalServer`, `MySqlServer`, `OracleServer`, `PostgresServer`, `PrestoServer`, `PubSubServer`, `RedshiftServer`, `S3Server`, `SftpServer`, `SnowflakeServer`, `SqlserverServer`, `SynapseServer`, `TrinoServer`, `VerticaServer`, `ZenServer` (`server/*.k`) | the per-`type` conditional branches of `$defs/ServerSource` (one KCL schema per server `type`)                         |

## Architecture Decisions

- **`ServerObject` base for common fields.** Every per-type server and the
  general `Server` extend `ServerObject`, which itself extends the `common`
  `StableIdCustomizable` chain — so every server inherits `id` and
  `customProperties` in addition to `server` / `description` / `environment` /
  `roles`.
- **`ServerType` is a closed union** of the 34 documented values (including both
  `postgres` and `postgresql`, plus `custom`).
- **Two ways to model one server, on purpose:**
    - **General `Server`** — extends `CustomServer` (every field optional) and
      adds `type` + per-type `check`s. This is the **YAML→KCL parse target**: the
      root `DataContract.servers: [Server]` auto-coerces raw YAML server entries
      into `Server`, and the per-type `check`s validate each backend's required
      fields on that path (e.g. a `bigquery` server missing `project`/`dataset`
      fails).
    - **Typed servers** (`BigQueryServer`, `PostgresServer`, …) — freeze `$type`
      to a literal and declare exactly that backend's required fields. These are
      for **precise, self-documenting KCL authoring**.
- **Discriminated validation via `check`s, not a factory.** KCL cannot select a
  child schema from a sibling `type` value during parsing, and it pre-coerces a
  `[Server]`-typed attribute to `Server` before any schema body runs. A
  construction-factory lambda was prototyped and **removed** because it only
  fires when called explicitly; the per-type `check`s on `Server` give the same
  validation with zero wiring on the native parse path.
- **Doc-sourced port defaults.** Optional ports with documented defaults use
  `port?: int = <n>` (e.g. `sqlserver` 1433, `zen` 1583, `hive` 10000,
  `impala` 21050, `informix` 9088); backends whose ports the JSON schema
  *requires* (`mysql`, `postgres`) keep a required `port` with no default.

## Open Questions

- **Two-way parsing is the central unsolved trade-off of this module.** The
  same server is representable two ways — the generic all-optional `Server`
  (which YAML coerces into and which per-type `check`s validate) and a
  specialized schema such as `BigQueryServer` (used to *write* a precise,
  BigQuery-specific declaration). Both map correctly, but keeping a permissive
  parse target *and* a family of strict authoring schemas in sync is a
  **workaround, not a final solution**. A cleaner future approach — a real
  discriminated union coerced by `type`, or codegen that derives both faces
  from one source — is left for future improvement.
- The per-type required-field rules are duplicated in two places: the `check`s
  on `Server` (for the coercion path) and the required attributes on each typed
  schema (for the authoring path). They agree today but must be kept aligned by
  hand.
- A few `type`/required-field cases where the ODCS prose docs and the JSON
  Schema disagree were resolved in favor of the JSON `ServerSource` (e.g.
  `athena.stagingDir`, `mysql.port`, `postgres.port`/`schema` kept required);
  `kinesis.stream` follows the docs where the JSON lags. These reconciliations
  should be revisited when upstream aligns the two.
