import regex

stableIdPattern = "^[A-Za-z0-9_-]+$"

schema StableIdObject:
    """
    Base object carrying the optional stable `id` property.

    The `id` is always optional (the JSON references `StableId` from a
    non-required position everywhere it is used). Use this as a base class
    so the `id` attribute is recognized by KCL dict→schema coercion (mixin
    attributes are not).

    Attributes
    ----------
    id: str, default is Undefined, optional.
        Stable technical identifier for references.
        Must be unique within its containing array.
        Cannot contain special characters ('-', '_' allowed).
    """
    id?: str

    check:
        regex.match(id, stableIdPattern) if id, "id must match ${stableIdPattern}"
