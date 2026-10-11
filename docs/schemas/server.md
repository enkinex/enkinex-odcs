# `server` module

Connection details for the servers where the datasets reside (sources and targets). The module is a single inheritance
chain that mirrors the JSON schema's own layering:

- `BaseServer` carrying the properties common to every server.
- `CustomServer` superset holding every possible source field.
- A general `Server` that adds the `type` discriminator plus the `allOf` validation.
- One thin subschema per source type, for ergonomic authoring.

The inheritance chain (each level adds exactly what its JSON counterpart adds):

```
StableId → StableIdCustomizable → BaseServer → CustomServer → Server → <every typed server>
```

---

## Schema Mapping

| Module Path                                | KCL schema                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ODCS JSON Schema entity                                                                                                                                                                |
|--------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [`server/base.k`](../../server/base.k)     | `BaseServer`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `$defs/Server` **minus** `type` and the `allOf` block — the common properties (`server`, `description`, `environment`, `roles`, plus `id` / `customProperties` via the `common` chain) |
| [`server/custom.k`](../../server/custom.k) | `CustomServer`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | `$defs/ServerSource` → `CustomServer`, extended to stay the permissive superset of every source field, every one optional                                                              |
| [`server/spec.k`](../../server/spec.k)     | `Server` + `ServerSourceType`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `$defs/Server` — `type` (the enum, synonyms included) plus the `allOf` of per-`type` `if`/`then` conditionals, recovered as KCL `check` rules                                          |
| [`server/*.k`](../../server)               | `ApiServer`, `AthenaServer`, `AzureServer`, `BigQueryServer`, `ClickHouseServer`, `GoogleCloudSqlServer`, `DatabricksServer`, `IBMDB2Server`, `DenodoServer`, `DremioServer`, `DuckdbServer`, `ExasolServer`, `GlueServer`, `HanaServer`, `HiveServer`, `IcebergServer`, `ImpalaServer`, `InformixServer`, `IngresServer`, `KafkaServer`, `KinesisServer`, `LocalServer`, `MySqlServer`, `OracleServer`, `PoetServer`, `PostgresServer`, `PrestoServer`, `PubSubServer`, `RedshiftServer`, `S3Server`, `SftpServer`, `SnowflakeServer`, `SqlserverServer`, `SynapseServer`, `TeradataServer`, `TrinoServer`, `VectorwiseServer`, `VersantServer`, `VerticaServer`, `ZenServer` | the named `$defs/ServerSource` subschemas (one KCL schema per source, same names as the JSON)                                                                                          |

---

## Architecture Decisions

### `BaseServer(StableIdCustomizable)` for the shared properties

- It declares the required `server` plus `description` / `environment` / `roles`.
- Inherits `id` + `customProperties` from the `common` chain — exactly the `$defs/Server` property set except `type` and
  the `allOf` block.
- Nothing server-related is declared twice downstream.

### `CustomServer(BaseServer)` is the all-optional superset

- Modeled on the JSON's own `$defs/ServerSource/CustomServer`, none of its fields required.
- Because it is a superset of every source's fields, it is the first guarantee of **two-way parsing**.
- Any valid ODCS server document — whatever its `type` — has a lossless KCL representation.
- **ODCS v3.2.0 broke the superset in the JSON**: its `CustomServer` lacks fields that only one type declares
  (`workgroup` for athena, and `catalogUrl` / `namespace` for iceberg). Mirroring the JSON 1:1 would make valid
  servers of those types fail to parse. The KCL `CustomServer` declares them anyway, and `Server` adds one rule per
  field allowing it only for its type, so a `type: custom` server carrying `workgroup` is still rejected, as the JSON
  rejects it (decision D12). The same holds for `catalogUrl` and `namespace` on iceberg.

### `port` is an integer or a string

- The JSON `Port` is `integer | string`, so a port can hold a variable reference such as `${DB_PORT}` resolved at
  runtime (RFC 0050); it is the one non-string field that accepts a token. `type Port = int | str` lives beside
  `CustomServer` and is re-exported by `spec.k` for the typed servers.
- The JSON accepts any string. The library requires a string port to be decimal digits or one whole variable reference
  (`portOk`), so `port: eighty` is rejected (decision D10).

### `Server(CustomServer)` is the standard interface

- Assembled into `DataContract.servers: [server.Server]` (`odcs.k`).
- It adds `$type: ServerSourceType = "custom"`.
- Recovers the JSON `allOf` — the per-`type` `if`/`then` required-field conditionals — as one KCL `check` rule per type
  (e.g. `$type != "bigquery" or (project != Undefined and dataset != Undefined)`.
- Synonyms share their primary's rule: `postgres`/`postgresql`, `zen`/`btrieve` and `poet`/`fastobjects` (ODCS v3.2.0
  dispatches `btrieve` and `fastobjects` to the `ZenServer` and `PoetServer` definitions). `custom` carries none; every
  other type has its own rule.
- KCL cannot select a child schema from a sibling `type` value during parsing, but it *can* coerce raw YAML into
  `Server` (all fields are inherited, none mixed in) and fire the `check`s on that path.
- `kcl vet contract.yaml odcs.k -s DataContract` validates servers with the same discrimination the JSON `allOf`
  provides.

### `ServerSourceType` is a closed union

- Every documented `type` value, including the synonyms and `custom`, matching the JSON enum value for value. ODCS
  v3.2.0 added `exasol`, `hana`, `iceberg`, `ingres`, `poet`, `teradata`, `vectorwise` and `versant`, and the
  synonyms `btrieve` and `fastobjects`.

### Typed subschemas extend `Server` itself

- (`schema GlueServer(server.Server)`, …), freeze `$type` to their literal, and declare that source's own
  required/optional fields.
- Mirror the named `$defs/ServerSource` subschemas for ergonomic, self-documenting KCL authoring.
- Only that backend's fields are exposed as required. Defaults come for free.
- Every typed instance extends `Server` and also runs the inherited per-type `check`s.
- The authoring path and the parse path validate through the same rules, so the two faces cannot drift apart.

### Defaults follow the JSON schema first, the prose docs second

- JSON-sourced: `athena.catalog = "awsdatacatalog"`, `kafka.format = "json"`, `sqlserver.port = 1433`, and for the
  v3.2.0 sources `exasol.port = 8563`, `teradata.port = 1025`, `ingres.port` and `vectorwise.port = 21064`,
  `versant.host = "localhost"` with `port = 5019`, `poet.host = "LOCAL"` with `port = 6001`.
- Doc-sourced (the JSON declares no default): `hive` 10000, `impala` 21050, `informix` 9088, `zen` 1583, and
  `encoding = "UTF-8"` on the seven typed file and stream sources (`azure`, `glue`, `kafka`, `kinesis`, `local`, `s3`,
  `sftp`; RFC 0043, "Defaults to UTF-8" in the prose). `CustomServer.encoding` has no default, so a YAML server parsed
  without `encoding` exports none.
- Backends whose ports the JSON *requires* (`mysql`,`postgres`, …) keep a required `port` with no default.

---

## Open Questions

### The per-type required fields still appear twice

- As `check` rules on `Server` and as required attributes on each typed subschema.
- The duplication is now fail-safe rather than silent.
- The subschemas inherit the `check`s, so a typed schema that disagrees with its rule fails at first construction.
- `spec.k` remains the single validation authority.

### Rejecting every foreign field per type

- The JSON closes each typed source with `unevaluatedProperties`, so a `postgres` server carrying `location` is
  invalid. The library scopes only the fields the JSON `CustomServer` lacks (above); a foreign field that the JSON
  `CustomServer` does declare still parses on any type. Closing every type is a larger behaviour change than ODCS
  v3.2.0 asks for, and stays open (D12).

### Known divergences from JSON `ServerSource` v3.2.0

- The synonyms `postgresql`, `btrieve` and `fastobjects` have no dedicated authoring subschema (`PostgresServer`,
  `ZenServer` and `PoetServer` freeze their primary `$type`); use the general `Server` for a synonym spelling.
- A string `port` must be decimal digits or a whole variable reference; the JSON accepts any string (D10).
- `CustomServer` declares the single-type fields the JSON `CustomServer` lacks, scoped to their type by `Server` (D12).
