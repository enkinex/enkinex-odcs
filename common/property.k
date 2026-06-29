import .mixins

schema CustomProperty:
    """
    This section covers custom properties you can use to add non-standard properties.
    This block is available in many sections.

    Attributes
    ----------
    property: str, default is Undefined, required.
        The name of the key.
    value: any, default is Undefined, required.
        The value of the key. It can be an array.
    description: str, default is Undefined, optional.
        Description for humans.

    Examples
    --------
    rfcRuleset = Property {
        id = "rfc_ruleset_name"
        property = "refRulesetName"
        value = "gcsc.ruleset.name"
    }

    dnsOptions = Property {
        id = "dns_options"
        property = "clusterDnsOptions"
        value = [ "1.1.1.1", "8.8.8.8" ]
        description = "Cluster DNS options"
    }
    """
    mixin [
        mixins.StableIdMixin
    ]
    property: str
    value: any
    description?: str

mixin CustomPropertiesMixin:
    """
    Optional `customProperties` property mixin.

    Attributes
    ----------
    customProperties: [CustomProperty], default is Undefined, optional.
        A list of key/value pairs for custom properties.
    """
    customProperties?: [CustomProperty]

