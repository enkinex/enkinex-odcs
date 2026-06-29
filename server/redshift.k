import .common as server

schema RedshiftServer:
    """
    Amazon Redshift Server.

    Attributes
    ----------
    database: str, default is Undefined, required.
        The name of the database.
    schema: str, default is Undefined, required.
        The name of the schema.
    host: str, default is Undefined, optional.
        An optional string describing the server.
    region: str, default is Undefined, optional.
        AWS region of Redshift server.
        Examples: "us-east-1"
    account: str, default is Undefined, optional.
        The account used by the server.
    """
    mixin [
        server.ServerMixin
    ]
    $type = "redshift"
    database: str
    $schema: str
    host?: str
    region?: str
    account?: str

