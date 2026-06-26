fullyQualifiedReference = "^(?:(?:https?:\/\/)?[A-Za-z0-9._\-\/]+\.yaml#)?\/?[A-Za-z_][A-Za-z0-9_]*\/[A-Za-z0-9_-]+(?:\/[A-Za-z_][A-Za-z0-9_]*\/[A-Za-z0-9_-]+)*$"
stableId = "^[A-Za-z0-9_-]+$"
shorthandReference = "^[A-Za-z_][A-Za-z0-9_]*\\.[A-Za-z_][A-Za-z0-9_]*$"

mixin RequiredFromReferenceMixin:
    """
    Required `from` property reference mixin.

    Attributes
    ----------
    from: str, default is Undefined
        Source property reference using fully qualified or shorthand notation.
    """
    from: str

    check:
        regex.match(from, shorthandReference) or regex.match(from, fullyQualifiedReference)

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
        regex.match(id, stableId)

