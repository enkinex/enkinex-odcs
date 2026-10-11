import .spec as server

schema IBMDB2Server(server.Server):
    """
    IBM DB2 Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host of the IBM DB2 server.
    port: Port, default is Undefined, required.
        The port of the IBM DB2 server.
    database: str, default is Undefined, required.
        The name of the database.
    schema: str, default is Undefined, optional.
        The name of the schema.

    Examples
    --------
    db2 = IBMDB2Server {
        server = "db2-sales"
        host = "db2.acme.internal"
        port = 50000
        database = "SALES"
        $schema = "ORDERS"
    }
    """
    $type = "db2"
    host: str
    port: server.Port
    database: str
    $schema?: str
