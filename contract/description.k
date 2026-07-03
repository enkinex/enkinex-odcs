import ..common.authoritative
import ..common.property

schema Description:
    """
    Object containing the data contract description.

    Attributes
    ----------
    purpose: str, default is Undefined, optional.
        Intended purpose for the provided data.
    limitations: str, default is Undefined, optional.
        Technical, compliance, and legal limitations for data use.
    usage: str, default is Undefined, optional.
        Recommended usage of the data.
    authoritativeDefinitions: [authoritative.AuthoritativeDefinition], default is Undefined, optional.
        List of links to sources that provide more details on the description.
    customProperties: [property.CustomProperty], default is Undefined, optional.
        A list of key/value pairs for custom properties.

    Examples
    --------
    description = Description {
        purpose = "Views built on top of the seller tables."
        limitations = "Cannot be used in conjunction with days with full moons."
        usage = "Twice a day, preferable before meals."
        customProperties = [
            CustomProperty {
                property = "publish"
                value = True
            }
        ]
    }
    """
    purpose?: str
    limitations?: str
    usage?: str
    authoritativeDefinitions?: [authoritative.AuthoritativeDefinition]
    customProperties?: [property.CustomProperty]

