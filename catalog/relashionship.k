import ..common.property as prop

schema RelationshipBase:
    """
    Base definition for relationships between elements, typically for foreign key constraints."

    Attributes
    ----------
    type: str, default is "foreignKey", optional.
        The type of relationship.
    to: str | [str], default is Undefined, required.
        Target element reference using fully qualified or shorthand notation; Or an array of target elements for composite keys.
    customProperties: [prop.CustomProperty], default is Undefined, optional.
        Custom properties that are not part of the standard.
    """
    $type?: str = "foreignKey"
    to: str | [str]
    customProperties?: [prop.CustomProperty]

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

schema RelationshipPropertyLevel(RelationshipBase):
    """
    Relationship definition at property level, where 'from' is implicitly the current property.
    """

