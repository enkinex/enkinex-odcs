# `catalog` module

The dataset shape: the objects to be cataloged (tables, views, topics, files),
their properties (columns/fields), per-logical-type options, and the
relationships (foreign keys) between them.

## Schema Mapping

| KCL schema                                                                                                                        | ODCS JSON Schema entity                                                                                                                                                      |
|-----------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `SchemaElement` (`catalog/element.k`)                                                                                             | `$defs/SchemaElement` (shared base of objects & properties; also absorbs the duplicated `physicalName` / `quality` from `$defs/SchemaObject` and `$defs/SchemaBaseProperty`) |
| `SchemaObject` (`catalog/object.k`)                                                                                               | `$defs/SchemaObject`                                                                                                                                                         |
| `SchemaProperty` (`catalog/property.k`)                                                                                           | `$defs/SchemaProperty`, `$defs/SchemaBaseProperty`                                                                                                                           |
| `SchemaPropertyItems` (`catalog/property.k`)                                                                                      | `$defs/SchemaItemProperty` (the `items` descriptor of an array property)                                                                                                     |
| `RelationshipBase` (`catalog/relationship.k`)                                                                                     | `$defs/RelationshipBase`                                                                                                                                                     |
| `RelationshipSchemaLevel` (`catalog/relationship.k`)                                                                              | `$defs/RelationshipSchemaLevel`                                                                                                                                              |
| `RelationshipPropertyLevel` (`catalog/relationship.k`)                                                                            | `$defs/RelationshipPropertyLevel`                                                                                                                                            |
| `TypeOptions` (`catalog/type_options.k`)                                                                                          | `$defs/*LogicalTypeOptions` (the permissive union of every per-type option branch)                                                                                           |
| `ArrayOptions`, `DatetimeOptions`, `IntegerOptions`, `NumberOptions`, `ObjectOptions`, `StringOptions` (`catalog/type_options.k`) | the per-logical-type `logicalTypeOptions` branches (`array`, `date`/`timestamp`/`time`, `integer`, `number`, `object`, `string`)                                             |

> `SchemaProperty` maps to more than one JSON `$def` because ODCS splits a
> property across `SchemaBaseProperty` (the shared fields) and `SchemaProperty`
> (the concrete property); the library flattens them into one schema.

## Architecture Decisions

- **`SchemaElement` as a shared base.** `SchemaObject` and `SchemaProperty`
  both extend `SchemaElement`, mirroring the JSON `allOf: [SchemaElement]`.
  `physicalName` and `quality`, which the JSON duplicates on both children, are
  **hoisted** to the base — a strict DRY improvement that leaves the effective
  contract identical.
- **Closed logical types.** `SchemaObject.logicalType` is the constant
  `"object"`; `SchemaProperty.logicalType` is the closed union
  `string | date | timestamp | time | number | integer | object | array | boolean`
  — matching the JSON `enum`/`const`.
- **Conditional strictness recovered with `check`s.** The JSON encodes
  `logicalTypeOptions` as per-type conditional branches with
  `additionalProperties: false`. KCL uses one permissive `TypeOptions` schema
  plus cross-field `check`s on `SchemaProperty` that reject options that do not
  belong to the chosen `logicalType` (e.g. `maxItems` only for `array`,
  `pattern` only for `string`). `items` is required iff `logicalType == "array"`.
- **Relationships split by level.** `RelationshipSchemaLevel` requires both
  `from` and `to`; `RelationshipPropertyLevel` omits `from` (it is the current
  property). KCL's **closed schemas** naturally forbid `from` at property level,
  recovering the JSON `not: {required: [from]}` for free.
- **Reference-notation validation.** `to`/`from` accept `str | [str]` and each
  token is validated against a shorthand (`a.b`) or fully-qualified pattern;
  composite keys must be equal-length arrays of matching kind (both strings or
  both arrays).
- **Type-options coercion.** Because `TypeOptions` is the coercion target for
  `logicalTypeOptions`, its fields are declared directly (not via mixins) and
  carry no defaults, so an unset option reads back as `Undefined` for the
  per-type checks.

## Open Questions

- The **generic `TypeOptions` union vs. the specialized per-type option
  schemas** is the same two-way-parsing trade-off seen in the `server` module:
  the permissive union is what YAML coerces into and what the `SchemaProperty`
  `check`s validate, while `StringOptions` / `IntegerOptions` / … give
  precise, self-documenting types for hand-authored KCL. Both validate
  correctly, but maintaining the union *and* the per-type schemas is a
  workaround rather than a single source of truth.
- Per-type option validity is enforced by an explicit list of `check`s on
  `SchemaProperty` rather than by the type system; if ODCS adds new options or
  types, those checks must be extended by hand.
