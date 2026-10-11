import .spec as server

schema MySqlServer(server.Server):
    """
    MySQL Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host of the MySql server.
    port: Port, default is Undefined, required.
        The port of the MySql server.
    database: str, default is Undefined, required.
        The name of the database.

    Examples
    --------
    mysql = MySqlServer {
        server = "mysql-sales"
        host = "mysql.acme.internal"
        port = "3306"
        database = "sales"
    }
    """
    $type = "mysql"
    host: str
    port: server.Port
    database: str
