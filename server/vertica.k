import .spec as server

schema VerticaServer(server.Server):
    """
    Vertica Database Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host of the Vertica server.
    port: Port, default is Undefined, required.
        The port of the Vertica server.
    database: str, default is Undefined, required.
        The name of the database.
    schema: str, default is Undefined, required.
        The name of the schema.

    Examples
    --------
    vertica = VerticaServer {
        server = "vertica-sales"
        host = "vertica.acme.internal"
        port = 5433
        database = "sales"
        $schema = "public"
    }
    """
    $type = "vertica"
    host: str
    port: server.Port
    database: str
    $schema: str
