import ..common.discovery
import ..quality.rule as rule

schema SchemaElement(discovery.StableIdDiscoverable):
    """
    Schema element to be cataloged.
    Applicable to either Objects or Properties
    Inherited via StableIdDiscoverable: id, tags, authoritativeDefinitions, customProperties.

    Attributes
    ----------
    name: str, default is Undefined, optional.
        Name of the element.
        Required on schema objects and on every entry of a `properties` list (checked by the container);
        optional on item descriptors (`items`, `map.key`, `map.value`), as in the JSON `SchemaItemProperty`.
    physicalName: str, default is Undefined, optional.
        Physical name.
        Examples: "table_1_2_0" for objects. "col_str_a" for properties.
    physicalType: str, default is Undefined, optional.
        The physical element data type in the data source.
        Examples: "table", "view", "topic", "file" for objects. "VARCHAR(2)", "DOUBLE", "INT", for properties.
    description: str, default is Undefined, optional.
        Description of the element.
    businessName: str, default is Undefined, optional.
        The business name of the element.
    quality: [rule.DataQuality], default is Undefined, optional.
        Data quality rules with all the relevant information for rule setup and execution.
    """
    name?: str
    physicalName?: str
    physicalType?: str
    description?: str
    businessName?: str
    quality?: [rule.DataQuality]
