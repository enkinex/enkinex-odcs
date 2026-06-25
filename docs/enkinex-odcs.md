# enkinex-odcs

## Index

- [DataContract](#datacontract)
- [Description](#description)
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
|**schema**|[[SchemaObject](#schemaobject)]|A list of objects within the schema to be cataloged.||
|**status** `required`|str|Current status of the data contract. Examples are "proposed", "draft", "active", "deprecated", "retired".||
|**tags**|[str]|A list of tags that may be assigned to the elements (object or property); the tags keyword may appear at any level. For example, finance, sensitive, employee_record.||
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
|**id**|str|A unique identifier for the element used to create stable, refactor-safe references. Recommended for elements that will be referenced.||
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
|**id**|str|A unique identifier for the element used to create stable, refactor-safe references. Recommended for elements that will be referenced.||
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
|**id**|str|A unique identifier for the element used to create stable, refactor-safe references. Recommended for elements that will be referenced.||
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
<!-- Auto generated by kcl-doc tool, please do not edit. -->
