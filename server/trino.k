import .spec as server

schema TrinoServer(server.Server):
    """
    Trino Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The Trino host URL.
        Examples: "localhost"
    port: Port, default is Undefined, required.
        The Trino port.
    catalog: str, default is Undefined, required.
        The name of the catalog.
        Examples: "hive"
    schema: str, default is Undefined, required.
        The name of the schema in the database.
        Examples: "my_schema"

    Examples
    --------
    trino = TrinoServer {
        server = "trino-lakehouse"
        host = "trino.acme.internal"
        port = 443
        catalog = "lakehouse"
        $schema = "sales"
    }
    """
    $type = "trino"
    host: str
    port: server.Port
    catalog: str
    $schema: str
