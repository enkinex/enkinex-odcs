import .spec as server

schema ImpalaServer(server.Server):
    """
    Apache Impala Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the Impala server.
    database: str, default is Undefined, required.
        The name of the Impala database.
    port: Port, default is 21050, optional.
        The port to the Impala server.

    Examples
    --------
    impala = ImpalaServer {
        server = "impala-warehouse"
        host = "impala.acme.internal"
        database = "sales"
    }
    """
    $type = "impala"
    host: str
    database: str
    port?: server.Port = 21050
