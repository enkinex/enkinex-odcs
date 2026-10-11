import .spec as server

schema GoogleCloudSqlServer(server.Server):
    """
    Google Cloud Sql Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host of the Google Cloud Sql server.
    port: Port, default is Undefined, required.
        The port of the Google Cloud Sql server.
    database: str, default is Undefined, required.
        The name of the database.
    schema: str, default is Undefined, required.
        The name of the schema.

    Examples
    --------
    cloudsql = GoogleCloudSqlServer {
        server = "cloudsql-sales"
        host = "10.20.0.5"
        port = 5432
        database = "sales"
        $schema = "public"
    }
    """
    $type = "cloudsql"
    host: str
    port: server.Port
    database: str
    $schema: str
