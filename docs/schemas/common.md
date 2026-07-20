# `common` module

Cross-cutting building blocks reused by every other module. The `common`
module is where the library's **code-reuse decisions** are made: the stable
`id`, `customProperties`, `authoritativeDefinitions`, and `tags` are defined
once here and **inherited** by the schemas in `catalog`, `contract`, `iam`,
`quality`, `server`, and the root `odcs.k`.

## Schema Mapping

| KCL schema                                           | ODCS JSON Schema entity                                                                    |
|------------------------------------------------------|--------------------------------------------------------------------------------------------|
| `StableId` (`common/id.k`)                     | `$defs/StableId`                                                                           |
| `CustomProperty` (`common/property.k`)               | `$defs/CustomProperty`                                                                     |
| `AuthoritativeDefinition` (`common/authoritative.k`) | `$defs/AuthoritativeDefinitions` (item object)                                             |
| `Customizable` (`common/custom.k`)                   | `$defs/CustomProperties` (array wrapper)                                                   |
| `AuthoritativeCustomizable` (`common/custom.k`)      | `$defs/CustomProperties`, `$defs/AuthoritativeDefinitions`                                 |
| `StableIdCustomizable` (`common/custom.k`)           | `$defs/StableId`, `$defs/CustomProperties`                                                 |
| `StableIdDiscoverable` (`common/discovery.k`)        | `$defs/StableId`, `$defs/CustomProperties`, `$defs/Tags`, `$defs/AuthoritativeDefinitions` |
| `TagsDiscoverable` (`common/discovery.k`)            | `$defs/CustomProperties`, `$defs/AuthoritativeDefinitions`, `$defs/Tags`                   |

> Several `common` schemas map to *multiple* JSON `$defs` because they are
> **composition bases**: rather than repeat `customProperties` /
> `authoritativeDefinitions` / `tags` on every consumer (as the JSON Schema
> does via repeated `$ref`s), the library folds those shared arrays into a few
> base classes that other schemas extend.

## Architecture Decisions

- **Base classes, not mixins.** The shared blocks are modeled as base classes
  so their attributes are visible to KCL's implicit **dict→schema coercion**
  (used by `kcl vet` and raw nested dicts). KCL does *not* recognize
  `mixin`-injected attributes during coercion, which would break YAML
  validation — so mixins were deliberately refactored away.
- **Two parallel inheritance chains, forked over the stable `id`.** KCL allows
  a single base class per schema, so the shared concerns are arranged as two
  supersets:
    - **id-bearing:** `StableId (id?)` → `StableIdCustomizable (+customProperties?)` →
      `StableIdDiscoverable (+tags?, +authoritativeDefinitions?)`.
    - **no-id:** `Customizable (customProperties?)` → `AuthoritativeCustomizable (+authoritativeDefinitions?)` →
      `TagsDiscoverable (+tags?)`.
- **Deliberate, minimal duplication.** `customProperties` is declared on both
  `Customizable` and `StableIdCustomizable` (and `tags` on both discoverable
  tails) because the two chains cannot share a node without multiple
  inheritance. This is one-attribute duplication and the accepted cost of
  serving both the "has stable id" and "free/no id" families through
  inheritance.
- **Leaf objects vs. array wrappers are separated.** `CustomProperty` /
  `AuthoritativeDefinition` are the item objects; the `customProperties` /
  `authoritativeDefinitions` *arrays* live on the base classes above.
- **Guarded `id` regex.** `StableId.id` is validated against
  `^[A-Za-z0-9_-]+$` only when present (`... if id`), so any element carrying
  an optional `id` can still be constructed without one, while a malformed
  `id` is rejected.

## Open Questions

- The two-chain design trades a small, deliberate attribute duplication
  (`customProperties`, `tags` declared twice) for full inheritance-based reuse.
  A future KCL feature (or a different modeling of `id`) might collapse the two
  chains into one; until then the duplication is intentional.
- The `AuthoritativeDefinition.type` field is left an open `str` (its values
  are only `examples` in the standard, not a closed `enum`). If the standard
  later closes that set, it could become a literal union — at the cost of
  rejecting today's valid custom values.
