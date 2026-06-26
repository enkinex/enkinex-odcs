import .common as srv

schema DremioServer:
    """
    Dremio Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host of the Dremio server.
    port: int, default is Undefined, required.
        The port of the Dremio server.
    schema: str, default is Undefined, optional.
        The name of the schema.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "dremio"
    host: str
    port: int
    $schema?: str

