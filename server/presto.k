import .common as srv

schema PrestoServer:
    """
    Presto Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the Presto server. For example, `localhost:8080`.
    catalog: str, default is Undefined, optional.
        The name of the catalog. For example, `postgres`.
    schema: str, default is Undefined, optional.
        The name of the schema. For example, `public`.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "presto"
    host: str
    catalog?: str
    $schema?: str

