import .spec as server

schema PoetServer(server.Server):
    """
    Actian NoSQL FastObjects (POET) Server. `type: fastobjects` is a synonym validated by the same rule.

    Attributes
    ----------
    database: str, default is Undefined, required.
        Database name to connect to on the FastObjects instance.
        Examples: "parts_catalog"
    host: str, default is "LOCAL", optional.
        Hostname or IP address of the FastObjects server. The literal LOCAL selects the in-process embedded engine.
        Examples: "LOCAL", "fastobjects02.acme.com"
    port: Port, default is 6001, optional.
        Connection port for FastObjects connections.

    Examples
    --------
    poet = PoetServer {
        server = "poet-parts"
        database = "parts_catalog"
        host = "fastobjects02.acme.com"
    }
    """
    $type = "poet"
    database: str
    host?: str = "LOCAL"
    port?: server.Port = 6001
