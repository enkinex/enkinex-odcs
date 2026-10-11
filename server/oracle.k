import .spec as server

schema OracleServer(server.Server):
    """
    Oracle Database Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the oracle server.
        Examples: "localhost"
    port: Port, default is Undefined, required.
        The port to the oracle server.
        Examples: "1523"
    serviceName: str, default is Undefined, required.
        The name of the service.
        Examples: "service"

    Examples
    --------
    oracle = OracleServer {
        server = "oracle-sales"
        host = "oracle.acme.internal"
        port = 1521
        serviceName = "SALESPDB"
    }
    """
    $type = "oracle"
    host: str
    port: server.Port
    serviceName: str
