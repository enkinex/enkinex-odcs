import .spec as server

schema VersantServer(server.Server):
    """
    Actian NoSQL Database (Versant) Server.

    Attributes
    ----------
    database: str, default is Undefined, required.
        Database name to connect to on the NoSQL Database instance.
        Examples: "policies"
    host: str, default is "localhost", optional.
        Hostname or IP address of the NoSQL Database server.
        Examples: "nosql.acme.com"
    port: Port, default is 5019, optional.
        Connection port for Actian NoSQL Database connections.

    Examples
    --------
    versant = VersantServer {
        server = "versant-policies"
        database = "policies"
        host = "nosql.acme.com"
    }
    """
    $type = "versant"
    database: str
    host?: str = "localhost"
    port?: server.Port = 5019
