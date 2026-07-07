import enkinex_odcs.catalog.object as schema_object
import enkinex_odcs.catalog.property as schema_property
import enkinex_odcs.catalog.relationship
import enkinex_odcs.common.property

ReceiverId = schema_property.SchemaProperty {
    id = "receiver_id_prop"
    name = "id"
    primaryKey = True
    primaryKeyPosition = 1
    businessName = "receiver identifier"
    logicalType = "string"
    physicalType = "varchar(18)"
    required = True
    description = "Unique identifier for receiver"
    unique = True
    classification = "restricted"
}

ReceiverCountry = schema_property.SchemaProperty {
    id = "country_code_prop"
    name = "country_code"
    primaryKey = True
    primaryKeyPosition = 2
    businessName = "receiver country"
    logicalType = "string"
    physicalType = "varchar(2)"
    required = True
    description = "Country code of the receiver"
    classification = "public"
}

ReceiverName = schema_property.SchemaProperty {
    id = "receiver_name_prop"
    name = "receiver_name"
    businessName = "receiver name"
    logicalType = "string"
    physicalType = "varchar(255)"
    required = True
    description = "Name of the receiver"
    classification = "restricted"
}

ReceiverType = schema_property.SchemaProperty {
    id = "receiver_type_prop"
    name = "receiver_type"
    businessName = "receiver type"
    logicalType = "string"
    physicalType = "varchar(20)"
    required = False
    description = "Type of receiver (individual, business, etc.)"
    classification = "public"
    relationships = [
        relationship.RelationshipPropertyLevel {
            to = "receiver_types.type_code"
            customProperties = [
                property.CustomProperty {
                    property = "description"
                    value = "Links to receiver type definitions"
                }
            ]
        }
    ]
}

ReceiversMasterDataTable = schema_object.SchemaObject {
    id = "receivers_obj"
    name = "receivers"
    physicalName = "receivers_master"
    physicalType = "table"
    businessName = "Receivers Master Data"
    description = "Master data for all receivers"
    tags: ["master-data", "receivers"]
    properties = [
        ReceiverId
        ReceiverCountry
        ReceiverName
        ReceiverType
    ]
}
