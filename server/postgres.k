import .common as srv

schema PostgresServer:
    """
    PostgreSQL Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the Postgres server.
    port: int, default is Undefined, required.
        The port to the Postgres server.
    database: str, default is Undefined, required.
        The name of the database.
    schema: str, default is Undefined, required.
        The name of the schema in the database.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "postgres"
    host: str
    port: int
    database: str
    $schema: str

