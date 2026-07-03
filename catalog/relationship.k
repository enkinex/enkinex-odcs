import regex

import ..common.property

type RelationshipType = "foreignKey"

fullyQualifiedReference = r"^(?:(?:https?:\/\/)?[A-Za-z0-9._\-\/]+\.yaml#)?\/?[A-Za-z_][A-Za-z0-9_]*\/[A-Za-z0-9_-]+(?:\/[A-Za-z_][A-Za-z0-9_]*\/[A-Za-z0-9_-]+)*$"
shorthandReference = r"^[A-Za-z_][A-Za-z0-9_]*\.[A-Za-z_][A-Za-z0-9_]*$"

refOk = lambda r: any -> bool {
    regex.match(r, shorthandReference) or regex.match(r, fullyQualifiedReference)
}

allRefsOk = lambda v: str | [str] -> bool {
    refs = [v] if typeof(v) == "str" else v
    all r in refs { refOk(r) }
}

schema RelationshipBase:
    """
    Base definition for relationships between elements, typically for foreign key constraints.

    Attributes
    ----------
    type: RelationshipType, default is "foreignKey", optional.
        The type of relationship.
    to: str | [str], default is Undefined, required.
        Target element reference using fully qualified or shorthand notation; Or an array of target elements for composite keys.
    """
    $type?: RelationshipType = "foreignKey"
    to: str | [str]
    customProperties?: [property.CustomProperty]

    check:
        allRefsOk(to), \
            "each 'to' reference must use shorthand or fully-qualified notation"

schema RelationshipSchemaLevel(RelationshipBase):
    """
    Relationship definition at schema level, requiring both 'from' and 'to' fields with matching types.
    Single-column relationship - both fields must be strings.
    Composite key relationship - both fields must be arrays with matching lengths.

    Attributes
    ----------
    from: str | [str], default is Undefined, required.
        Source object reference using fully qualified or shorthand notation; Or an array of source objects for composite keys.
    """
    from: str | [str]

    check:
        allRefsOk(from), \
            "each 'from' reference must use shorthand or fully-qualified notation"
        (typeof(from) == "str") == (typeof(to) == "str"), \
            "'from' and 'to' must both be strings or both be arrays"
        typeof(from) == "str" or len(from) == len(to), \
            "composite keys must have matching lengths"

schema RelationshipPropertyLevel(RelationshipBase):
    """
    Relationship definition at property level, where 'from' is implicitly the current property.
    """
