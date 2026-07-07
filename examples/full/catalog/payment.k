import enkinex_odcs.catalog.relationship
import enkinex_odcs.catalog.object as schema_object
import enkinex_odcs.catalog.property as schema_property
import enkinex_odcs.common.authoritative
import enkinex_odcs.common.property
import enkinex_odcs.quality.rule

AuthoritativeDefinitions = [
    authoritative.AuthoritativeDefinition {
        url = "https://catalog.data.gov/dataset/air-quality"
        $type = "businessDefinition"
    }
    authoritative.AuthoritativeDefinition {
        url = "https://youtu.be/jbY1BKFj9ec"
        $type = "videoTutorial"
    }
]

ForeignKeyRelationship = relationship.RelationshipSchemaLevel {
    $type = "foreignKey"
    from = [
        "tbl.rcvr_id"
        "tbl.rcvr_cntry_code"
    ]
    to = [
        "receivers.id"
        "receivers.country_code"
    ]
    customProperties = [
        property.CustomProperty {
            property = "description"
            value = "Composite key linking to receivers table"
        }
        property.CustomProperty {
            property = "cardinality"
            value = "many-to-one"
        }
    ]
}

TransactionReferenceDate = schema_property.SchemaProperty {
    id = "txn_ref_dt_prop"
    name = "transaction_reference_date"
    physicalName = "txn_ref_dt"
    primaryKey = False
    primaryKeyPosition = -1
    businessName = "transaction reference date"
    logicalType = "date"
    physicalType = "date"
    required = False
    description = "Reference date for transaction"
    partitioned = True
    partitionKeyPosition = 1
    criticalDataElement = False
    tags = []
    classification = "public"
    transformSourceObjects = [
        "table_name_1"
        "table_name_2"
        "table_name_3"
    ]
    transformLogic = "sel t1.txn_dt as txn_ref_dt from table_name_1 as t1, table_name_2 as t2, table_name_3 as t3 where t1.txn_dt=date-3"
    transformDescription = "defines the logic in business terms; logic for dummies"
    examples = [
        "2022-10-03"
        "2020-01-28"
    ]
    customProperties = [
        property.CustomProperty {
            property = "anonymizationStrategy"
            value = "none"
        }
    ]
}

ReceiverId = schema_property.SchemaProperty {
    id = "rcvr_id_prop"
    name = "rcvr_id"
    primaryKey = True
    primaryKeyPosition = 1
    businessName = "receiver id"
    logicalType = "string"
    physicalType = "varchar(18)"
    required = False
    description = "A description for column rcvr_id."
    partitioned = False
    partitionKeyPosition = -1
    criticalDataElement = False
    tags: ["uid"]
    classification = "restricted"
    relationships = [
        relationship.RelationshipPropertyLevel {
            to = "receivers.id"
            $type = "foreignKey"
            customProperties = [
                property.CustomProperty {
                    property = "description"
                    value = "Links to receiver master data"
                }
            ]
        }
    ]
}

ReceiverCountryCode = schema_property.SchemaProperty {
    id = "rcvr_cntry_code_prop"
    name = "rcvr_cntry_code"
    primaryKey = False
    primaryKeyPosition = -1
    businessName = "receiver country code"
    logicalType = "string"
    physicalType = "varchar(2)"
    required = False
    description = "Country code"
    partitioned = False
    partitionKeyPosition = -1
    criticalDataElement = False
    tags: []
    classification = "public"
    authoritativeDefinitions = [
        authoritative.AuthoritativeDefinition {
            url = "https://collibra.com/asset/742b358f-71a5-4ab1-bda4-dcdba9418c25"
            $type = "businessDefinition"
        }
        authoritative.AuthoritativeDefinition {
            url = "https://github.com/myorg/myrepo"
            $type = "transformationImplementation"
        }
        authoritative.AuthoritativeDefinition {
            url = "jdbc:postgresql://localhost:5432/adventureworks/tbl_1/rcvr_cntry_code"
            $type = "implementation"
        }
    ]
    encryptedName = "rcvr_cntry_code_encrypted"
    quality = [
        rule.DataQuality {
            metric = "nullValues"
            mustBe = 0
            description = "column should not contain null values"
            dimension = "completeness"
            $type = "library"
            severity = "error"
            businessImpact = "operational"
            schedule = "0 20 * * *"
            scheduler = "cron"
            customProperties = [
                property.CustomProperty {
                    property = "FIELD_NAME"
                    value = "rcvr_cntry_code"
                }
                property.CustomProperty {
                    property = "COMPARE_TO"
                    value = "Some"
                }
                property.CustomProperty {
                    property = "COMPARISON_TYPE"
                    value = "Greater than"
                }
            ]
        }
    ]
}

RowCountQualityCheck = rule.DataQuality {
    metric = "rowCount"
    mustBeGreaterThan = 1000000
    $type = "library"
    description = "Ensure row count is within expected volume range"
    dimension = "completeness"
    method = "reconciliation"
    severity = "error"
    businessImpact = "operational"
    schedule = "0 20 * * *"
    scheduler = "cron"
}

PaymentMetricsTable = schema_object.SchemaObject {
    id = "tbl_obj"
    name = "tbl"
    physicalName = "tbl_1"
    physicalType = "table"
    businessName = "Core Payment Metrics"
    description = "Provides core payment metrics"
    authoritativeDefinitions = AuthoritativeDefinitions
    tags = ["finance", "payments"]
    dataGranularityDescription = "Aggregation on columns txn_ref_dt, pmt_txn_id"
    relationships = [
        ForeignKeyRelationship
    ]
    properties = [
        TransactionReferenceDate
        ReceiverId
        ReceiverCountryCode
    ]
    quality = [
        RowCountQualityCheck
    ]
    customProperties = [
        property.CustomProperty {
            property = "business-key"
            value = ["txn_ref_dt", "rcvr_id"]
        }
    ]
}
