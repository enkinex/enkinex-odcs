import regex

import ..common.property

fullyQualifiedReference = "^(?:(?:https?:\/\/)?[A-Za-z0-9._\-\/]+\.yaml#)?\/?[A-Za-z_][A-Za-z0-9_]*\/[A-Za-z0-9_-]+(?:\/[A-Za-z_][A-Za-z0-9_]*\/[A-Za-z0-9_-]+)*$"
shorthandReference = "^[A-Za-z_][A-Za-z0-9_]*\\.[A-Za-z_][A-Za-z0-9_]*$"

schema RelationshipBase:
    """
    Base definition for relationships between elements, typically for foreign key constraints."

    Attributes
    ----------
    type: str, default is "foreignKey", optional.
        The type of relationship.
    to: str | [str], default is Undefined, required.
        Target element reference using fully qualified or shorthand notation; Or an array of target elements for composite keys.
    """
    mixin [
        property.CustomPropertiesMixin
    ]
    $type?: str = "foreignKey"
    to: str | [str]

    check:
        all x in to {regex.match(x, shorthandReference) or regex.match(x, fullyQualifiedReference)}

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
        all x in from {regex.match(x, shorthandReference) or regex.match(x, fullyQualifiedReference)}

schema RelationshipPropertyLevel(RelationshipBase):
    """
    Relationship definition at property level, where 'from' is implicitly the current property.
    """

