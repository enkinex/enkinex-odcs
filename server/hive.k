import .spec as server

schema HiveServer(server.Server):
    """
    Apache Hive Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the Hive server.
    database: str, default is Undefined, required.
        The name of the Hive database.
    port: Port, default is 10000, optional.
        The port to the Hive server.

    Examples
    --------
    hive = HiveServer {
        server = "hive-warehouse"
        host = "hive.acme.internal"
        database = "sales"
    }
    """
    $type = "hive"
    host: str
    database: str
    port?: server.Port = 10000
