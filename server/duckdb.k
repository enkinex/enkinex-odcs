import .common as srv

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
        srv.ServerMixin
    ]
    $type = "duckdb"
    database: str
    $schema?: str

