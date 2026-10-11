# `catalog` module

Defines the objects to be cataloged (tables, views, topics, files), their properties (columns/fields), logical type
options, and the relationships between them.

---

## Schema Mapping

| Module Path                                              | KCL schema                                                                                                                                                                          | ODCS JSON Schema entity                                                                                                                                                      |
|----------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [`catalog/element.k`](../../catalog/element.k)           | `SchemaElement`                                                                                                                                                                     | `$defs/SchemaElement` (shared base of objects & properties; also absorbs the duplicated `physicalName` / `quality` from `$defs/SchemaObject` and `$defs/SchemaBaseProperty`) |
| [`catalog/object.k`](../../catalog/object.k)             | `SchemaObject`                                                                                                                                                                      | `$defs/SchemaObject`                                                                                                                                                         |
| [`catalog/property.k`](../../catalog/property.k)         | `SchemaProperty`                                                                                                                                                                    | `$defs/SchemaProperty`, `$defs/SchemaBaseProperty`                                                                                                                           |
| [`catalog/property.k`](../../catalog/property.k)         | `SchemaItemProperty` *(type alias of `SchemaProperty`)*                                                                                                                             | `$defs/SchemaItemProperty` (the `items` descriptor of an array property — a full property definition)                                                                        |
| [`catalog/property.k`](../../catalog/property.k)         | `SemanticType`                                                                                                                                                                      | `SchemaBaseProperty.semanticType` (enum `column` / `measure` / `dimension`)                                                                                                  |
| [`catalog/property.k`](../../catalog/property.k)         | `MapDefinition`                                                                                                                                                                     | the `map` object of the `logicalType: map` branch (RFC 0030)                                                                                                                 |
| [`catalog/enum.k`](../../catalog/enum.k)                 | `EnumValue`                                                                                                                                                                         | `$defs/EnumValue` (items of `SchemaBaseProperty.enum`)                                                                                                                       |
| [`catalog/synonym.k`](../../catalog/synonym.k)           | `Synonym`                                                                                                                                                                           | `$defs/Synonym` (items of `$defs/Synonyms`)                                                                                                                                  |
| [`catalog/relationship.k`](../../catalog/relationship.k) | `RelationshipBase`                                                                                                                                                                  | `$defs/RelationshipBase`                                                                                                                                                     |
| [`catalog/relationship.k`](../../catalog/relationship.k) | `RelationshipSchemaLevel`                                                                                                                                                           | `$defs/RelationshipSchemaLevel`                                                                                                                                              |
| [`catalog/relationship.k`](../../catalog/relationship.k) | `RelationshipPropertyLevel`                                                                                                                                                         | `$defs/RelationshipPropertyLevel`                                                                                                                                            |
| [`catalog/type_options.k`](../../catalog/type_options.k) | `TypeOptions`                                                                                                                                                                       | `$defs/*LogicalTypeOptions` (the permissive union of every per-type option branch)                                                                                           |
| [`catalog/type_options.k`](../../catalog/type_options.k) | `ArrayOptions`, `DateOptions`, `TimestampOptions`, `TimeOptions`, `IntegerOptions`, `NumberOptions`, `ObjectOptions`, `StringOptions`, `VectorOptions` *(all extend `TypeOptions`)* | `logicalTypeOptions` branches (`array`, `date`, `timestamp`, `time`, `integer`, `number`, `object`, `string`, `vector`)                                                      |

---

## Architecture Decisions

### `SchemaElement` as a shared base

- `SchemaObject` and `SchemaProperty` both extend `SchemaElement`, mirroring the JSON `allOf: [SchemaElement]`.
- `physicalName` and `quality`, which the JSON duplicates on both children, are **hoisted** to the base — a strict DRY
  improvement that leaves the effective contract identical.

### `SchemaProperty` maps to more than one JSON `$def`

- ODCS splits a property across `SchemaBaseProperty` (the shared fields) and `SchemaProperty` (the concrete property).
- The library flattens them into one schema.

### Closed logical types

- `SchemaObject.logicalType` is the constant `"object"`.
- `SchemaProperty.logicalType` is the closed union
  `string | date | timestamp | time | number | integer | object | array | boolean`
  matching the JSON `enum`/`const`.

### Conditional strictness recovered with `check`s

- The JSON encodes `logicalTypeOptions` as per-type conditional branches with `additionalProperties: false`.
- KCL uses one permissive `TypeOptions` schema plus **one** table-driven `check` on `SchemaProperty` that rejects every
  option the chosen `logicalType` does not accept (decision D15). The table, `optionLogicalTypes` in
  `catalog/type_options.k`, maps each option to its logical types; the message names every misplaced option, e.g.
  `logicalTypeOptions [maxItems, dimensions] not valid for logicalType 'string'`. It replaced 17 hand-written rules,
  which `vector` alone would have grown to 24. A unit test keeps the table and the `TypeOptions` attributes in step.
- The message is built inside the check, which KCL evaluates in the right scope only since 0.13 (the 0.13.1 floor).
- `items` is only valid when `logicalType == "array"`, and `properties` only when `logicalType == "object"`. Neither is
  required: the JSON branches declare them without requiring them, and the official `all-data-types` example has an
  array without `items` and an object without `properties`. Until v3.2.0 the library required both, which rejected
  valid documents (decision D6).
- `primaryKeyPosition` and `partitionKeyPosition` default to `-1`, meaning unset. A position, when set, is `>= 1`;
  `primaryKey: true` without a position is valid, as in three official examples. The v3.1.0 rule
  `not primaryKey or primaryKeyPosition >= 1` rejected them (D6).

### `map` and `vector` (ODCS v3.2.0)

- **`map`** (RFC 0030) is a KCL keyword, so the attribute is `$map`, exactly as `type` and `schema` are `$type` and
  `$schema`; YAML keeps the key `map`. `MapDefinition {key, value}` holds two `SchemaItemProperty` descriptors, so a
  key or value carries every property field and nests freely (a map of maps of objects), with no `name` (see below).
  `logicalType: map` requires `map`, and `map` is only valid then, an iff pair like the JSON branch.
- `MapDefinition` is declared in `catalog/property.k`, beside the alias: a separate file would import `property.k` in
  a cycle. The recursion runs through a different schema, so the RefCell panic that forces the alias is not triggered.
- **`vector`** (RFC 0042) adds six options. They join the `TypeOptions` superset without defaults, and
  `VectorOptions(TypeOptions)` requires `dimensions` and carries the spec defaults `elementType = "float32"` and
  `normalized = False` (D4). `dimensions >= 1` is checked on the superset, so YAML input is covered.
- `logicalType: vector` requires `logicalTypeOptions.dimensions` whenever it is set, following the prose
  (`docs/schema.md`: "required whenever `logicalType: vector`"). The JSON requires it only when `logicalTypeOptions` is
  present, so a vector without options passes the JSON and fails here (decision D9).

### Semantics of 3.2.0: enum, semanticType, synonyms, deprecated

- **`enum`** (RFC 0033) is a list of `EnumValue`, each a stable-id discoverable element with a required but nullable
  `value`, written with the library's SLA idiom (an optional attribute plus a check, since `None` cannot appear in a
  KCL type). `SchemaProperty` checks three rules (decision D8):
    - the list is not empty (the JSON `minItems: 1`);
    - values are unique **by value**, where the JSON `uniqueItems` compares whole entries, so two entries with the same
      value and different labels pass the JSON and fail here, as the negative test `enum-duplicate-values` intends;
    - each non-null value is compatible with `logicalType`, as the prose requires: `string` → str, `integer` → int,
      `number` → int or float, `boolean` → bool. Other logical types are not checked.
- **`semanticType`** (RFC 0034) is a closed union defaulting to `"column"`; **`deprecated`** (RFC 0051) is a `bool`
  defaulting to `False`. Both defaults are carried, as every spec default in the library is (D4), so exported YAML
  gains `semanticType: column` on every property and `deprecated: false` on every element. `deprecated` is data only:
  KCL has no warning channel.
- **`synonyms`** (RFC 0041) live on `SchemaElement`, so objects and properties both carry them. `locale` (BCP 47) and
  `status` stay open strings, as in the standard.
- **`context`** (RFC 0038) is accepted on `SchemaObject` and the root, never on a property; see `common.md`.

### `name` is enforced by the container, not the element

- `SchemaElement.name` is optional. `SchemaObject` re-declares it as required, and every list of properties
  (`SchemaObject.properties`, `SchemaProperty.properties`) checks that each entry names itself and that the names are
  unique.
- Item descriptors (`items`, and the `map.key` / `map.value` descriptors of ODCS v3.2.0) need no name. That matches the
  JSON exactly: `SchemaProperty` requires `name`, `SchemaItemProperty` does not.
- The requirement cannot sit on a subschema: `SchemaItemProperty` must stay an alias of `SchemaProperty` (below), so a
  property and an item descriptor are one schema, and only the container knows which role an instance plays (D7).

### `SchemaItemProperty` is a type alias, not a subschema

- The JSON `$defs/SchemaItemProperty` is a full `SchemaBaseProperty`, so array items are complete property descriptors:
  scalar items set their own `logicalType`, object items nest their own `properties`, and arrays of arrays nest their
  own `items`.
- KCL recovers this with `type SchemaItemProperty = SchemaProperty`. It cannot be a subschema
  (`schema SchemaItemProperty(SchemaProperty)`): `kcl vet` panics ("RefCell already borrowed") whenever a schema
  attribute references a subclass of its own schema, and `SchemaProperty.items` is exactly that shape.

### Relationships split by level

- `RelationshipSchemaLevel` requires both `from` and `to`.
- `RelationshipPropertyLevel` omits `from` (it is the current property).
- Both carry an optional stable `id` (RFC 0047): `RelationshipBase` extends `StableIdCustomizable`. The JSON types
  `id` as a plain string and states the denylist in prose only; the library enforces it, a deliberate strictness.
- KCL's **closed schemas** naturally forbid `from` at property level, recovering the JSON `not: {required: [from]}` for
  free.

### Reference-notation validation

- `to`/`from` accept `str | [str]` and each token is validated against the JSON `ShorthandReference` or
  `FullyQualifiedReference` pattern, copied verbatim:
    - shorthand: dot-separated names of any depth, hyphens allowed (`accounts.address.street`, `my-table.col-1`);
    - fully qualified: `section/id[/properties/id…]` whose id segments follow the StableId denylist, optionally prefixed
      with an external `file.yaml#` or `file.yml#`.
- Composite keys must be equal-length arrays of matching kind (both strings or both arrays).
- Every reference check is guarded on its attribute being set, so a missing `from` or `to` reports the missing
  attribute rather than failing inside the check.

### Type-options coercion

- `TypeOptions` is the coercion target for `logicalTypeOptions`, its fields are declared directly (not via mixins)
  and carry no defaults, so an unset option reads back as `Undefined` for the per-type checks.

### Per-type option schemas extend `TypeOptions`

- Mirrors the `server` module design (`Server` and its per-source subschemas): each specialized schema (`ArrayOptions`,
  `DateOptions`, `TimestampOptions`, `TimeOptions`, `IntegerOptions`, `NumberOptions`,
  `ObjectOptions`, `StringOptions`) extends `TypeOptions` and narrows its branch's attributes to the types of the
  matching JSON conditional (e.g. `IntegerOptions.maximum: int`, `DateOptions.maximum: str`,
  `IntegerOptions.format: IntegerFormatEnum`).
- Because they are subtypes, their instances are directly assignable to `SchemaProperty.logicalTypeOptions` —
  hand-authored KCL gets precise, self-documenting types, while YAML keeps coercing inline dicts into the permissive
  `TypeOptions` base.
- Spec-declared defaults are carried where they belong to the branch (`IntegerOptions.format = "i32"`,
  `defaultTimezone = "Etc/UTC"` on `TimestampOptions`/`TimeOptions`).
- `date` and `timestamp`/`time` are split into `DateOptions`, `TimestampOptions`, and `TimeOptions` (replacing the
  former merged `DatetimeOptions`): the JSON `date` branch has no timezone options, while the shared
  `timestamp`/`time` branch carries `timezone`/`defaultTimezone`.
- Using the wrong subschema for a `logicalType` still fails: the per-type `check`s on `SchemaProperty` reject any set
  option that does not belong to the declared type.

---

## Open Questions

### Remaining divergences from JSON `SchemaItemProperty`

- `properties` and `items` require an explicit `logicalType: object` / `logicalType: array` ("only valid when"
  above); the JSON allows them on a property without a declared `logicalType`, because its conditional branches are
  unguarded (upstream #322).
- A deliberate strictness, consistent with the library's required-discriminant posture.

### Relationship id uniqueness

- RFC 0047 says a relationship `id` is unique within its containing array. Like every other StableId uniqueness rule,
  it is stated in prose and not enforced: KCL could check it, but the library enforces no id uniqueness anywhere yet.
