# Conformance suite

Measures Enkinex ODCS against the official ODCS corpus, rather than only
against fixtures written for it.

| Path | What it is |
|---|---|
| `odcs-v3.2.0/examples/` | the 42 positive examples from `docs/examples/` at upstream tag `v3.2.0` |
| `odcs-v3.2.0/negative/` | the 44 negative tests from `src/script/negative-tests/` at the same tag |
| `ledger.yaml` | examples the library rejects as published, each with its reason |
| `negative.yaml` | each negative test and the message fragment its rejection must contain |
| `sync.sh` | re-vendors the corpus from a tagged checkout; `--check` proves it is unmodified |
| `run.sh` | the gate behind `just conformance`; `--report` lists every outcome |

The vendored files are copied byte for byte from
[bitol-io/open-data-contract-standard](https://github.com/bitol-io/open-data-contract-standard)
and keep their `Copyright 2026 The Bitol Contributors` /
`SPDX-License-Identifier: Apache-2.0` headers. They are never edited here:
the runner applies a ledger entry's `normalize` steps to a temporary copy.

To move to a new upstream release, vendor its tag beside the old one, point
`run.sh` at it, and rebuild the two maps from `run.sh --report`.

```bash
test/conformance/sync.sh ../open-data-contract-standard v3.2.0 --check
just conformance
```
