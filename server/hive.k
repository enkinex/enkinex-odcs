import .common as srv

schema HiveServer:
    """
    Apache Hive Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the Hive server.
    database: str, default is Undefined, required.
        The name of the Hive database.
    port: int, default is Undefined, optional.
        The port to the Hive server. Defaults to 10000.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "hive"
    host: str
    database: str
    port?: int

