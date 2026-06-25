import .catalog.object as so
import .contract.description as desc
import .contract.pricing as pr
import .contract.sla as sla
import .contract.support as su
import .common.authoritative as ad
import .common.property as prop
import .iam.role as ir
import .iam.team as it

schema DataContract:
    """
    A data contract defines the agreement between a data producer and consumers.
    This schema contains general information about the contract.

    Attributes
    ----------
    apiVersion : str, default is "v3.1.0", required.
        Version of the standard used to build data contract.
    kind: str, default is "DataContract", required.
        The kind of file this is.
    id: str, default is Undefined, required.
        A unique identifier used to reduce the risk of dataset name collisions, such as a UUID.
    name: str, default is Undefined, optional.
        Name of the data contract.
    version: str, default is Undefined, required.
        Current version of the data contract.
    status: str, default is Undefined, required.
        Current status of the data contract. Examples are "proposed", "draft", "active", "deprecated", "retired".
    tenant: str, default is Undefined, optional.
        Indicates the property the data is primarily associated with. Value is case insensitive.
    tags: [str], default is Undefined, optional.
        A list of tags that may be assigned to the elements (object or property); the tags keyword may appear at any level. For example, finance, sensitive, employee_record.
    domain: str, default is Undefined, optional.
        Name of the logical data domain.
    authoritativeDefinitions: [ad.AuthoritativeDefinition], default is Undefined, optional.
        List of links to sources that provide more details on the data contract.
    description: desc.Description, default is Undefined, optional.
        Object containing the descriptions.
    customProperties: [prop.CustomProperty], default is Undefined, optional.
        A list of key/value pairs for custom properties.
    contractCreatedTs: str, default is Undefined, optional.
        Timestamp in UTC of when the data contract was created, using ISO 8601.
    schema: [so.SchemaObject], default is Undefined, optional.
        A list of objects within the schema to be cataloged.
    support: [su.Support], default is Undefined, optional.
        Top level for support channels.
    price: [pr.Pricing], default is Undefined, optional.
        Pricing when you bill your customer for using this data product.
    team: [it.Team], default is Undefined, optional.
        Team information object with members array.
    roles: [ir.Role], default is Undefined, optional.
        A list of roles that will provide user access to the dataset.
    slaProperties: [sla.ServiceLevelAgreement], default is Undefined, optional.
        A list of key/value pairs for SLA specific properties. There is no limit on the type of properties.

    Examples:
    ---------
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

    """
    apiVersion: str = "v3.1.0"
    kind: str = "DataContract"
    id: str
    name?: str
    version: str
    status: str
    tenant?: str
    tags?: [str]
    domain?: str
    authoritativeDefinitions?: [ad.AuthoritativeDefinition]
    description?: desc.Description
    customProperties?: [prop.CustomProperty]
    contractCreatedTs?: str
    $schema?: [so.SchemaObject]
    support?: [su.Support]
    price?: [pr.Pricing]
    team?: [it.Team]
    roles?: [ir.Role]
    slaProperties?: [sla.ServiceLevelAgreement]

