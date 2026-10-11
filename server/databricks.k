import .spec as server

schema DatabricksServer(server.Server):
    """
    Databricks Server.

    Attributes
    ----------
    catalog: str, default is Undefined, required.
        The name of the Hive or Unity catalog.
    schema: str, default is Undefined, required.
        The schema name in the catalog.
    host: str, default is Undefined, optional.
        The Databricks host.
        Examples: "dbc-abcdefgh-1234.cloud.databricks.com"

    Examples
    --------
    databricks = DatabricksServer {
        server = "databricks-lakehouse"
        host = "adb-1234567890123456.7.azuredatabricks.net"
        catalog = "main"
        $schema = "sales"
    }
    """
    $type = "databricks"
    catalog: str
    $schema: str
    host?: str
