import .spec as server

schema SqlserverServer(server.Server):
    """
    Microsoft SQL Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the database server.
        Examples: "localhost"
    database: str, default is Undefined, required.
        The name of the database.
        Examples: "database"
    schema: str, default is Undefined, required.
        The name of the schema in the database.
        Examples: "dbo"
    port: Port, default is 1433, optional.
        The port to the database server.
        Examples: "1433"

    Examples
    --------
    sqlserver = SqlserverServer {
        server = "sqlserver-sales"
        host = "sqlserver.acme.internal"
        database = "sales"
        $schema = "dbo"
    }
    """
    $type = "sqlserver"
    host: str
    database: str
    $schema: str
    port?: server.Port = 1433
