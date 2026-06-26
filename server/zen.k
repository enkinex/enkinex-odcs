import .common as srv

schema ZenServer:
    """
    Zen Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        Hostname or IP address of the Zen server.
    database: str, default is Undefined, required.
        Database name to connect to on the Zen server.
    port: int, default is Undefined, optional.
        Zen server SQL connections port. Defaults to 1583.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "zen"
    host: str
    database: str
    port?: int
