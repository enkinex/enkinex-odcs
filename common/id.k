import regex

mixin OptionalStableIdMixin:
    """
    Optional `id` property reference mixin.

    Attributes
    ----------
    id: str, default is Undefined
        Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters ('-', '_' allowed).
    """
    id?: str

    check:
        regex.match(id, "^[A-Za-z0-9_-]+$")

