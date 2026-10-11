import regex

# RFC-0026a denylist, verbatim from the ODCS JSON schema `StableId` pattern.
stableIdPattern = r"^[^\s.#/\\@!%&^]+$"

schema StableId:
    """
    Base object carrying the optional stable `id` property.

    Attributes
    ----------
    id: str, default is Undefined, optional.
        Stable technical identifier for references.
        Must be unique within its containing array.
        Per RFC-0026a it cannot contain '.', '#', '/', a backslash, '@', '!', '%', '&', '^' or whitespace;
        anything else is allowed, so namespaced ids such as "fdir:ISU:TAD" or "urn:uuid:..." are valid.
    """
    id?: str

    check:
        regex.match(id, stableIdPattern) if id, "id must match ${stableIdPattern}"
