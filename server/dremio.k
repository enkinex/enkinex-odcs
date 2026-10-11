import .spec as server

schema DremioServer(server.Server):
    """
    Dremio Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host of the Dremio server.
    port: Port, default is Undefined, required.
        The port of the Dremio server.
    schema: str, default is Undefined, optional.
        The name of the schema.

    Examples
    --------
    dremio = DremioServer {
        server = "dremio-lake"
        host = "dremio.acme.internal"
        port = 31010
        $schema = "sales"
    }
    """
    $type = "dremio"
    host: str
    port: server.Port
    $schema?: str
