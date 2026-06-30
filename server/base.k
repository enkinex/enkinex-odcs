import ..common.property
import ..iam.role

schema ServerObject(property.CustomPropertiesObject):
    """
    Base object carrying the server properties common to every server type
    (plus `id` and `customProperties` via the chain). Declared as a base
    class so the attributes are recognized by KCL dict→schema coercion
    (mixin attributes are not). Per-type server schemas and the permissive
    `Server` extend this.

    Attributes
    ----------
    server: str, default is Undefined, required.
        Identifier of the server.
    description: str, default is Undefined, optional.
        Description of the server.
    environment: str, default is Undefined, optional.
        Environment of the server.
        Examples: "prod", "preprod", "dev", "uat"
    roles: [role.Role], default is Undefined, optional.
        List of roles that have access to the server.
    """
    server: str
    description?: str
    environment?: str
    roles?: [role.Role]
