import ..common.discovery

schema EnumValue(discovery.StableIdDiscoverable):
    """
    An allowed value within a property's enumeration (RFC 0033).
    Inherited via StableIdDiscoverable: id, customProperties, authoritativeDefinitions, tags.

    Attributes
    ----------
    value: str | int | float | bool | None, default is Undefined, required.
        The allowed value: a non-collection scalar, or null (matches JSON AnyNonCollectionType).
        Required but nullable: write `value: null` in YAML (`None` in KCL) for a null member.
        Must be compatible with the property's logicalType (checked on `SchemaProperty`).
    label: str, default is Undefined, optional.
        Human-readable label for the value, suitable for UI display.
    description: str, default is Undefined, optional.
        What this enum value represents.

    Examples
    --------
    pending = EnumValue {
        value = "pending"
        label = "Pending"
        description = "Order received, awaiting processing."
        tags = ["initial"]
    }

    mexico = EnumValue {
        value = "MX"
        label = "Mexico"
        customProperties = [
            CustomProperty {
                property = "languageEs"
                value = "México"
            }
        ]
    }

    unknown = EnumValue {
        value = None
        label = "Unknown"
    }
    """
    value?: str | int | float | bool
    label?: str
    description?: str

    check:
        not (value == Undefined and value != None), "enum value is required (use null for a null value)"
