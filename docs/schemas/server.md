# `server` module

Connection details for the servers where the datasets reside — sources and
targets. The module is a single inheritance chain that mirrors the JSON
schema's own layering: a `BaseServer` carrying the properties common to every
server, a `CustomServer` superset holding every possible source field, a
general `Server` that adds the `type` discriminator plus the `allOf`
validation, and 30+ thin per-type subschemas for ergonomic authoring.

## Schema Mapping

| KCL schema                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ODCS JSON Schema entity                                                                                                                                        |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `BaseServer` (`server/base.k`)                                                                                                                                                                                                                                                                                                                                                                                                                                            | `$defs/Server` **minus** `type` and the `allOf` block — the common properties (`server`, `description`, `environment`, `roles`, plus `id` / `customProperties` via the `common` chain) |
| `CustomServer` (`server/custom.k`)                                                                                                                                                                                                                                                                                                                                                                                                                                        | `$defs/ServerSource` → `CustomServer` — the permissive superset of all 19 source fields, every one optional                                                       |
| `Server` + `ServerSourceType` (`server/spec.k`)                                                                                                                                                                                                                                                                                                                                                                                                                           | `$defs/Server` — `type` (the 34-value enum) plus the `allOf` of per-`type` `if`/`then` conditionals, recovered as KCL `check` rules                               |
| `ApiServer`, `AthenaServer`, `AzureServer`, `BigQueryServer`, `ClickHouseServer`, `GoogleCloudSqlServer`, `DatabricksServer`, `IBMDB2Server`, `DenodoServer`, `DremioServer`, `DuckdbServer`, `GlueServer`, `HiveServer`, `ImpalaServer`, `InformixServer`, `KafkaServer`, `KinesisServer`, `LocalServer`, `MySqlServer`, `OracleServer`, `PostgresServer`, `PrestoServer`, `PubSubServer`, `RedshiftServer`, `S3Server`, `SftpServer`, `SnowflakeServer`, `SqlserverServer`, `SynapseServer`, `TrinoServer`, `VerticaServer`, `ZenServer` (`server/*.k`) | the named `$defs/ServerSource` subschemas (one KCL schema per source, same names as the JSON)                                                                     |

The inheritance chain (each level adds exactly what its JSON counterpart adds):

```
StableIdObject → StableIdCustomizable → BaseServer → CustomServer → Server → <every typed server>
```

## Architecture Decisions

- **`BaseServer(StableIdCustomizable)` for the shared properties.** It declares
  the required `server` plus `description` / `environment` / `roles`, and
  inherits `id` + `customProperties` from the `common` chain — exactly the
  `$defs/Server` property set except `type` and the `allOf` block. Nothing
  server-related is declared twice downstream.
- **`CustomServer(BaseServer)` is the all-optional superset**, modeled 1:1 on
  the JSON's own `$defs/ServerSource/CustomServer` (19 fields, none required).
  Because it is a superset of every source's fields, it is the first
  guarantee of **two-way parsing**: any valid ODCS server document — whatever
  its `type` — has a lossless KCL representation.
- **`Server(CustomServer)` is the standard interface** assembled into
  `DataContract.servers: [server.Server]` (`odcs.k`). It adds
  `$type: ServerSourceType = "custom"` and recovers the JSON `allOf` — the
  per-`type` `if`/`then` required-field conditionals — as one KCL `check` rule
  per type (e.g. `$type != "bigquery" or (project != Undefined and dataset !=
  Undefined)`; `postgres`/`postgresql` share a single rule; `custom` carries
  none). KCL cannot select a child schema from a sibling `type` value during
  parsing, but it *can* coerce raw YAML into `Server` (all fields are
  inherited, none mixed in) and fire the `check`s on that path — so
  `kcl vet contract.yaml odcs.k -s DataContract` validates servers with the
  same discrimination the JSON `allOf` provides.
- **`ServerSourceType` is a closed union** of the 34 documented `type` values
  (including both `postgres` and `postgresql`, plus `custom`), matching the
  JSON enum value-for-value.
- **Typed subschemas extend `Server` itself** (`schema GlueServer(server.Server)`,
  …), freeze `$type` to their literal, and declare that source's own
  required/optional fields — mirroring the named `$defs/ServerSource`
  subschemas for ergonomic, self-documenting KCL authoring (see
  `examples/full/server/postgres.k`: defaults come for free, only that
  backend's fields are exposed as required). Because they sit *below*
  `Server` in the chain, every typed instance also runs the inherited
  per-type `check`s — the authoring path and the parse path validate through
  the same rules, so the two faces cannot silently drift apart.
- **Defaults follow the JSON schema first, the prose docs second.**
  JSON-sourced: `athena.catalog = "awsdatacatalog"`, `kafka.format = "json"`,
  `sqlserver.port = 1433`. Doc-sourced (the JSON declares no default):
  `hive` 10000, `impala` 21050, `informix` 9088, `zen` 1583. Backends whose
  ports the JSON *requires* (`mysql`, `postgres`, …) keep a required `port`
  with no default.

## Open Questions

- ~~**Two-way parsing**~~ — **resolved by the current structure.** The former
  workaround (a permissive parse target kept manually in sync with a separate
  family of strict authoring schemas rooted elsewhere) is gone: `CustomServer`
  guarantees every server representation coerces, `Server` supplies the
  `allOf` validation, and the typed subschemas now *extend* `Server`, so both
  directions (YAML→KCL validation, KCL→YAML authoring) flow through one chain
  that mirrors the JSON schema's own layering.
- The per-type required fields still appear twice — as `check` rules on
  `Server` and as required attributes on each typed subschema — but the
  duplication is now fail-safe rather than silent: the subschemas inherit the
  `check`s, so a typed schema that disagrees with its rule fails at first
  construction. `spec.k` remains the single validation authority.
- **`zen` has no `check` rule on `Server`** even though the JSON
  `ServerSource/ZenServer` requires `host` + `database` (the `ZenServer`
  subschema does enforce them on the authoring path). A `type: zen` server
  arriving via raw YAML is currently not discriminated — rule to be added.
- Known divergences from JSON `ServerSource` v3.1.0, kept deliberately:
  `kinesis.stream` is required in KCL following the prose docs (the JSON
  requires nothing for kinesis); the `postgresql` alias has no dedicated
  authoring subschema (`PostgresServer` freezes `$type = "postgres"`; use the
  general `Server` for the alias spelling). Revisit when upstream aligns the
  JSON schema and the docs.
