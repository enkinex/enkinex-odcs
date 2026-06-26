import .common as srv

schema TrinoServer:
    """
    Trino Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The Trino host URL. For example, `localhost`.
    port: int, default is Undefined, required.
        The Trino port.
    catalog: str, default is Undefined, required.
        The name of the catalog. For example, `hive`.
    schema: str, default is Undefined, required.
        The name of the schema in the database. For example, `my_schema`.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "trino"
    host: str
    port: int
    catalog: str
    $schema: str
