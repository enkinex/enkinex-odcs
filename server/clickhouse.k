import .spec as server

schema ClickHouseServer(server.Server):
    """
    ClickHouse Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host of the ClickHouse server.
    port: Port, default is Undefined, required.
        The port to the ClickHouse server.
    database: str, default is Undefined, required.
        The name of the database.

    Examples
    --------
    clickhouse = ClickHouseServer {
        server = "clickhouse-events"
        host = "clickhouse.acme.internal"
        port = 9000
        database = "events"
    }
    """
    $type = "clickhouse"
    host: str
    port: server.Port
    database: str
