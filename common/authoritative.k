import .mixins

schema AuthoritativeDefinition:
    """
    Authoritative Definitions are an essential part of the contract.
    They allow to delegate the definition to a third party system like an enterprise catalog, repository, etc.
    The structure describing "Authoritative Definitions" is shared between all Bitol standards.

    Attributes
    ----------
    type: str, default is Undefined, required.
        Type of definition for authority.
        At the root level, a type can also be canonicalUrl to indicate a reference to the data contract's latest version.
        Examples: "businessDefinition", "transformationImplementation", "videoTutorial", "tutorial", "implementation".
    url: str, default is Undefined, required.
        URL to the authority.
    description: str, default is Undefined, optional.
        Optional description.

    Examples
    --------
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
    """
    mixin [
        mixins.StableIdMixin
    ]
    $type: str
    url: str
    description?: str

mixin AuthoritativeDefinitionsMixin:
    """
    Optional `authoritativeDefinitions` property mixin.

    Attributes
    ----------
    authoritativeDefinitions: [AuthoritativeDefinition], default is Undefined, optional.
        List of links to sources that provide more details on the element.
        Examples: Link to privacy statement, terms and conditions, license agreements, data catalog, or another tool.
    """
    authoritativeDefinitions?: [AuthoritativeDefinition]

