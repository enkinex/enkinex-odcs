import .common.authoritative
import .common.property

schema Description:
    """
    Object containing the descriptions.

    Attributes
    ----------
    purpose: str, default is Undefined, optional.
        Intended purpose for the provided data.
    limitations: str, default is Undefined, optional.
        Technical, compliance, and legal limitations for data use.
    usage: str, default is Undefined, optional.
        Recommended usage of the data.
    customProperties: [property.CustomProperty], default is Undefined, optional.
        Custom properties that are not part of the standard.

    Examples
    --------
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
    """
    purpose?: str
    limitations?: str
    usage?: str
    customProperties?: [property.CustomProperty]

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
        A list of tags that may be assigned to the elements (object or property); the tags keyword may appear at any level. Tags may be used to better categorize an element. For example, finance, sensitive, employee_record.
    domain: str, default is Undefined, optional.
        Name of the logical data domain.
    authoritativeDefinitions: [authoritative.AuthoritativeDefinition], default is Undefined, optional.
        List of links to sources that provide more details on the data contract.
    description: Description, default is Undefined, optional.
        Object containing the descriptions.
    contractCreatedTs: str, default is Undefined, optional.
        Timestamp in UTC of when the data contract was created, using ISO 8601.

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
    authoritativeDefinitions?: [authoritative.AuthoritativeDefinition]
    description?: Description
    contractCreatedTs?: str
