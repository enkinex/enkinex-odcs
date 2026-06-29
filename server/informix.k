import .common as server

schema InformixServer:
    """
    IBM Informix Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the Informix server.
    database: str, default is Undefined, required.
        The name of the database.
    port: int, default is 9088, optional.
        The port to the Informix server.
    """
    mixin [
        server.ServerMixin
    ]
    $type = "informix"
    host: str
    database: str
    port?: 9088

