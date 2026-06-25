schema AuthoritativeDefinition:
    """
    Authoritative Definitions are an essential part of the contract.
    They allow to delegate the definition to a third party system like an enterprise catalog, repository, etc.
    The structure describing "Authoritative Definitions" is shared between all Bitol standards.

    Attributes
    ----------
    id: str, default is Undefined, optional.
        A unique identifier for the element used to create stable, refactor-safe references. Recommended for elements that will be referenced.
    type: str, default is Undefined, required.
        Type of definition for authority. Recommended values are: businessDefinition, transformationImplementation, videoTutorial, tutorial, and implementation. At the root level, a type can also be canonicalUrl to indicate a reference to the data contract's latest version.
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
    id?: str
    $type: str
    url: str
    description?: str
