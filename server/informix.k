import .common as srv

schema InformixServer:
    """
    IBM Informix Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the Informix server.
    database: str, default is Undefined, required.
        The name of the database.
    port: int, default is Undefined, optional.
        The port to the Informix server. Defaults to 9088.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "informix"
    host: str
    database: str
    port?: int

