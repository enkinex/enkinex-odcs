# enkinex-odcs

## Index

- [DataContract](#datacontract)
- catalog
  - [ArrayOptions](#arrayoptions)
  - [DatetimeOptions](#datetimeoptions)
  - [NumberOptions](#numberoptions)
  - [ObjectOptions](#objectoptions)
  - [RelationshipBase](#relationshipbase)
  - [RelationshipPropertyLevel](#relationshippropertylevel)
  - [RelationshipSchemaLevel](#relationshipschemalevel)
  - [SchemaElement](#schemaelement)
  - [SchemaObject](#schemaobject)
  - [SchemaProperty](#schemaproperty)
  - [SchemaPropertyItems](#schemapropertyitems)
  - [StringOptions](#stringoptions)
  - [TimestampOptions](#timestampoptions)
  - [TypeOptions](#typeoptions)
- common
  - [AuthoritativeDefinition](#authoritativedefinition)
  - [CustomProperty](#customproperty)
  - [OptionalStableIdMixin](#optionalstableidmixin)
- contract
  - [Description](#description)
  - [Pricing](#pricing)
  - [ServiceLevelAgreement](#servicelevelagreement)
  - [Support](#support)
- iam
  - [Role](#role)
  - [Team](#team)
  - [TeamMember](#teammember)
- quality
  - [DataQuality](#dataquality)
  - [MustBeBetweenMixin](#mustbebetweenmixin)
  - [MustBeGreaterOrEqualToMixin](#mustbegreaterorequaltomixin)
  - [MustBeGreaterThanMixin](#mustbegreaterthanmixin)
  - [MustBeLessOrEqualToMixin](#mustbelessorequaltomixin)
  - [MustBeLessThanMixin](#mustbelessthanmixin)
  - [MustBeMixin](#mustbemixin)
  - [MustBeNotBetweenMixin](#mustbenotbetweenmixin)
  - [MustNotBeMixin](#mustnotbemixin)
- server
  - [ApiServer](#apiserver)
  - [AthenaServer](#athenaserver)
  - [AzureServer](#azureserver)
  - [BigQueryServer](#bigqueryserver)
  - [ClickHouseServer](#clickhouseserver)
  - [CustomServer](#customserver)
  - [DatabricksServer](#databricksserver)
  - [DenodoServer](#denodoserver)
  - [DremioServer](#dremioserver)
  - [DuckdbServer](#duckdbserver)
  - [GlueServer](#glueserver)
  - [GoogleCloudSqlServer](#googlecloudsqlserver)
  - [HiveServer](#hiveserver)
  - [IBMDB2Server](#ibmdb2server)
  - [ImpalaServer](#impalaserver)
  - [InformixServer](#informixserver)
  - [KafkaServer](#kafkaserver)
  - [KinesisServer](#kinesisserver)
  - [LocalServer](#localserver)
  - [MySqlServer](#mysqlserver)
  - [OracleServer](#oracleserver)
  - [PostgresServer](#postgresserver)
  - [PrestoServer](#prestoserver)
  - [PubSubServer](#pubsubserver)
  - [RedshiftServer](#redshiftserver)
  - [S3Server](#s3server)
  - [Server](#server)
  - [ServerMixin](#servermixin)
  - [SftpServer](#sftpserver)
  - [SnowflakeServer](#snowflakeserver)
  - [SqlserverServer](#sqlserverserver)
  - [SynapseServer](#synapseserver)
  - [TrinoServer](#trinoserver)
  - [VerticaServer](#verticaserver)
  - [ZenServer](#zenserver)

## Schemas

### DataContract

A data contract defines the agreement between a data producer and consumers. This schema contains general information about the contract.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**apiVersion** `required`|str|Version of the standard used to build data contract.|"v3.1.0"|
|**authoritativeDefinitions**|[[AuthoritativeDefinition](#authoritativedefinition)]|List of links to sources that provide more details on the data contract.||
|**contractCreatedTs**|str|Timestamp in UTC of when the data contract was created, using ISO 8601.||
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|[Description](#description)|Object containing the descriptions.||
|**domain**|str|Name of the logical data domain.||
|**id** `required`|str|A unique identifier used to reduce the risk of dataset name collisions, such as a UUID.||
|**kind** `required`|str|The kind of file this is.|"DataContract"|
|**name**|str|Name of the data contract.||
|**price**|[[Pricing](#pricing)]|Pricing when you bill your customer for using this data product.||
|**roles**|[[Role](#role)]|A list of roles that will provide user access to the dataset.||
|**schema**|[[SchemaObject](#schemaobject)]|A list of objects within the schema to be cataloged.||
|**servers** `required`|[[Server](#server)]|List of servers where the datasets reside.||
|**slaProperties**|[[ServiceLevelAgreement](#servicelevelagreement)]|A list of key/value pairs for SLA specific properties. There is no limit on the type of properties.||
|**status** `required`|str|Current status of the data contract. Examples are "proposed", "draft", "active", "deprecated", "retired".||
|**support**|[[Support](#support)]|Top level for support channels.||
|**tags**|[str]|A list of tags that may be assigned to the elements (object or property); the tags keyword may appear at any level. For example, finance, sensitive, employee_record.||
|**team**|[[Team](#team)]|Team information object with members array.||
|**tenant**|str|Indicates the property the data is primarily associated with. Value is case insensitive.||
|**version** `required`|str|Current version of the data contract.||
#### Examples

```
contract = DataContract {
    id = "53581432-6c55-4ba2-a65f-72344a91553a"
    name = "seller_payments_v1"
    version = "1.1.0"
    status = "active"
    domain = "seller"
    tenant = "ClimateQuantumInc"

    authoritativeDefinitions = [
        AuthoritativeDefinition {
            url = "https://github.com/bitol-io/open-data-contract-standard/blob/main/docs/examples/all/full-example.odcs.yaml"
            $type = "canonicalUrl"
            description = "Data contract's latest version."
        }
    ]

    description = Description {
      purpose = "Views built on top of the seller tables."
      limitations = "Cannot be used in conjunction with days with full moons."
      usage = "Twice a day, preferable before meals."
    }

    tags = ["finance"]
}
```

### ArrayOptions

Additional metadata options to define the array type.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**maxItems**|int|Maximum number of items.||
|**minItems**|int|Minimum number of items.||
|**uniqueItems**|bool|If set to true, all items in the array are unique.||
### DatetimeOptions

Additional metadata options to define date, timestamp, and time types.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**defaultTimezone**|str|The default timezone of the timestamp. If timezone is not defined, the default timezone UTC is used.|"Z"|
|**exclusiveMaximum**|str|All values must be strictly less than this value (values &lt; exclusiveMaximum).||
|**exclusiveMinimum**|str|All values must be strictly greater than this value (values &gt; exclusiveMinimum).||
|**format**|str|Format of the date. Follows the format as prescribed by JDK DateTimeFormatter. Default value is using ISO 8601. For example, format "yyyy-MM-dd".|"YYYY-MM-DDTHH:mm:ss.SSSZ"|
|**maximum**|str|All date values are less than or equal to this value (values &lt;= maximum).||
|**minimum**|str|All date values are greater than or equal to this value (values &gt;= minimum).||
|**timezone**|bool|Whether the timestamp defines the timezone or not. If true, timezone information is included in the timestamp.||
#### Examples

```
dateOnly = SchemaProperty {
    name = "event_date"
    logicalType = "date"
    logicalTypeOptions = DatetimeOptions {
      format = "yyyy-MM-dd"
    }
    examples = ["2024-07-10"]
}

dateAndTimeUTC = SchemaProperty {
    name = "created_at"
    logicalType = "timestamp"
    logicalTypeOptions = DatetimeOptions {
        format = "yyyy-MM-ddTHH:mm:ssZ"
    }
    examples = ["2024-03-10T14:22:35Z"]
}

dateAndTimeAustraliaSydney = SchemaProperty {
    name = "created_at_sydney"
    logicalType = "timestamp"
    logicalTypeOptions = DatetimeOptions {
        format = "yyyy-MM-ddTHH:mm:ssZ"
        timezone = True
        defaultTimezone = "Australia/Sydney"
    }
    examples = ["2024-03-10T14:22:35+10:00"]
}

timeOnly = SchemaProperty {
    name = "event_start_time"
    logicalType = "time"
    logicalTypeOptions = DatetimeOptions {
        format = "HH:mm:ss"
    }
    examples = ["08:30:00"]
}

physicalDateAndTimeUTC = SchemaProperty {
    name = "event_date"
    logicalType = "timestamp"
    physicalType = "DATETIME"
    logicalTypeOptions = DatetimeOptions {
        format = "yyyy-MM-ddTHH:mm:ssZ"
    }
    examples = ["2024-03-10T14:22:35Z"]
}
```

### NumberOptions

Additional metadata options to define integer and number types.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**exclusiveMaximum**|int \| float|All values must be strictly less than this value (values &lt; exclusiveMaximum).||
|**exclusiveMinimum**|int \| float|All values must be strictly greater than this value (values &gt; exclusiveMinimum).||
|**format**|str|Format of the value in terms of how many bits of space it can use and whether it is signed or unsigned (follows the Rust integer types).||
|**maximum**|int \| float|All values are less than or equal to this value (values &lt;= maximum).||
|**minimum**|int \| float|All values are greater than or equal to this value (values &gt;= minimum).||
|**multipleOf**|int \| float|Values must be multiples of this number. For example, multiple of 5 has valid values 0, 5, 10, -5.||
### ObjectOptions

Additional metadata options to define integer and number types.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**maxProperties**|int|Maximum number of properties.||
|**minProperties**|int|Minimum number of properties.||
|**required**|[str]|Property names that are required to exist in the object.||
### RelationshipBase

Base definition for relationships between elements, typically for foreign key constraints."

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**to** `required`|str \| [str]|Target element reference using fully qualified or shorthand notation; Or an array of target elements for composite keys.||
|**type**|str|The type of relationship.|"foreignKey"|
### RelationshipPropertyLevel

Relationship definition at property level, where &#39;from&#39; is implicitly the current property.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**to** `required`|str \| [str]|Target element reference using fully qualified or shorthand notation; Or an array of target elements for composite keys.||
|**type**|str|The type of relationship.|"foreignKey"|
### RelationshipSchemaLevel

Relationship definition at schema level, requiring both &#39;from&#39; and &#39;to&#39; fields with matching types. Single-column relationship - both fields must be strings. Composite key relationship - both fields must be arrays with matching lengths.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**from** `required`|str \| [str]|Source object reference using fully qualified or shorthand notation; Or an array of source objects for composite keys.||
|**to** `required`|str \| [str]|Target element reference using fully qualified or shorthand notation; Or an array of target elements for composite keys.||
|**type**|str|The type of relationship.|"foreignKey"|
### SchemaElement

Schema element to be cataloged. Applicable to either Objects or Properties

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**authoritativeDefinitions**|[[AuthoritativeDefinition](#authoritativedefinition)]|List of links to sources that provide more details on the element; examples would be a link to privacy statement, terms and conditions, license agreements, data catalog, or another tool.||
|**businessName**|str|The business name of the element.||
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the element.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**name** `required`|str|Name of the element.||
|**physicalName**|str|Physical name.||
|**physicalType**|str|The physical element data type in the data source. For objects: table, view, topic, file. For properties: VARCHAR(2), DOUBLE, INT, etc.||
|**quality**|[[DataQuality](#dataquality)]|Data quality rules with all the relevant information for rule setup and execution.||
|**tags**|[str]|A list of tags that may be assigned to the elements (object or property); the tags keyword may appear at any level. For example, finance, sensitive, employee_record.||
### SchemaObject

Schema object to be cataloged. Objects are a structure of data: a table in a RDBMS system, a document in a NoSQL database, and so on.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**authoritativeDefinitions**|[[AuthoritativeDefinition](#authoritativedefinition)]|List of links to sources that provide more details on the element; examples would be a link to privacy statement, terms and conditions, license agreements, data catalog, or another tool.||
|**businessName**|str|The business name of the element.||
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**dataGranularityDescription**|str|Granular level of the data in the object. Example would be "Aggregation by country."||
|**description**|str|Description of the element.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**logicalType**|str|The logical object data type.|"object"|
|**name** `required`|str|Name of the element.||
|**physicalName**|str|Physical name.||
|**physicalType**|str|The physical element data type in the data source. For objects: table, view, topic, file. For properties: VARCHAR(2), DOUBLE, INT, etc.||
|**properties**|[[SchemaProperty](#schemaproperty)]|A list of properties for the object.||
|**quality**|[[DataQuality](#dataquality)]|Data quality rules with all the relevant information for rule setup and execution.||
|**relationships**|[[RelationshipSchemaLevel](#relationshipschemalevel)]|A list of relationships to other objects. Each relationship must have &#39;from&#39;, &#39;to&#39; and optionally &#39;type&#39; field.||
|**tags**|[str]|A list of tags that may be assigned to the elements (object or property); the tags keyword may appear at any level. For example, finance, sensitive, employee_record.||
#### Examples

```
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
```

### SchemaProperty

Schema property to be cataloged. Properties are attributes of an object: a column in a table, a field in a payload, and so on.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**authoritativeDefinitions**|[[AuthoritativeDefinition](#authoritativedefinition)]|List of links to sources that provide more details on the element; examples would be a link to privacy statement, terms and conditions, license agreements, data catalog, or another tool.||
|**businessName**|str|The business name of the element.||
|**classification**|str|Can be anything, like confidential, restricted, and public to more advanced categorization.||
|**criticalDataElement**|bool|If element is considered a critical data element (CDE) then true else false.|False|
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the element.||
|**encryptedName**|str|The element name within the dataset that contains the encrypted element value. For example, unencrypted element email_address might have an encryptedName of email_address_encrypt.||
|**examples**|[]|List of `any` sample element values.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**items**|[SchemaPropertyItems](#schemapropertyitems)|A list of properties for the property.||
|**logicalType**|str|The logical property data type. One of string, date, timestamp, time, number, integer, object, array or boolean.||
|**logicalTypeOptions**|[TypeOptions](#typeoptions)|Additional optional metadata to describe the logical type.||
|**name** `required`|str|Name of the element.||
|**partitionKeyPosition**|int|If element is used for partitioning, the position of the partition element. Starts from 1. Example of country, year being partition columns, country has partitionKeyPosition 1 and year partitionKeyPosition 2.|-1|
|**partitioned**|bool|Indicates if the element is partitioned.|False|
|**physicalName**|str|Physical name.||
|**physicalType**|str|The physical element data type in the data source. For objects: table, view, topic, file. For properties: VARCHAR(2), DOUBLE, INT, etc.||
|**primaryKey**|bool|Boolean value specifying whether the field is primary or not.|False|
|**primaryKeyPosition**|int|If field is a primary key, the position of the primary key element. Starts from 1. Example of account_id, name being primary key columns, account_id has primaryKeyPosition 1 and name primaryKeyPosition 2.|-1|
|**quality**|[[DataQuality](#dataquality)]|Data quality rules with all the relevant information for rule setup and execution.||
|**relationships**|[[RelationshipPropertyLevel](#relationshippropertylevel)]|A list of relationships to other properties. When defined at property level, the &#39;from&#39; field is implicit and should not be specified.||
|**required**|bool|Indicates if the element may contain Null values.|False|
|**tags**|[str]|A list of tags that may be assigned to the elements (object or property); the tags keyword may appear at any level. For example, finance, sensitive, employee_record.||
|**transformDescription**|str|Describes the transform logic in very simple terms.||
|**transformLogic**|str|Logic used in the column transformation.||
|**transformSourceObjects**|[str]|List of objects in the data source used in the transformation.||
|**unique**|bool|Indicates if the element contains unique values.|False|
#### Examples

```
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
```

### SchemaPropertyItems

The collection of items in an array. Only applicable when the schema property logicalType is array.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**properties** `required`|[[SchemaProperty](#schemaproperty)]|A list of properties for the object.||
### StringOptions

Additional metadata options to define the string type.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**format**|str|Provides extra context about what format the string follows. For example, password, byte, binary, email, uuid, uri, hostname, ipv4, ipv6.||
|**maxLength**|int|Maximum length of the string.||
|**minLength**|int|Minimum length of the string.||
|**pattern**|str|Regular expression pattern to define valid value. Follows regular expression syntax from ECMA-262 (https://262.ecma-international.org/5.1/#sec-15.10.1).||
### TimestampOptions

Additional metadata options to define timestamp and time types.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**defaultTimezone**|str|The default timezone of the timestamp. If timezone is not defined, the default timezone UTC is used.|"Z"|
|**timezone**|bool|Whether the timestamp defines the timezone or not. If true, timezone information is included in the timestamp.||
### TypeOptions

Base type for every logical type options.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**defaultTimezone**|str|The default timezone of the timestamp. If timezone is not defined, the default timezone UTC is used.|"Z"|
|**exclusiveMaximum**|str \| int \| float|Values must be strictly less than this value (values &lt; exclusiveMaximum).||
|**exclusiveMinimum**|str \| int \| float|Values must be strictly greater than this value (values &gt; exclusiveMinimum).||
|**format**|str|Format for date, number or string. For example, ISO 8601 date "yyyy-MM-dd", zero-padding number "{:05}", string "email".||
|**maxItems**|int|Maximum number of items for the array type.||
|**maxLength**|int|Maximum length of the string.||
|**maxProperties**|int|Maximum number of properties.||
|**maximum**|str \| int \| float|Values are less than or equal to this value (values &lt;= maximum).||
|**minItems**|int|Minimum number of items for the array type.||
|**minLength**|int|Minimum length of the string.||
|**minProperties**|int|Minimum number of properties.||
|**minimum**|str \| int \| float|Values are greater than or equal to this value (values &gt;= minimum).||
|**multipleOf**|int \| float|Values must be multiples of this number. For example, multiple of 5 has valid values 0, 5, 10, -5.||
|**pattern**|str|Regular expression pattern to define valid value. Follows regular expression syntax from ECMA-262 (https://262.ecma-international.org/5.1/#sec-15.10.1).||
|**required**|[str]|Property names that are required to exist in the object.||
|**timezone**|bool|Whether the timestamp defines the timezone or not. If true, timezone information is included in the timestamp.||
|**uniqueItems**|bool|If set to true, all items in the array are unique.||
#### Examples

```
dateOnly = SchemaProperty {
    name = "event_date"
    logicalType = "date"
    logicalTypeOptions = TypeOptions {
      format = "yyyy-MM-dd"
    }
    examples = ["2024-07-10"]
}

dateAndTimeUTC = SchemaProperty {
    name = "created_at"
    logicalType = "timestamp"
    logicalTypeOptions = TypeOptions {
        format = "yyyy-MM-ddTHH:mm:ssZ"
    }
    examples = ["2024-03-10T14:22:35Z"]
}

dateAndTimeAustraliaSydney = SchemaProperty {
    name = "created_at_sydney"
    logicalType = "timestamp"
    logicalTypeOptions = TypeOptions {
        format = "yyyy-MM-ddTHH:mm:ssZ"
        timezone = True
        defaultTimezone = "Australia/Sydney"
    }
    examples = ["2024-03-10T14:22:35+10:00"]
}

timeOnly = SchemaProperty {
    name = "event_start_time"
    logicalType = "time"
    logicalTypeOptions = TypeOptions {
        format = "HH:mm:ss"
    }
    examples = ["08:30:00"]
}

physicalDateAndTimeUTC = SchemaProperty {
    name = "event_date"
    logicalType = "timestamp"
    physicalType = "DATETIME"
    logicalTypeOptions = TypeOptions {
        format = "yyyy-MM-ddTHH:mm:ssZ"
    }
    examples = ["2024-03-10T14:22:35Z"]
}
```

### AuthoritativeDefinition

Authoritative Definitions are an essential part of the contract. They allow to delegate the definition to a third party system like an enterprise catalog, repository, etc. The structure describing "Authoritative Definitions" is shared between all Bitol standards.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**description**|str|Optional description.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**type** `required`|str|Type of definition for authority. Recommended values are: businessDefinition, transformationImplementation, videoTutorial, tutorial, and implementation. At the root level, a type can also be canonicalUrl to indicate a reference to the data contract&#39;s latest version.||
|**url** `required`|str|URL to the authority.||
#### Examples

```
datasetDefinitions = AuthoritativeDefinition {
    url = "https://catalog.data.gov/dataset/air-quality"
    type = "businessDefinition"
    description = "Business definition for the dataset."
}

videoTutorial = AuthoritativeDefinition {
    url = "https://www.youtube.com/watch?v=Iq6SxdsIHHE"
    $type = "videoTutorial"
    description = "Discover what a data contract is."
}

odcsVersion = AuthoritativeDefinition {
    url = "https://github.com/bitol-io/open-data-contract-standard/blob/main/docs/examples/all/full-example.odcs.yaml"
    $type = "canonicalUrl"
    description = "Data contract's latest version."
```

### CustomProperty

This section covers custom properties you can use to add non-standard properties. This block is available in many sections.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**escription**|str|||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**property**|str|The name of the key.||
|**value**|any|The value of the key. It can be an array.||
#### Examples

```
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
```

### OptionalStableIdMixin

Optional `id` property reference mixin.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
### Description

Object containing the data contract description.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**limitations**|str|Technical, compliance, and legal limitations for data use.||
|**purpose**|str|Intended purpose for the provided data.||
|**usage**|str|Recommended usage of the data.||
#### Examples

```
description = Description {
    purpose = "Views built on top of the seller tables."
    limitations = "Cannot be used in conjunction with days with full moons."
    usage = "Twice a day, preferable before meals."
    customProperties = [
        CustomProperty = {
            property = "publish"
            value = True
        }
    ]
}
```

### Pricing

This section covers pricing when you bill your customer for using this data product.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**priceAmount**|str|||
|**priceCurrency**|str|Currency of the subscription price in `price.priceAmount`.||
|**priceUnit**|str|The unit of measure for calculating cost. Examples megabyte, gigabyte.||
#### Examples

```
price = Pricing {
    priceAmount = "9.95"
    priceCurrency = "USD"
    priceUnit = "megabyte"
}
```

### ServiceLevelAgreement

This section describes the service-level agreements (SLA).

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**description**|str|Description of the SLA for humans.||
|**driver**|str|Describes the importance of the SLA from the list of: `regulatory`, `analytics`, or `operational`.||
|**element**|str|Element(s) to check on. Multiple elements should be extremely rare and, if so, separated by commas.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**property** `required`|str|Specific property in SLA, check the [Data QoS periodic table](https://medium.com/data-mesh-learning/what-is-data-qos-and-why-is-it-critical-c524b81e3cc1). May requires units.||
|**schedule**|str|Configuration information for the scheduling tool, for cron a possible value is `0 20 * * *`.||
|**scheduler**|str|Name of the scheduler, can be cron or any tool your organization support.||
|**unit**|str|Units use the ISO standard. For example: **d**, day, days for days; **y**, yr, years for years, etc.||
|**value** `required`|any|Agreement value. The label will change based on the property itself.||
|**valueExt**|str|Extended agreement value. The label will change based on the property itself.||
#### Examples

```
latency = ServiceLevelAgreement {
    id = "latency_4_days"
    property = "latency"
    value = 4
    unit = "d # d, day, days for days; y, yr, years for years"
    element = "tab1.txn_ref_dt"
    scheduler = "cron"
    schedule = "0 30 * * *"
}

availability = ServiceLevelAgreement {
    id = "main_ga"
    property = "generalAvailability"
    value = "2022-05-12T09:30:10-08:00"
    description = "GA at 12.5.22"
}

regulatory = ServiceLevelAgreement {
    id = "reg_toa"
    property = "timeOfAvailability"
    value = "09:00-08:00"
    element = "tab1.txn_ref_dt"
    driver = "regulatory"
}

analytics = = ServiceLevelAgreement {
    id = "analytics_toa"
    property = "timeOfAvailability"
    value = "08:00-08:00"
    element = "tab1.txn_ref_dt"
    driver = "analytics"
}
```

### Support

Support and communication channels help consumers find help regarding their use of the data contract.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**channel** `required`|str|Channel name or identifier.||
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the channel, free text.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**invitationUrl**|str|Some tools uses invitation URL for requesting or subscribing. Follows the [URL scheme](https://en.wikipedia.org/wiki/URL#Syntax).||
|**scope**|str|Scope can be: `interactive`, `announcements`, `issues`, `notifications`.||
|**tool**|str|Name of the tool, value can be `email`, `slack`, `teams`, `discord`, `ticket`, `googlechat`, or `other`.||
|**url**|str|Access URL using normal [URL scheme](https://en.wikipedia.org/wiki/URL#Syntax) (https, mailto, etc.).||
#### Examples

```
announcements = Support {
    id = "all_announcements"
    channel = "channel-name-or-identifier-for-all-announcement"
    description = "All announcement for all data contracts"
    tool = "teams"
    scope = "announcements"
    url = "https://bitol.io/teams/channel/all-announcements"
}

email = Support {
    id = "email_announcements"
    channel = "channel-name-or-identifier"
    tool = "email"
    scope = "announcements"
    url = "mailto:datacontract-ann@bitol.io"
}

ticket = Support {
    id = "ticket_support"
    channel = "channel-name-or-identifier"
    tool = "ticket"
    url = "https://bitol.io/ticket/my-product"
}
```

### Role

Role that a consumer may need to access the dataset, depending on the type of access they require.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**access**|str|The type of access provided by the IAM role.||
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the IAM role and its permissions.||
|**firstLevelApprovers**|str|The name(s) of the first-level approver(s) of the role.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**role** `required`|str|Name of the IAM role that provides access to the dataset.||
|**secondLevelApprovers**|str|The name(s) of the second-level approver(s) of the role.||
#### Examples

```
reader = Role {
    id = "bq_queryman_user_opr"
    role = "bq_queryman_user_opr"
    access = "read"
    firstLevelApprovers = "Reporting Manager"
    secondLevelApprovers = "na"
}

writer = Role {
    id = "bq_unica_user_opr"
    role = "bq_unica_user_opr"
    access = "write"
    firstLevelApprovers = "Reporting Manager"
    secondLevelApprovers = "mickey"
}
```

### Team

Team information.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**authoritativeDefinitions**|[[AuthoritativeDefinition](#authoritativedefinition)]|List of links to sources that provide more details on the data contract.||
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Team description.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**members**|[[TeamMember](#teammember)]|List of members.||
|**name**|str|Team name.||
|**tags**|[str]|A list of tags that may be assigned to the elements (object or property); the tags keyword may appear at any level. For example, finance, sensitive, employee_record.||
#### Examples

```
team = Team {
    id = "sc_team"
    name = "TSC"
    description = "The greatest team ever."
    members = [
        TeamMember {
            username = "ceastwood"
            role = "Data Scientist"
            dateIn = "2022-08-02"
            dateOut = "2022-10-01"
            replacedByUsername = "mhopper"
        },
        TeamMember {
            id = "mhopper_member"
            username = "mhopper"
            role = "Data Scientist"
            dateIn = "2022-10-01"
        },
        TeamMember {
            id = "daustin"
            username = "daustin"
            role = "Owner"
            description = "Keeper of the grail"
            name = "David Austin"
            dateIn = "2022-10-01"
        }
    ]
}
```

### TeamMember

Team member.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**authoritativeDefinitions**|[[AuthoritativeDefinition](#authoritativedefinition)]|List of links to sources that provide more details on the data contract.||
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**dateIn**|str|The date when the user joined the team.||
|**dateOut**|str|The date when the user ceased to be part of the team.||
|**description**|str|The user&#39;s description.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**name**|str|The user&#39;s name.||
|**replacedByUsername**|str|The username of the user who replaced the previous user.||
|**role**|str|The user&#39;s job role; Examples might be owner, data steward. There is no limit on the role.||
|**tags**|[str]|A list of tags that may be assigned to the elements (object or property); the tags keyword may appear at any level. For example, finance, sensitive, employee_record.||
|**username** `required`|str|The user&#39;s username or email.||
### DataQuality

Data quality rule with all the relevant information for setup and execution.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**arguments**|str|Additional arguments for the metric, if needed.||
|**authoritativeDefinitions**|[[AuthoritativeDefinition](#authoritativedefinition)]|List of links to sources that provide more details on the data contract.||
|**businessImpact**|str|Consequences of the rule failure.||
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Describe the quality check to be completed.||
|**dimension**|str|The key performance indicator (KPI) or dimension for data quality. Valid values are listed after the table.||
|**engine**|str|Required for `custom` DQ rule: name of the engine which executes the data quality checks. For example, `soda`, `great-expectations`, `monte-carlo`, `dbt`.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**implementation**|str|A text (non-parsed) block of code required for the third-party DQ engine to run.||
|**method**|str|Values are open and include `reconciliation`.||
|**metric**|str|Define a data quality check based on the predefined metrics as per ODCS. For example, `nullValues`, `missingValues`, `invalidValues`, `duplicateValues`, `rowCount`.||
|**mustBe**|any|Must be equal to the value to be valid. When using numbers, it is equivalent to &#39;=&#39;.||
|**mustBeBetween**|[int \| float]|Must be between the two numbers to be valid. Smallest number first in the array.||
|**mustBeGreaterOrEqualTo**|int \| float|Must be greater than or equal to the value to be valid. It is equivalent to &#39;&gt;=&#39;.||
|**mustBeGreaterThan**|int \| float|Must be greater than the value to be valid. It is equivalent to &#39;&gt;&#39;.||
|**mustBeLessOrEqualTo**|int \| float|Must be less than or equal to the value to be valid. It is equivalent to &#39;&lt;=&#39;.||
|**mustBeLessThan**|int \| float|Must be less than the value to be valid. It is equivalent to &#39;&lt;&#39;.||
|**mustBeNotBetween**|[int \| float]|Must not be between the two numbers to be valid. Smallest number first in the array.||
|**mustNotBe**|any|Must not be equal to the value to be valid. When using numbers, it is equivalent to &#39;!=&#39;.||
|**name**|str|Name of the data quality check.||
|**query**|str|Required for `sql` DQ rules: the SQL query to be executed. Note that it should match the target SQL engine/database, no transalation service are provided here.||
|**schedule**|str|Configuration information for the scheduling tool, for cron a possible value is `0 20 * * *`.||
|**scheduler**|str|Name of the scheduler, can be `cron` or any tool your organization support.||
|**severity**|str|The severity of the DQ rule.||
|**tags**|[str]|A list of tags that may be assigned to the elements (object or property); the tags keyword may appear at any level. For example, finance, sensitive, employee_record.||
|**type**|"library" \| "sql" \| "text" \| "custom"|The type of quality check. `text` is human-readable text that describes the quality of the data. `library` is a set of maintained predefined quality attributes such as row count or unique. `sql` is an individual SQL query that returns a value that can be compared. `custom` is quality attributes that are vendor-specific, such as Soda or Great Expectations.|"library"|
|**unit**|str|Unit the rule is using, popular values are `rows` or `percent`, but any value is allowed.||
#### Examples

```
noNullID = DataQuality {
    id = "order_id_no_nulls"
    metric = "nullValues"
    mustBe = 0
    description = "There must be no null values in the column."
}

percentNullStatus = DataQuality {
    id = "order_status_null_percent"
    metric = "nullValues"
    mustBeLessThan = 1
    unit = "percent"
    description = "There must be less than 1% null values in the column."
}
```

### MustBeBetweenMixin

Data quality operator mixin `mustBeBetween`

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**mustBeBetween**|[int \| float]|Must be between the two numbers to be valid. Smallest number first in the array.||
### MustBeGreaterOrEqualToMixin

Data quality operator mixin `mustBeGreaterOrEqualTo`

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**mustBeGreaterOrEqualTo**|int \| float|Must be greater than or equal to the value to be valid. It is equivalent to &#39;&gt;=&#39;.||
### MustBeGreaterThanMixin

Data quality operator mixin `mustBeGreaterThan`

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**mustBeGreaterThan**|int \| float|Must be greater than the value to be valid. It is equivalent to &#39;&gt;&#39;.||
### MustBeLessOrEqualToMixin

Data quality operator mixin `mustBeLessOrEqualTo`

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**mustBeLessOrEqualTo**|int \| float|Must be less than or equal to the value to be valid. It is equivalent to &#39;&lt;=&#39;.||
### MustBeLessThanMixin

Data quality operator mixin `mustBeLessThan`

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**mustBeLessThan**|int \| float|Must be less than the value to be valid. It is equivalent to &#39;&lt;&#39;.||
### MustBeMixin

Data quality operator mixin `mustBe`

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**mustBe**|any|Must be equal to the value to be valid. When using numbers, it is equivalent to &#39;=&#39;.||
### MustBeNotBetweenMixin

Data quality operator mixin `mustBeNotBetween`

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**mustBeNotBetween**|[int \| float]|Must not be between the two numbers to be valid. Smallest number first in the array.||
### MustNotBeMixin

Data quality operator mixin `mustNotBe`

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**mustNotBe**|any|Must not be equal to the value to be valid. When using numbers, it is equivalent to &#39;!=&#39;.||
### ApiServer

API Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**location** `required`|str|The URL to the API, For example, `https://api.example.com/v1`||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### AthenaServer

AWS Athena Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**catalog**|str|Identify the name of the Data Source, also referred to as a Catalog.|"awsdatacatalog"|
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**regionName**|str|The region your AWS account uses. For example, `eu-west-1`||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**schema** `required`|str|Identify the schema in the data source in which your tables exist.||
|**server** `required`|str|Identifier of the server.||
|**stagingDir** `required`|str|Amazon Athena automatically stores query results and metadata information for each query that runs in a query result location that you can specify in Amazon S3. For example, `s3://my_storage_account_name/my_container/path`.||
### AzureServer

Azure Blob Storage Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**delimiter**|str|Only for format = json. How multiple json documents are delimited within one file. For example, `new_line`, `array`.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**format** `required`|str|File format. For example, `parquet`, `delta`, `json`, `csv`.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**location** `required`|str|Fully qualified path to Azure Blob Storage or Azure Data Lake Storage (ADLS), supports globs. For example, `az://my_storage_account_name.blob.core.windows.net/my_container/path/*.parquet`, `abfss://my_storage_account_name.dfs.core.windows.net/my_container_name/path/*.parquet`.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### BigQueryServer

Google BigQuery Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**dataset** `required`|str|The GCP dataset name.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**project** `required`|str|The GCP project name.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### ClickHouseServer

ClickHouse Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|The name of the database.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The host of the ClickHouse server.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port** `required`|int|The port to the ClickHouse server.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### CustomServer

Custom server properties

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**account**|str|Account used by the server.||
|**catalog**|str|Name of the catalog.||
|**database**|str|Name of the database.||
|**dataset**|str|Name of the dataset.||
|**delimiter**|str|Delimiter.||
|**endpointUrl**|str|Server endpoint.||
|**format**|str|File format.||
|**host**|str|Host name or IP address.||
|**location**|str|A URL to a location.||
|**path**|str|Relative or absolute path to the data file(s).||
|**port**|int|Port to the server. No default value is assumed for custom servers.||
|**project**|str|Project name.||
|**region**|str|Cloud region.||
|**regionName**|str|Region name.||
|**schema**|str|Name of the schema.||
|**serviceName**|str|Name of the service.||
|**stagingDir**|str|Staging directory.||
|**stream**|str|Name of the cluster or warehouse.||
|**warehouse**|str|Name of the data stream.||
### DatabricksServer

Databricks Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**catalog** `required`|str|The name of the Hive or Unity catalog.||
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host**|str|The Databricks host. For example, `dbc-abcdefgh-1234.cloud.databricks.com`.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**schema** `required`|str|The schema name in the catalog.||
|**server** `required`|str|Identifier of the server.||
### DenodoServer

Denodo Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database**|str|The name of the database.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The host of the Denodo server.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port** `required`|int|The port of the Denodo server.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### DremioServer

Dremio Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The host of the Dremio server.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port** `required`|int|The port of the Dremio server.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**schema**|str|The name of the schema.||
|**server** `required`|str|Identifier of the server.||
### DuckdbServer

DuckDB Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|Path to duckdb database file.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**schema**|str|The name of the schema.||
|**server** `required`|str|Identifier of the server.||
### GlueServer

AWS Glue Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**account** `required`|str|The AWS Glue account. For example, `1234-5678-9012`.||
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|The AWS Glue database name. For example, `my_database`.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**format**|str|The format of the files. For example, `parquet`, `csv`, `json`, `delta`.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**location**|str|The AWS S3 path. Must be in the form of a URL. For example, `s3://datacontract-example-orders-latest/data/{model}`.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### GoogleCloudSqlServer

Google Cloud Sql Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|The name of the database.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The host of the Google Cloud Sql server.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port** `required`|int|The port of the Google Cloud Sql server.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**schema** `required`|str|The name of the schema.||
|**server** `required`|str|Identifier of the server.||
### HiveServer

Apache Hive Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|The name of the Hive database.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The host to the Hive server.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port**|int|The port to the Hive server. Defaults to 10000.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### IBMDB2Server

IBM DB2 Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|The name of the database.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The host of the IBM DB2 server.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port** `required`|int|The port of the IBM DB2 server.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**schema**|str|The name of the schema.||
|**server** `required`|str|Identifier of the server.||
### ImpalaServer

Apache Impala Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|The name of the Impala database.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The host to the Impala server.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port**|int|The port to the Impala server. Defaults to 21050.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### InformixServer

IBM Informix Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|The name of the database.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The host to the Informix server.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port**|int|The port to the Informix server. Defaults to 9088.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### KafkaServer

Apache Kafka Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**format**|str|The format of the messages. For example, `json`, `avro`, `protobuf`, `xml`.|"json"|
|**host** `required`|str|The bootstrap server of the kafka cluster.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### KinesisServer

AWS Kinesis Data Streams Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**format**|str|The format of the record. For example, `json`, `avro`, `protobuf`.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**region**|str|AWS region. For example, `eu-west-1`.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### LocalServer

Local File Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**format** `required`|str|The format of the file(s). For example, `json`, `parquet`, `delta`, `csv`.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**path** `required`|str|The relative or absolute path to the data file(s). For example, `./folder/data.parquet`, `./folder/*.parquet`.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### MySqlServer

MySQL Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|The name of the database.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The host of the MySql server.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port** `required`|int|The port of the MySql server.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### OracleServer

Oracle Database Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The host to the oracle server. For example, `localhost`.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port** `required`|int|The port to the oracle server. For example, `1523`.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
|**serviceName** `required`|str|The name of the service. For example, `service`.||
### PostgresServer

PostgreSQL Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|The name of the database.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The host to the Postgres server.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port** `required`|int|The port to the Postgres server.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**schema** `required`|str|The name of the schema in the database.||
|**server** `required`|str|Identifier of the server.||
### PrestoServer

Presto Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**catalog**|str|The name of the catalog. For example, `postgres`.||
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The host to the Presto server. For example, `localhost:8080`.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**schema**|str|The name of the schema. For example, `public`.||
|**server** `required`|str|Identifier of the server.||
### PubSubServer

Google Cloud Pub/Sub Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**project** `required`|str|The GCP project name.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### RedshiftServer

Amazon Redshift Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**account**|str|The account used by the server.||
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|The name of the database.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host**|str|An optional string describing the server.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**region**|str|AWS region of Redshift server. For example, `us-east-1`.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**schema** `required`|str|The name of the schema.||
|**server** `required`|str|Identifier of the server.||
### S3Server

Amazon S3 Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**delimiter**|str|Only for format = json. How multiple json documents are delimited within one file. For example, `new_line`, `array`.||
|**description**|str|Description of the server.||
|**endpointUrl**|str|The server endpoint for S3-compatible servers. For example, `https://minio.example.com`.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**format**|str|File format. For example, `parquet`, `delta`, `json`, `csv`.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**location** `required`|str|S3 URL, starting with `s3://`. For example, `s3://datacontract-example-orders-latest/data/{model}/*.json`.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### Server

General Server Structure.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**account**|str|Account used by the server.||
|**catalog**|str|Name of the catalog.||
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database**|str|Name of the database.||
|**dataset**|str|Name of the dataset.||
|**delimiter**|str|Delimiter.||
|**description**|str|Description of the server.||
|**endpointUrl**|str|Server endpoint.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**format**|str|File format.||
|**host**|str|Host name or IP address.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**location**|str|A URL to a location.||
|**path**|str|Relative or absolute path to the data file(s).||
|**port**|int|Port to the server. No default value is assumed for custom servers.||
|**project**|str|Project name.||
|**region**|str|Cloud region.||
|**regionName**|str|Region name.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**schema**|str|Name of the schema.||
|**server** `required`|str|Identifier of the server.||
|**serviceName**|str|Name of the service.||
|**stagingDir**|str|Staging directory.||
|**stream**|str|Name of the cluster or warehouse.||
|**type** `required`|str|Type of the server. Can be one of: api, athena, azure, bigquery, clickhouse, cloudsql, custom, databricks, db2, denodo, dremio, duckdb, glue, hive, impala, informix, kafka, kinesis, local, mysql, oracle, postgres, postgresql, presto, pubsub, redshift, s3, sftp, snowflake, sqlserver, synapse, trino, vertica, zen.|"custom"|
|**warehouse**|str|Name of the data stream.||
#### Examples

```
server = Server {
    id = "my_awesome_server"
    server = "my-server-name"
    type = "<server-type>"
    description = "<server-description>"
    environment = "<server-environment>"
    ...
    <server-type-specific-fields> # according to the server type, see below
    ...
    roles = [
      <role-details>
      ...
    ]
    customProperties = [
      <custom-properties>
      ...
    ]
}
```

### ServerMixin

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### SftpServer

SFTP Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**delimiter**|str|Only for format = json. How multiple json documents are delimited within one file. For example, `new_line`, `array`.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**format**|str|File format. For example, `parquet`, `delta`, `json`, `csv`.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**location** `required`|str|SFTP URL, starting with `sftp://`. For example, `sftp://123.123.12.123/{model}/*.json`.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### SnowflakeServer

Snowflake Data Warehouse Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**account** `required`|str|The Snowflake account used by the server.||
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|The name of the database.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host**|str|The host to the Snowflake server.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port**|int|The port to the Snowflake server.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**schema** `required`|str|The name of the schema.||
|**server** `required`|str|Identifier of the server.||
|**warehouse**|str|The name of the cluster of resources that is a Snowflake virtual warehouse.||
### SqlserverServer

Microsoft SQL Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|The name of the database. For example, `database`.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The host to the database server. For example, `localhost`.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port**|int|The port to the database server. For example, `1433`.|1433|
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**schema** `required`|str|The name of the schema in the database. For example, `dbo`.||
|**server** `required`|str|Identifier of the server.||
### SynapseServer

Azure Synapse Analytics Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|The name of the database.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The host of the Synapse server.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port** `required`|int|The port of the Synapse server.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
### TrinoServer

Trino Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**catalog** `required`|str|The name of the catalog. For example, `hive`.||
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The Trino host URL. For example, `localhost`.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port** `required`|int|The Trino port.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**schema** `required`|str|The name of the schema in the database. For example, `my_schema`.||
|**server** `required`|str|Identifier of the server.||
### VerticaServer

Vertica Database Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|The name of the database.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|The host of the Vertica server.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port** `required`|int|The port of the Vertica server.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**schema** `required`|str|The name of the schema.||
|**server** `required`|str|Identifier of the server.||
### ZenServer

Zen Server.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|A list of key/value pairs for custom properties.||
|**database** `required`|str|Database name to connect to on the Zen server.||
|**description**|str|Description of the server.||
|**environment**|str|Environment of the server. Examples includes: prod, preprod, dev, uat.||
|**host** `required`|str|Hostname or IP address of the Zen server.||
|**id**|str|Stable technical identifier for references. Must be unique within its containing array. Cannot contain special characters (&#39;-&#39;, &#39;_&#39; allowed).||
|**port**|int|Zen server SQL connections port. Defaults to 1583.||
|**roles**|[[Role](#role)]|List of roles that have access to the server.||
|**server** `required`|str|Identifier of the server.||
<!-- Auto generated by kcl-doc tool, please do not edit. -->
