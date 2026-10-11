import .id

schema CustomProperty(id.StableId):
    """
    This section covers custom properties you can use to add non-standard properties.
    This block is available in many sections.

    Attributes
    ----------
    property: str, default is Undefined, required.
        The name of the key.
    value: any, default is Undefined, required.
        The value of the key: any JSON value (JSON AnyType), an array, an object, or null.
        Required but nullable: write `value: null` in YAML (`None` in KCL) for a null value.
    description: str, default is Undefined, optional.
        Description for humans.
    vendor: str, default is Undefined, optional.
        The vendor, provider, or external system associated with this custom property (RFC 0035).
        SHOULD be a stable lowercase identifier matching ^[a-z0-9][a-z0-9-]*$; not enforced,
        because tools MUST preserve unknown vendor values.
        Examples: "confluent", "zeenea", "atlan", "soda".

    Examples
    --------
    rfcRuleset = CustomProperty {
        id = "rfc_ruleset_name"
        property = "refRulesetName"
        value = "gcsc.ruleset.name"
    }

    dnsOptions = CustomProperty {
        id = "dns_options"
        property = "clusterDnsOptions"
        value = [ "1.1.1.1", "8.8.8.8" ]
        description = "Cluster DNS options"
    }

    schemaRegistrySubject = CustomProperty {
        property = "schemaRegistrySubject"
        value = "orders-value"
        vendor = "confluent"
    }
    """
    property: str
    value?: any
    description?: str
    vendor?: str

    check:
        not (value == Undefined and value != None), "custom property value is required (use null for a null value)"
