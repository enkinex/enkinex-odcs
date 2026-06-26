import .minixs as mix

schema CustomProperty:
    """
    This section covers custom properties you can use to add non-standard properties.
    This block is available in many sections.

    Attributes
    ----------
    property: str, default is Undefined, optional.
        The name of the key.
    value: any, default is Undefined, optional.
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
        mix.OptionalStableIdMixin
    ]
    property?: str
    value?: any
    escription?: str

