# enkinex-odcs

## Index

- [DataContract](#datacontract)
- [Description](#description)
- common
  - [AuthoritativeDefinition](#authoritativedefinition)
  - [CustomProperty](#customproperty)

## Schemas

### DataContract

A data contract defines the agreement between a data producer and consumers. This schema contains general information about the contract.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**apiVersion** `required`|str|Version of the standard used to build data contract.|"v3.1.0"|
|**authoritativeDefinitions**|[[AuthoritativeDefinition](#authoritativedefinition)]|List of links to sources that provide more details on the data contract.||
|**contractCreatedTs**|str|Timestamp in UTC of when the data contract was created, using ISO 8601.||
|**description**|[Description](#description)|Object containing the descriptions.||
|**domain**|str|Name of the logical data domain.||
|**id** `required`|str|A unique identifier used to reduce the risk of dataset name collisions, such as a UUID.||
|**kind** `required`|str|The kind of file this is.|"DataContract"|
|**name**|str|Name of the data contract.||
|**status** `required`|str|Current status of the data contract. Examples are "proposed", "draft", "active", "deprecated", "retired".||
|**tags**|[str]|A list of tags that may be assigned to the elements (object or property); the tags keyword may appear at any level. Tags may be used to better categorize an element. For example, finance, sensitive, employee_record.||
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

Object containing the descriptions.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**customProperties**|[[CustomProperty](#customproperty)]|Custom properties that are not part of the standard.||
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
            property = "materialize"
            value = True
        }
    ]
}
```

### AuthoritativeDefinition

Authoritative Definitions are an essential part of the contract. They allow to delegate the definition to a third party system like an enterprise catalog, repository, etc. The structure describing "Authoritative Definitions" is shared between all Bitol standards.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**description**|str|Optional description.||
|**id**|str|A unique identifier for the element used to create stable, refactor-safe references. Recommended for elements that will be referenced.||
|**type** `required`|str|||
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
```

<!-- Auto generated by kcl-doc tool, please do not edit. -->
