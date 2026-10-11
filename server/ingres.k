import .spec as server

schema IngresServer(server.Server):
    """
    Actian Ingres Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        Hostname or IP address of the Ingres server.
        Examples: "ingres.acme.com"
    database: str, default is Undefined, required.
        Database name to connect to on the Ingres instance.
        Examples: "sales"
    port: Port, default is 21064, optional.
        Connection port for the Ingres Data Access Server (DAS) / SQL connections.

    Examples
    --------
    ingres = IngresServer {
        server = "ingres-sales"
        host = "ingres.acme.com"
        database = "sales"
    }
    """
    $type = "ingres"
    host: str
    database: str
    port?: server.Port = 21064
