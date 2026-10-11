import .custom

schema StableIdDiscoverable(custom.StableIdAuthoritativeCustomizable):
    """
    Base object carrying the optional properties shared by discoverable elements with a stable 'id'.
    Inherited via StableIdAuthoritativeCustomizable: id, customProperties, authoritativeDefinitions.

    Attributes
    ----------
    tags: [str], default is Undefined, optional.
        A list of tags that may be assigned to the elements (object or property).
        The tags keyword may appear at any level.
        Examples: "finance", "sensitive", "employee_record"
    """
    tags?: [str]

schema TagsDiscoverable(custom.AuthoritativeCustomizable):
    """
    Base object carrying the optional properties shared by discoverable elements without a stable 'id'.
    Inherited via AuthoritativeCustomizable: customProperties, authoritativeDefinitions.

    Attributes
    ----------
    tags: [str], default is Undefined, optional.
        A list of tags that may be assigned to the elements (object or property).
        The tags keyword may appear at any level.
        Examples: "finance", "sensitive", "employee_record"
    """
    tags?: [str]
