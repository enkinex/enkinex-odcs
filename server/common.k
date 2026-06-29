import .custom

import ..common.mixins
import ..common.property
import ..iam.role

type ServerType = "api" | "athena" | "azure" | "bigquery" | "clickhouse" | "databricks" | "denodo" | "dremio" | "duckdb" | "glue" | "cloudsql" | "db2" | "hive" | "impala" | "informix" | "kafka" | "kinesis" | "local" | "mysql" | "oracle" | "postgresql" | "postgres" | "presto" | "pubsub" | "redshift" | "s3" | "sftp" | "snowflake" | "sqlserver" | "synapse" | "trino" | "vertica" | "zen" | "custom"

mixin ServerMixin:
    """
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
    mixin [
        mixins.StableIdMixin,
        property.CustomPropertiesMixin
    ]
    server: str
    description?: str
    environment?: str
    roles?: [role.Role]

schema Server(custom.CustomServer):
    """
    General Server Structure.

    Attributes
    ----------
    type: ServerType, default is "custom", required.
        Type of the server.

    Examples
    --------
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
    """
    mixin [
        ServerMixin
    ]
    $type: ServerType = "custom"

