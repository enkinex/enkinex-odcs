import .common as srv

schema SqlserverServer:
    """
    Microsoft SQL Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the database server. For example, `localhost`.
    database: str, default is Undefined, required.
        The name of the database. For example, `database`.
    schema: str, default is Undefined, required.
        The name of the schema in the database. For example, `dbo`.
    port: int, default is 1433, optional.
        The port to the database server. For example, `1433`.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "sqlserver"
    host: str
    database: str
    $schema: str
    port?: int = 1433
