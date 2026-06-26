import .common as srv

schema SynapseServer:
    """
    Azure Synapse Analytics Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host of the Synapse server.
    port: int, default is Undefined, required.
        The port of the Synapse server.
    database: str, default is Undefined, required.
        The name of the database.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "synapse"
    host: str
    port: int
    database: str
