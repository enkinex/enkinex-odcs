import .common as server

schema OracleServer:
    """
    Oracle Database Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the oracle server.
        Examples: "localhost"
    port: int, default is Undefined, required.
        The port to the oracle server.
        Examples: "1523"
    serviceName: str, default is Undefined, required.
        The name of the service.
        Examples: "service"
    """
    mixin [
        server.ServerMixin
    ]
    $type = "oracle"
    host: str
    port: int
    serviceName: str

