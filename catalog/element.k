import ..common.authoritative as ad
import ..common.id as id
import ..common.property as prop
import ..quality.rule as qr

schema SchemaElement:
    """
    Schema element to be cataloged.
    Applicable to either Objects or Properties

    Attributes
    ----------
    name: str, default is Undefined, required.
        Name of the element.
    physicalName: str, default is Undefined, optional.
        Physical name.
    physicalType: str, default is Undefined, optional.
        The physical element data type in the data source. For objects: table, view, topic, file. For properties: VARCHAR(2), DOUBLE, INT, etc.
    description: str, default is Undefined, optional.
        Description of the element.
    businessName: str, default is Undefined, optional.
        The business name of the element.
    authoritativeDefinitions: [ad.AuthoritativeDefinition], default is Undefined, optional.
        List of links to sources that provide more details on the element; examples would be a link to privacy statement, terms and conditions, license agreements, data catalog, or another tool.
    tags: [str], default is Undefined, optional.
        A list of tags that may be assigned to the elements (object or property); the tags keyword may appear at any level. For example, finance, sensitive, employee_record.
    quality: [qr.DataQualityRule], default is Undefined, optional.
        Data quality rules with all the relevant information for rule setup and execution.
    customProperties: [prop.CustomProperty], default is Undefined, optional.
        A list of key/value pairs for custom properties.
    """
    mixin [
        id.OptionalStableIdMixin
    ]
    name: str
    physicalName?: str
    physicalType?: str
    description?: str
    businessName?: str
    authoritativeDefinitions?: [ad.AuthoritativeDefinition]
    tags?: [str]
    quality?: [qr.DataQuality]
    customProperties?: [prop.CustomProperty]

