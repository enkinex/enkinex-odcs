import .spec as server

schema TeradataServer(server.Server):
    """
    Teradata Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        Host of the Teradata server.
        Examples: "teradata.acme.com"
    port: Port, default is 1025, optional.
        Port of the Teradata server.
    database: str, default is Undefined, optional.
        Name of the database.

    Examples
    --------
    teradata = TeradataServer {
        server = "teradata-edw"
        host = "teradata.acme.com"
        database = "sales"
    }
    """
    $type = "teradata"
    host: str
    port?: server.Port = 1025
    database?: str
