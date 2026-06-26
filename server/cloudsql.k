import .common as srv

schema GoogleCloudSqlServer:
    """
    Google Cloud Sql Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host of the Google Cloud Sql server.
    port: int, default is Undefined, required.
        The port of the Google Cloud Sql server.
    database: str, default is Undefined, required.
        The name of the database.
    schema: str, default is Undefined, required.
        The name of the schema.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "cloudsql"
    host: str
    port: int
    database: str
    $schema: str

