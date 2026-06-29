import .common as server

schema DuckdbServer:
    """
    DuckDB Server.

    Attributes
    ----------
    database: str, default is Undefined, required.
        Path to duckdb database file.
    schema: str, default is Undefined, optional.
        The name of the schema.
    """
    mixin [
        server.ServerMixin
    ]
    $type = "duckdb"
    database: str
    $schema?: str

