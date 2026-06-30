import .mixins
import .property

schema AuthoritativeDefinition(mixins.StableIdObject):
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
        $type = "businessDefinition"
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
    }
    """
    $type: str
    url: str
    description?: str

    check:
        len(url) > 0, "url must not be empty"

schema CatalogedObject(property.CustomPropertiesObject):
    """
    Base object carrying the optional catalog properties shared by cataloged
    elements: `tags` and `authoritativeDefinitions` (and, via the chain,
    `customProperties` and `id`). Used as a base class so all of these are
    recognized by KCL dict→schema coercion.

    Attributes
    ----------
    tags: [str], default is Undefined, optional.
        A list of tags that may be assigned to the elements (object or property).
        The tags keyword may appear at any level.
        Examples: "finance", "sensitive", "employee_record"
    authoritativeDefinitions: [AuthoritativeDefinition], default is Undefined, optional.
        List of links to sources that provide more details on the element.
        Examples: Link to privacy statement, terms and conditions, license agreements, data catalog, or another tool.
    """
    tags?: [str]
    authoritativeDefinitions?: [AuthoritativeDefinition]

