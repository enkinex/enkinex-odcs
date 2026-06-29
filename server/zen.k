import .common as server

schema ZenServer:
    """
    Zen Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        Hostname or IP address of the Zen server.
    database: str, default is Undefined, required.
        Database name to connect to on the Zen server.
    port: int, default is 1583, optional.
        Zen server SQL connections port.
    """
    mixin [
        server.ServerMixin
    ]
    $type = "zen"
    host: str
    database: str
    port?: int = 1583

