import .custom

import ..common.minixs as mix
import ..common.property as prop
import ..iam.role as ir

mixin ServerMixin:
    """
    Attributes
    ----------
    server: str, default is Undefined, required.
        Identifier of the server.
    description: str, default is Undefined, optional.
        Description of the server.
    environment: str, default is Undefined, optional.
        Environment of the server. Examples includes: prod, preprod, dev, uat.
    roles: [ir.Role], default is Undefined, optional.
        List of roles that have access to the server.
    customProperties: [prop.CustomProperty], default is Undefined, optional.
        A list of key/value pairs for custom properties.
    """
    mixin [
        mix.OptionalStableIdMixin
    ]
    server: str
    description?: str
    environment?: str
    roles?: [ir.Role]
    customProperties?: [prop.CustomProperty]

schema Server(custom.CustomServer):
    """
    General Server Structure.

    Attributes
    ----------
    type: str, default is "custom", required.
        Type of the server. Can be one of: api, athena, azure, bigquery, clickhouse, cloudsql, custom, databricks, db2, denodo, dremio, duckdb, glue, hive, impala, informix, kafka, kinesis, local, mysql, oracle, postgres, postgresql, presto, pubsub, redshift, s3, sftp, snowflake, sqlserver, synapse, trino, vertica, zen.

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
    $type: str = "custom"

