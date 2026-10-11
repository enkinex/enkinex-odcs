import .spec as server

schema VectorwiseServer(server.Server):
    """
    Actian Vector (Vectorwise) Analytics Engine Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        Hostname or IP address of the Analytics Engine server.
        Examples: "analytics.acme.com"
    database: str, default is Undefined, required.
        Database name to connect to on the Analytics Engine server.
        Examples: "warehouse"
    port: Port, default is 21064, optional.
        Connection port for the Data Access Server (DAS) / SQL connections.

    Examples
    --------
    vectorwise = VectorwiseServer {
        server = "vectorwise-analytics"
        host = "analytics.acme.com"
        database = "warehouse"
    }
    """
    $type = "vectorwise"
    host: str
    database: str
    port?: server.Port = 21064
