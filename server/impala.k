import .common as server

schema ImpalaServer:
    """
    Apache Impala Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the Impala server.
    database: str, default is Undefined, required.
        The name of the Impala database.
    port: int, default is 21050, optional.
        The port to the Impala server.
    """
    mixin [
        server.ServerMixin
    ]
    $type = "impala"
    host: str
    database: str
    port?: 21050

