import .spec as server

schema PrestoServer(server.Server):
    """
    Presto Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host to the Presto server.
        Examples: "localhost:8080"
    catalog: str, default is Undefined, optional.
        The name of the catalog.
        Examples: "postgres"
    schema: str, default is Undefined, optional.
        The name of the schema.
        Examples: "public"

    Examples
    --------
    presto = PrestoServer {
        server = "presto-lake"
        host = "presto.acme.internal:8080"
        catalog = "hive"
        $schema = "sales"
    }
    """
    $type = "presto"
    host: str
    catalog?: str
    $schema?: str
