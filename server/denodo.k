import .spec as server

schema DenodoServer(server.Server):
    """
    Denodo Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host of the Denodo server.
    port: Port, default is Undefined, required.
        The port of the Denodo server.
    database: str, default is Undefined, optional.
        The name of the database.

    Examples
    --------
    denodo = DenodoServer {
        server = "denodo-vdp"
        host = "denodo.acme.internal"
        port = 9999
        database = "sales"
    }
    """
    $type = "denodo"
    host: str
    port: server.Port
    database?: str
