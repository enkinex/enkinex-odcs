import .element
import .enum
import .relationship
import .type_options

type LogicalType = "string" | "date" | "timestamp" | "time" | "number" | "integer" | "object" | "array" | "boolean" | "map" | "vector"
type SemanticType = "column" | "measure" | "dimension"

# enumValueFits(value, logicalType): an enum value is compatible with the property's logicalType (D8).
# null always fits, and logical types without a scalar counterpart are not checked.
enumValueFits = lambda value: any, logicalType: str -> bool {
    value == None or logicalType not in ["string", "integer", "number", "boolean"] or typeof(value) in {
        "string": ["str"]
        "integer": ["int"]
        "number": ["int", "float"]
        "boolean": ["bool"]
    }[logicalType]
}

schema SchemaProperty(element.SchemaElement):
    """
    Schema property to be cataloged.
    Properties are attributes of an object: a column in a table, a field in a payload, and so on.

    Attributes
    ----------
    primaryKey: bool, default is False, optional.
        Boolean value specifying whether the field is primary or not.
    primaryKeyPosition: int, default is -1, optional.
        If field is a primary key, the position of the primary key element. Starts from 1; -1 means unset.
        A primary key may omit its position.
        Examples: account_id, name being primary key columns, account_id has primaryKeyPosition 1 and name primaryKeyPosition 2.
    logicalType: LogicalType, default is Undefined, optional.
        The logical property data type.
        One of string, date, timestamp, time, number, integer, object, array, boolean, map or vector.
    semanticType: SemanticType, default is "column", optional.
        The semantic role the property plays in the data model (RFC 0034).
        "column" is a physical column; "measure" an aggregated value whose expression is held in `transformLogic`;
        "dimension" a categorical attribute used for grouping and filtering.
    enum: [enum.EnumValue], default is Undefined, optional.
        Enumeration of allowed values for the property (RFC 0033). Must not be empty, values must be unique,
        and each non-null value must be compatible with logicalType: string → str, integer → int,
        number → int or float, boolean → bool (other logical types are not checked).
    logicalTypeOptions: type_options.TypeOptions, default is Undefined, optional.
        Additional optional metadata to describe the logical type.
        Accepts an inline dict coerced into `TypeOptions` or an instance of the
        per-type option schema matching the `logicalType` (`StringOptions`,
        `DateOptions`, `TimestampOptions`, `TimeOptions`, `IntegerOptions`,
        `NumberOptions`, `ObjectOptions`, `ArrayOptions`, `VectorOptions`).
        Each option is only valid for the logical types registered in `optionLogicalTypes`.
        A vector requires `dimensions`.
    required: bool, default is False, optional.
        Indicates if the element may contain Null values.
    unique: bool, default is False, optional.
        Indicates if the element contains unique values.
    partitioned: bool, default is False, optional.
        Indicates if the element is partitioned.
    partitionKeyPosition: int, default is -1, optional.
        If element is used for partitioning, the position of the partition element. Starts from 1; -1 means unset.
        Examples: country, year being partition columns, country has partitionKeyPosition 1 and year partitionKeyPosition 2.
    classification: str, default is Undefined, optional.
        Can be anything, like confidential, restricted, and public to more advanced categorization.
        Examples: "confidential", "restricted", "public"
    encryptedName: str, default is Undefined, optional.
        The element name within the dataset that contains the encrypted element value.
        Examples: unencrypted element email_address might have an encryptedName of email_address_encrypt.
    transformSourceObjects: [str], default is Undefined, optional.
        List of objects in the data source used in the transformation.
    transformLogic: str, default is Undefined, optional.
        Logic used in the column transformation.
    transformDescription: str, default is Undefined, optional.
        Describes the transform logic in very simple terms.
    examples: [any], default is Undefined, optional.
        List of `any` sample element values.
    criticalDataElement: bool, default is False, optional.
        If element is considered a critical data element (CDE) then true else false.
    relationships: [relationship.RelationshipPropertyLevel], default is Undefined, optional.
        A list of relationships to other properties.
        When defined at property level, the 'from' field is implicit and should not be specified.
    items: SchemaItemProperty, default is Undefined, optional.
        Descriptor for the items of an array property: a full property definition
        (scalar items set their own logicalType; object items nest their own properties).
        Only valid when logicalType is "array"; an array may omit it. Needs no `name`.
    properties: [SchemaProperty], default is Undefined, optional.
        A list of nested properties describing the fields of an object property.
        Only valid when logicalType is "object"; an object may omit it. Every entry requires a `name`.
    map: MapDefinition, default is Undefined, optional.
        Key/value definition of a map property (RFC 0030). Written `$map` in KCL, because `map` is a keyword.
        Required when logicalType is "map", and only valid then.

    Examples
    --------
    arrayOfObjects = SchemaProperty {
        id = "zip_array_property"
        name = "zip_array"
        logicalType = "array"
        items = SchemaItemProperty {
            name = "zip_entry"
            logicalType = "object"
            properties = [
                SchemaProperty {
                    id = "id_property"
                    name = "id"
                    logicalType = "string"
                    physicalType = "VARCHAR(40)"
                },
                SchemaProperty {
                    id = "zip_property"
                    name = "zip"
                    logicalType = "string"
                    physicalType = "VARCHAR(15)"
                }
            ]
        }
    }

    arrayOfScalars = SchemaProperty {
        id = "delivery_notes_property"
        name = "delivery_notes"
        logicalType = "array"
        items = SchemaItemProperty {
            logicalType = "string"
            physicalType = "VARCHAR(200)"
        }
    }
    """
    primaryKey?: bool = False
    primaryKeyPosition?: int = -1
    logicalType?: LogicalType
    semanticType?: SemanticType = "column"
    enum?: [enum.EnumValue]
    logicalTypeOptions?: type_options.TypeOptions
    required?: bool = False
    unique?: bool = False
    partitioned?: bool = False
    partitionKeyPosition?: int = -1
    classification?: str
    encryptedName?: str
    transformSourceObjects?: [str]
    transformLogic?: str
    transformDescription?: str
    examples?: [any]
    criticalDataElement?: bool = False
    relationships?: [relationship.RelationshipPropertyLevel]
    items?: SchemaItemProperty
    properties?: [SchemaProperty]
    $map?: MapDefinition

    check:
        logicalType == "array" or items == Undefined, "'items' is only valid when logicalType is 'array'"
        logicalType == "object" or properties == Undefined, "'properties' is only valid when logicalType is 'object'"
        properties == Undefined or all p in properties {p.name != Undefined}, "every entry of 'properties' requires 'name'"
        properties == Undefined or len(properties) == len({p.name: p for p in properties}), "property names must be unique within the property"
        primaryKeyPosition == -1 or primaryKeyPosition >= 1, "primaryKeyPosition must be >= 1 when set (-1 means unset)"
        partitionKeyPosition == -1 or partitionKeyPosition >= 1, "partitionKeyPosition must be >= 1 when set (-1 means unset)"
        enum == Undefined or len(enum) >= 1, "enum must not be empty"
        enum == Undefined or len(enum) == len({str(e.value): e for e in enum}), "enum values must be unique"
        enum == Undefined or all e in enum {enumValueFits(e.value, logicalType)}, "each enum value must be compatible with the property's logicalType"
        logicalType != "map" or $map != Undefined, "logicalType 'map' requires 'map'"
        logicalType == "map" or $map == Undefined, "'map' is only valid when logicalType is 'map'"
        logicalType != "vector" or (logicalTypeOptions != Undefined and logicalTypeOptions.dimensions != Undefined), "logicalType 'vector' requires logicalTypeOptions.dimensions"
        not type_options.misplacedOptions(logicalTypeOptions, logicalType), "logicalTypeOptions ${type_options.misplacedOptions(logicalTypeOptions, logicalType)} not valid for logicalType '${logicalType}'"

schema MapDefinition:
    """
    Key/value definition of a map property (RFC 0030), the `map` attribute of `SchemaProperty`.
    It sits in this file, beside `SchemaItemProperty`, because a separate file would import `property.k` in a cycle.

    Attributes
    ----------
    key: SchemaItemProperty, default is Undefined, required.
        Definition of the map's key: a full item descriptor, which needs no `name`.
    value: SchemaItemProperty, default is Undefined, required.
        Definition of the map's value: a full item descriptor, nesting allowed (a map of maps, a map of objects).

    Examples
    --------
    receiverAttributes = SchemaProperty {
        name = "receiver_attributes"
        logicalType = "map"
        physicalType = "MAP<STRING, STRING>"
        $map = MapDefinition {
            key = SchemaItemProperty {
                logicalType = "string"
            }
            value = SchemaItemProperty {
                logicalType = "string"
            }
        }
    }
    """
    key: SchemaItemProperty
    value: SchemaItemProperty

type SchemaItemProperty = SchemaProperty
