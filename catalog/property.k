import .element
import .relationship
import .type_options

type LogicalType = "string" | "date" | "timestamp" | "time" | "number" | "integer" | "object" | "array" | "boolean"

schema SchemaProperty(element.SchemaElement):
    """
    Schema property to be cataloged.
    Properties are attributes of an object: a column in a table, a field in a payload, and so on.

    Attributes
    ----------
    primaryKey: bool, default is False, optional.
        Boolean value specifying whether the field is primary or not.
    primaryKeyPosition: int, default is -1, optional.
        If field is a primary key, the position of the primary key element. Starts from 1.
        Examples: account_id, name being primary key columns, account_id has primaryKeyPosition 1 and name primaryKeyPosition 2.
    logicalType: LogicalType, default is Undefined, optional.
        The logical property data type.
        One of string, date, timestamp, time, number, integer, object, array or boolean.
    logicalTypeOptions: type_options.TypeOptions, default is Undefined, optional.
        Additional optional metadata to describe the logical type.
    required: bool, default is False, optional.
        Indicates if the element may contain Null values.
    unique: bool, default is False, optional.
        Indicates if the element contains unique values.
    partitioned: bool, default is False, optional.
        Indicates if the element is partitioned.
    partitionKeyPosition: int, default is -1, optional.
        If element is used for partitioning, the position of the partition element. Starts from 1.
        Examples: country, year being partition columns, country has partitionKeyPosition 1 and year partitionKeyPosition 2.
    classification: str, default is Undefined, optional.
        Can be anything, like confidential, restricted, and public to more advanced categorization.
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
    items: [SchemaPropertyItems], default is Undefined, optional.
        A list of properties for the property.

    Examples
    --------
    arrayProperty = SchemaProperty {
        id = "zip_array_property"
        name = "zip_array"
        logicalType = "array"
        items = SchemaPropertyItems {
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
    """
    primaryKey?: bool = False
    primaryKeyPosition?: int = -1
    logicalType?: LogicalType
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
    items?: SchemaPropertyItems

schema SchemaPropertyItems:
    """
    The collection of items in an array.
    Only applicable when the schema property logicalType is array.

    Attributes
    ----------
    properties: [SchemaProperty], default is Undefined, required.
        A list of properties for the object.
    """
    properties: [SchemaProperty]

