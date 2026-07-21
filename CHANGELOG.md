This document tracks the history and evolution of the **Enkinex ODCS Library** for the **Open Data Contract Standard**.

# v3.1.0-rc1 - First v3.1.0 Release Candidate

* Schemas
    * StableIdObject schema renamed to StableId
* Documentation
    * Update `README.md`
    * Update `AUTHORS.md`
    * Update `CONTRIBUTING.md`
    * Update `docs/schemas/*.md`
* Sample Project
    * Move to a new repository at `enkinex-odcs-tutorial`
* Validation
    * Add validation test case for ODCS full example
* CI/CD
    * Update `kcl.mod` version
    * Update `Justfile` commands
    * Add `.github` test workflow and configuration

# v3.1.0-draft - Initial v3.1.0 Draft

* Schemas
    * Catalog Schemas
    * Common Schemas
    * Contract Fundamentals Schemas
    * IAM Schemas
    * Quality Schemas
    * Server Schemas
* Documentation
    * `README.md`
    * Schema Mapping and Architectural Decisions
    * Reference documentation generated from KCL
    * Tutorial
* Sample Project
    * ODCS Data Contract full example implemented as a KCL modular project
* Validation
    * Validate DataContract schema
