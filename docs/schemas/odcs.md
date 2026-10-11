# `odcs.k` — the root `DataContract`

The root schema and single entry point of the library. `odcs.k` imports from every module and composes them into the
final ODCS contract definition. It is the schema you instantiate to author a contract, and the one you point
`kcl vet` at to validate an existing ODCS YAML file.

---

## Schema Mapping

| Module Path              | KCL schema / type | ODCS JSON Schema entity                                                       |
|--------------------------|-------------------|-------------------------------------------------------------------------------|
| [`odcs.k`](../../odcs.k) | `DataContract`    | the JSON Schema **root object**                                               |
| [`odcs.k`](../../odcs.k) | `ApiVersionType`  | root `apiVersion` (enum, pinned to `"v3.2.0"`)                                |
| [`odcs.k`](../../odcs.k) | `KindType`        | root `kind` (`const` `"DataContract"`)                                        |
| [`odcs.k`](../../odcs.k) | `StatusType`      | the `status` examples, offered for narrowing; root `status` itself is a `str` |

The root **composes the module schemas** through its typed fields:

| `DataContract` field                                   | Type                                        | Module   |
|--------------------------------------------------------|---------------------------------------------|----------|
| `servers`                                              | `[server.Server]`                           | server   |
| `schema` (`$schema`)                                   | `[object.SchemaObject]`                     | catalog  |
| `description`                                          | `description.Description`                   | contract |
| `support`                                              | `[support.Support]`                         | contract |
| `price`                                                | `pricing.Pricing`                           | contract |
| `slaProperties`                                        | `[sla.ServiceLevelAgreement]`               | contract |
| `team`                                                 | `team.Team`                                 | iam      |
| `roles`                                                | `[role.Role]`                               | iam      |
| `context`                                              | `str \| semantic_context.Context`           | common   |
| `tags`, `authoritativeDefinitions`, `customProperties` | inherited from `discovery.TagsDiscoverable` | common   |

---

## Architecture Decisions

### One release, one ODCS version

- `apiVersion` defaults to `"v3.2.0"` and accepts nothing else (type `ApiVersionType`); `kind` is `"DataContract"`
  (type `KindType`).
- The library carries **no backward compatibility** across ODCS versions. The JSON schema still lists every published
  version in its `apiVersion` enum; the library does not. A contract written for ODCS v3.1.0 uses the library release
  tagged `v3.1.0`, and moves to this one by changing its `apiVersion` line.
- The release tag is the version selector: `kcl mod add --git https://github.com/enkinex/enkinex-odcs --tag v3.2.0`.

### Root `id` is a free string

- The ODCS root `id` has no pattern (it may be a UUID/URN), so `DataContract` must **not** inherit the stable-`id`
  regex.
- It therefore extends the **no-id** `TagsDiscoverable` tail (inheriting `tags`, `authoritativeDefinitions`,
  `customProperties`) and declares its own `id: str`. This is the *only* shared field inlined anywhere in the library.

### Open `status`, closed by narrowing

- ODCS v3.2.0 dropped `status` from the required fields, and the standard never closed its values: official examples
  use `development`, `production` and `in development`. So `status` is an optional `str`.
- **This reverses the v3.1.0 decision** ("Closed `status`"), which rejected those valid documents.
- `StatusType` keeps the five values the standard lists as examples. An organization that wants a closed set narrows
  it, which moves the opinion from the library (which mirrors the standard) to the consumer (which governs it):

```
schema OrgContract(DataContract):
    status?: StatusType
```

### Root invariants as `check`s

- `version` and `id` must be non-empty.
- `contractCreatedTs`, when present, must match an ISO-8601 timestamp (`timestampPattern`).

### Deprecated fields dropped

- `dataProduct` and `slaDefaultElement` are intentionally omitted (documented in the schema docstring).
- Consistent with the "no deprecated retro-compatibility" scope.

### Composition over redefinition

- Every nested structure is a typed reference to a module schema, so the root stays a thin assembly of the six modules.

### Conformance is measured, not asserted

The library is validated against the standard's own corpus: every official
example and negative test from the upstream release tag, vendored under
[`test/conformance/`](../../test/conformance). An example the library
rejects is listed in the ledger with the decision or task that explains it.
A negative test passes only when its rejection contains the message of the
rule it targets. See [`CONTRIBUTING.md`](../../CONTRIBUTING.md#conformance-with-the-standards-own-corpus).

---

## Open Questions

- None for the root. The `kcl vet` quirk that kept module-level bindings of the vetted file `Undefined` inside `check:`
  is fixed since KCL 0.12.8, so `timestampPattern` is a named constant like every other pattern in the library. The
  root still holds `odcs.k` alone: `kcl vet` also loads sibling `.k` files of the vetted one.
