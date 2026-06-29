import .element
import .property as schema_property
import .relationship

schema SchemaObject(element.SchemaElement):
    """
    Schema object to be cataloged.
    Objects are a structure of data: a table in a RDBMS system, a document in a NoSQL database, and so on.

    Attributes
    ----------
    dataGranularityDescription: str, default is Undefined, optional.
        Granular level of the data in the object.
        Examples: "Aggregation by country"
    logicalType: str, default is "object", optional.
        The logical object data type.
    properties: [schema_property.SchemaProperty], default is Undefined, optional.
        A list of properties for the object.
    relationships: [relationship.RelationshipSchemaLevel], default is Undefined, optional.
        A list of relationships to other objects.
        Each relationship must have 'from', 'to' and optionally 'type' field.


    Examples
    --------
    simpleTable = SchemaObject {
        name = "SimpleTable"
        phisicalType = "table"
        properties = [
            SchemaProperty {
                name = "id"
                logicalType = "string"
                physicalType = "VARCHAR(40)"
            }
        ]
    }
    """
    logicalType?: str = "object"
    dataGranularityDescription?: str
    properties?: [schema_property.SchemaProperty]
    relationships?: [relationship.RelationshipSchemaLevel]

