import .common as srv

schema ImpalaServer:
    """
    Apache Impala Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the Impala server.
    database: str, default is Undefined, required.
        The name of the Impala database.
    port: int, default is Undefined, optional.
        The port to the Impala server. Defaults to 21050.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "impala"
    host: str
    database: str
    port?: int

