import .spec as server

schema InformixServer(server.Server):
    """
    IBM Informix Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the Informix server.
    database: str, default is Undefined, required.
        The name of the database.
    port: Port, default is 9088, optional.
        The port to the Informix server.

    Examples
    --------
    informix = InformixServer {
        server = "informix-sales"
        host = "informix.acme.internal"
        database = "sales"
    }
    """
    $type = "informix"
    host: str
    database: str
    port?: server.Port = 9088
