import .spec as server

schema DuckdbServer(server.Server):
    """
    DuckDB Server.

    Attributes
    ----------
    database: str, default is Undefined, required.
        Path to duckdb database file.
    schema: str, default is Undefined, optional.
        The name of the schema.

    Examples
    --------
    duckdb = DuckdbServer {
        server = "duckdb-local"
        database = "/data/sales.duckdb"
        $schema = "main"
    }
    """
    $type = "duckdb"
    database: str
    $schema?: str
