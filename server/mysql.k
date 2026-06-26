import .common as srv

schema MySqlServer:
    """
    MySQL Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host of the MySql server.
    port: int, default is Undefined, required.
        The port of the MySql server.
    database: str, default is Undefined, required.
        The name of the database.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "mysql"
    host: str
    port: int
    database: str

