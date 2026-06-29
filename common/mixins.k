import regex

mixin StableIdMixin:
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

mixin TagsMixin:
    """
    Optional `tags` property mixin.

    Attributes
    ----------
    tags: [str], default is Undefined, optional.
        A list of tags that may be assigned to the elements (object or property).
        The tags keyword may appear at any level.
        Examples: "finance", "sensitive", "employee_record"
    """
    tags?: [str]

