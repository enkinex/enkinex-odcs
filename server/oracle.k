import .common as srv

schema OracleServer:
    """
    Oracle Database Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the oracle server. For example, `localhost`.
    port: int, default is Undefined, required.
        The port to the oracle server. For example, `1523`.
    serviceName: str, default is Undefined, required.
        The name of the service. For example, `service`.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "oracle"
    host: str
    port: int
    serviceName: str

