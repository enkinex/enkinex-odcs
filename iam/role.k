import ..common.id as id
import ..common.property as prop

schema Role:
    """
    Role that a consumer may need to access the dataset, depending on the type of access they require.

    Attributes
    ----------
    id: str, default is Undefined, optional.
        A unique identifier for the element used to create stable, refactor-safe references. Recommended for elements that will be referenced.
    role: str, default is Undefined, required.
        Name of the IAM role that provides access to the dataset.
    description: str, default is Undefined, optional.
        Description of the IAM role and its permissions.
    access: str, default is Undefined, optional.
        The type of access provided by the IAM role.
    firstLevelApprovers: str, default is Undefined, optional.
        The name(s) of the first-level approver(s) of the role.
    secondLevelApprovers: str, default is Undefined, optional.
        The name(s) of the second-level approver(s) of the role.
    customProperties: [prop.CustomProperty], default is Undefined, optional.
        A list of key/value pairs for custom properties.

    Examples
    --------
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
    """
    mixin [
        id.OptionalStableIdMixin
    ]
    role: str
    description?: str
    access?: str
    firstLevelApprovers?: str
    secondLevelApprovers?: str
    customProperties?: [prop.CustomProperty]

