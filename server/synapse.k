import .spec as server

schema SynapseServer(server.Server):
    """
    Azure Synapse Analytics Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host of the Synapse server.
    port: Port, default is Undefined, required.
        The port of the Synapse server.
    database: str, default is Undefined, required.
        The name of the database.

    Examples
    --------
    synapse = SynapseServer {
        server = "synapse-sales"
        host = "acme.sql.azuresynapse.net"
        port = 1433
        database = "sales"
    }
    """
    $type = "synapse"
    host: str
    port: server.Port
    database: str
