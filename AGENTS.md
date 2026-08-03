# enkinex-odcs

KCL library implementing the **Open Data Contract Standard (ODCS)
v3.1.0** as Governance-as-Code. Published; tracks the standard's JSON
schema (`odcs-json-schema-v3.1.0.json`).

## Repo map

| Path | Purpose |
|---|---|
| `odcs.k` | Root `DataContract` schema composing all modules |
| `common/` `catalog/` `contract/` `iam/` `quality/` `server/` | One KCL module per ODCS section |
| `test/*.yaml` | `kcl vet` fixtures validated against the schemas |
| `docs/library/odcs.md` | Generated schema reference (`just docs`) — regenerate on docstring change |
| `docs/schemas/` | Per-module design rationale |

## Commands

`just init` (kcl mod update) · `just fmt` · `just lint` · `just test` ·
`just docs` · **`just check` — the gate every change must pass** (fmt +
clean-tree + lint + test). Run `just fmt` and commit before `just check`.

## Standards

- Docstrings on every schema and field (they feed `just docs`): attribute
  line format, `required`/`optional` fidelity with the standard, inline
  `Examples:`.
- `check` rules for enums/constraints; mixins for repeated shapes
  (`common/`).
- Contributing rules: [CONTRIBUTING.md](CONTRIBUTING.md) — branch
  `<type>/<short-slug>`, Conventional Commits subset, squash-merge.

Shared enkinex workflow/git rules: [.opencode/shared/AGENTS.md](.opencode/shared/AGENTS.md)
(synced from enkinex-aiops per ADR-0005 — do not edit here).
