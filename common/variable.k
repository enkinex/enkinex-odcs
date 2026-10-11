import regex

# Variables (RFC 0050): any string value may hold `${NAME}` or `${NAME:-default}`,
# resolved by the tool that uses the contract, never by the standard.
#
# Two paths, and only one needs help:
# - YAML documents keep tokens verbatim through `kcl vet` and `kcl run`, which is what
#   RFC 0050 requires ("MUST preserve unresolved tokens verbatim").
# - KCL source interpolates `${...}` inside ordinary strings, so "${DB_HOST}" does not
#   compile. Write `variable("DB_HOST")`, a raw string r"${DB_HOST}", or "\${DB_HOST}".
#
# KCL's own build-time resolver is `option()`. Paired with `variable()`, one source
# exports a portable token, or the value supplied with `kcl run -D`:
#
#     host = option("db_host") or variable("DB_HOST")
#     port = option("db_port", type="int") or variable("DB_PORT", "5432")
#
#     $ kcl run contract.k                      -> host: ${DB_HOST}, port: ${DB_PORT:-5432}
#     $ kcl run contract.k -D db_host=db.acme   -> host: db.acme,    port: ${DB_PORT:-5432}

# One reference: `${NAME}` or `${NAME:-default}`, NAME an identifier, default without `}`.
variableReferencePattern = r"\$\{[A-Za-z_][A-Za-z0-9_]*(?::-[^}]*)?\}"

# isVariable(value): the whole value is exactly one reference, e.g. "${CREATED_AT}".
isVariable = lambda value: str -> bool {
    regex.match(value, "^" + variableReferencePattern + "$")
}

# hasVariable(value): the value contains at least one reference, e.g. "SELECT * FROM ${TABLE}".
hasVariable = lambda value: str -> bool {
    len(regex.findall(value, variableReferencePattern)) > 0
}

# variable(name, default): builds a reference token without KCL's string interpolation:
# variable("DB_HOST") == "${DB_HOST}", variable("DB_PORT", "5432") == "${DB_PORT:-5432}".
variable = lambda name: str, default: str = "" -> str {
    "$" + "{" + name + (":-" + default if default else "") + "}"
}
