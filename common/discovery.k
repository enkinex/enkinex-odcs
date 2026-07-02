import .authoritative
import .property

schema DiscoverableObject(property.CustomPropertiesObject):
    """
    Base object carrying the optional properties shared by discoverable elements.

    Attributes
    ----------
    tags: [str], default is Undefined, optional.
        A list of tags that may be assigned to the elements (object or property).
        The tags keyword may appear at any level.
        Examples: "finance", "sensitive", "employee_record"
    authoritativeDefinitions: [authoritative.AuthoritativeDefinition], default is Undefined, optional.
        List of links to sources that provide more details on the element.
        Examples: Link to privacy statement, terms and conditions, license agreements, data catalog, or another tool.
    """
    tags?: [str]
    authoritativeDefinitions?: [authoritative.AuthoritativeDefinition]

